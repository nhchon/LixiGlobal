/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CategoriesBean;
import vn.chonsoft.lixi.web.beans.LoginedUser;

/**
 *
 * @author chonnh
 */
@WebController
public class IndexController {

    private static final Logger log = LogManager.getLogger(IndexController.class);
    
    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private CategoriesBean categories;
    
    @Autowired
    private LixiExchangeRateService xrService;
    
    @Autowired
    private VatgiaProductService vgpSer;
    
    /**
     * 
     * @param model
     * @param request 
     * @return 
     */
    @RequestMapping(value = "/403.html", method = RequestMethod.GET)
    public String status403(Map<String, Object> model, HttpServletRequest request) {
        
        String referer = request.getHeader("referer");
        log.info("referer: " + referer);
        
        // jump to /Administration/login
        if(!StringUtils.isEmpty(referer)){
            if(referer.contains("/Administration/")){
                return "403_admin";
            }
        }
        
        // user login page
        return "403";
    }

    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "/403.html", method = RequestMethod.POST)
    public ModelAndView status403Post(Map<String, Object> model) {
        
        return new ModelAndView(new RedirectView("/403.html", true, true));
        
    }

    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "/sessionExpired", method = {RequestMethod.GET, RequestMethod.POST})
    public String sessionExpired(Map<String, Object> model) {
        
        if(!StringUtils.isEmpty(loginedUser.getEmail())){
            model.put("sessionExpired", "0");
        }
        else{
            model.put("sessionExpired", "1");
        }
        
        return "sessionExpired";
    }

    /**
     * 
     * @param model 
     * @return 
     */
    @RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Map<String, Object> model) {
        
        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        
        //LixiExchangeRate lastXr = this.xrService.findLastRecord(LiXiConstants.USD);
        model.put("lastXr", this.xrService.findLastRecord(LiXiConstants.USD));
        
        return "index";
    }

    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "/whatIsLixi", method = {RequestMethod.GET, RequestMethod.POST})
    public String whatIsLixi(Map<String, Object> model) {

        String language = LocaleContextHolder.getLocale().getLanguage();
        String country = LocaleContextHolder.getLocale().getCountry().toUpperCase();
        
        return "customer/what-is-"+language+"_"+country;
    }
    
    /**
     *
     * for common header content
     *
     * @return
     */
    @RequestMapping(value = "/top", method = {RequestMethod.GET, RequestMethod.POST})
    public String top() {
        return "top";
    }

    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "/categories", method = {RequestMethod.GET, RequestMethod.POST})
    public String categoriesOnTop(Map<String, Object> model) {

        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        
        return "categories";
    }

    /**
     * 
     * @return 
     */
    @RequestMapping(value = "/registerPage", method = RequestMethod.GET)
    public String registerPage() {
        
        return "user/register";
        
    }
    /**
     *
     * for static footer content
     *
     * @return
     */
    @RequestMapping(value = "/bottom", method = {RequestMethod.GET, RequestMethod.POST})
    public String bottom() {
        return "bottom";
    }

    /**
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/captcha", method = RequestMethod.GET)
    public void captCha(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // set mime type as jpg image
        response.setContentType("image/jpg");
        ServletOutputStream out = response.getOutputStream();

        int width = 150;
        int height = 35;

        BufferedImage bufferedImage = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        Graphics2D g2d = bufferedImage.createGraphics();

        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, width, height);

        Font font = new Font("Comic Sans MS", Font.BOLD, 28);
        g2d.setFont(font);

        GradientPaint gp = new GradientPaint(0, 0,
                Color.BLUE, 0, height / 2, Color.LIGHT_GRAY, true);

        g2d.setPaint(gp);

        // Generate and replaces all "empty substrings" with a space, and then trims off the leading / trailing spaces.
        String captcha = RandomStringUtils.randomAlphabetic(4);
        // add spaces to enough width
        String captchaDraw = captcha.replace("", " ").trim();

        request.getSession().setAttribute("captcha", captcha);

        g2d.drawString(captchaDraw, 5, 30);

        g2d.dispose();

        // encode the image as a JPEG data stream and write the same to servlet output stream   
        ImageIO.write(bufferedImage, "jpg", out);
        //
        out.close();
    }

    /**
     * 
     * show 
     * @param request
     * @param response
     * @param name 
     */
    @RequestMapping(value = "/showImages/{name:.+}", method = RequestMethod.GET)
    public void showImages(HttpServletRequest request, HttpServletResponse response, @PathVariable("name") String name) {
        
        // gets absolute path of the web application
        String applicationPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String uploadFilePath = FilenameUtils.normalize(applicationPath + File.separator + LiXiConstants.WEB_INF_FOLDER + File.separator + LiXiConstants.CATEGORY_ICON_FOLDER + File.separator + name);
        String noImageFilePath = FilenameUtils.normalize(applicationPath + File.separator + LiXiConstants.WEB_INF_FOLDER + File.separator + LiXiConstants.CATEGORY_ICON_FOLDER + File.separator + "no_image.jpg");
        //System.out.println(uploadFilePath);
        //System.out.println(FilenameUtils.normalize(uploadFilePath));
        
        try {
            
            ServletOutputStream out = response.getOutputStream();
            BufferedImage image = null;
            File file = new File(uploadFilePath);
            
            if(file.isFile()){
                
                // set mime type as jpg image
                response.setContentType("image/" + FilenameUtils.getExtension(name));

                // the line that reads the image file
                image = ImageIO.read(file);

            }
            else{
                
                file = new File(noImageFilePath);
                // set mime type as jpg image
                response.setContentType("image/jpg");

                // the line that reads the image file
                image = ImageIO.read(file);

            }
            // write out stream
            ImageIO.write(image, FilenameUtils.getExtension(name), out);
            
        } catch (IOException e) {
            
            // todo: return safe photo instead
            log.info(e.getMessage(), e);
        }
    }
    
    @RequestMapping(value = "/loadProductImage/{id}", method = RequestMethod.GET)
    public void loadProductImage(@PathVariable("id") Integer id, HttpServletRequest request, HttpServletResponse response) {
        
        try {
            
            BufferedImage image = null;
            String extension = "jpg";
            
            try {
                VatgiaProduct p = this.vgpSer.findById(id);
                String imageUrl = p.getImageUrl();
                
                extension = FilenameUtils.getExtension(imageUrl);
                log.info("imageUrl: " + imageUrl);
                log.info("extension: " + extension);
                
                URL url = new URL(imageUrl);
                //image = ImageIO.read(new BufferedInputStream(url.openStream()));
                
                // set mime type as jpg image
                response.setContentType("image/" + extension);
                IOUtils.copy(url.openStream(), response.getOutputStream());
                
            } catch (IOException e) {
                log.info(e.getMessage(), e);
                
                // gets absolute path of the web application
                String applicationPath = request.getServletContext().getRealPath("");
                String noImageFilePath = FilenameUtils.normalize(applicationPath + File.separator + LiXiConstants.WEB_INF_FOLDER + File.separator + LiXiConstants.CATEGORY_ICON_FOLDER + File.separator + "no_image.jpg");
                File file = new File(noImageFilePath);

                // the line that reads the image file
                image = ImageIO.read(file);
                // set mime type as jpg image
                response.setContentType("image/jpg");
                // write out stream
                ImageIO.write(image, extension, response.getOutputStream());
            }
            
        } catch (IOException e) {
            // todo: return safe photo instead
            log.info(e.getMessage(), e);
        }
    }    
}
