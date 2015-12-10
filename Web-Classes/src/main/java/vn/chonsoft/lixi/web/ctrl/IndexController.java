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
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CategoriesBean;

/**
 *
 * @author chonnh
 */
@WebController
public class IndexController {

    private static final Logger log = LogManager.getLogger(IndexController.class);
    
    @Autowired
    private CategoriesBean categories;
    
    /**
     * 
     * @param model 
     * @return 
     */
    @RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Map<String, Object> model) {
        
        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        
        return "index";
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
        int height = 41;

        BufferedImage bufferedImage = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        Graphics2D g2d = bufferedImage.createGraphics();

        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, width, height);

        Font font = new Font("Comic Sans MS", Font.BOLD, 30);
        g2d.setFont(font);

        GradientPaint gp = new GradientPaint(0, 0,
                Color.BLUE, 0, height / 2, Color.LIGHT_GRAY, true);

        g2d.setPaint(gp);

        // Generate and replaces all "empty substrings" with a space, and then trims off the leading / trailing spaces.
        String captcha = RandomStringUtils.randomAlphabetic(4);
        // add spaces to enough width
        String captchaDraw = captcha.replace("", " ").trim();

        request.getSession().setAttribute("captcha", captcha.toLowerCase());

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
}
