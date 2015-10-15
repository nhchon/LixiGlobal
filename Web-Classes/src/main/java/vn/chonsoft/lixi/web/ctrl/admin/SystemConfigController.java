/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import javax.validation.Valid;
import javax.validation.ConstraintViolationException;
import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.SupportLocale;
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.model.form.LiXiExchangeRateForm;
import vn.chonsoft.lixi.model.pojo.ListVatGiaCategory;
import vn.chonsoft.lixi.model.pojo.VatGiaCategoryPj;
import vn.chonsoft.lixi.model.trader.ExchangeRate;
import vn.chonsoft.lixi.model.trader.Trader;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.ExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.SupportLocaleService;
import vn.chonsoft.lixi.repositories.service.TraderService;
import vn.chonsoft.lixi.repositories.service.VatgiaCategoryService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemConfig")
@PreAuthorize("hasAuthority('SYSTEM_CONFIG_CONTROLLER')")
public class SystemConfigController {

    private static final Logger log = LogManager.getLogger(SystemConfigController.class);

    @Inject
    private CurrencyTypeService currencyService;
    
    @Inject
    private TraderService traderService;
    
    @Inject
    private ExchangeRateService exrService;
    
    @Inject
    private LixiExchangeRateService lxrService;
    
    @Inject
    private VatgiaCategoryService vgcService;
    
    @Inject
    private LixiCategoryService lxcService;
    
    @Inject
    private SupportLocaleService slService;

    /**
     *
     * @return
     */
    private List<ExchangeRate> getLastERByTrader() {

        // list trader
        List<Trader> traders = this.traderService.findAll();
        // list exchange rate from traders
        List<ExchangeRate> exrs = new ArrayList<>();
        for (Trader trader : traders) {

            ExchangeRate exr = this.exrService.findLastERByTraderId(trader);

            if (exr != null) {

                exrs.add(exr);
            }
        }

        return exrs;
    }

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "lixiExchangeRate", method = RequestMethod.GET)
    public ModelAndView lixiExchangeRate(Map<String, Object> model) {

        model.put("liXiExchangeRateForm", new LiXiExchangeRateForm());
        model.put("CURRENCIES", this.currencyService.findAll());
        model.put("VCB", LiXiUtils.getVCBExchangeRates());
        model.put("EXCHANGE_RATES", getLastERByTrader());
        model.put("LIXI_EXCHANGE_RATES", this.lxrService.findAll());

        return new ModelAndView("Administration/config/lixiExchangeRate");

    }

    /**
     *
     * @param model
     * @param form
     * @param errors
     * @return
     */
    @RequestMapping(value = "lixiExchangeRate", method = RequestMethod.POST)
    public ModelAndView lixiExchangeRate(Map<String, Object> model,
            @Valid LiXiExchangeRateForm form, Errors errors) {

        if (errors.hasErrors()) {

            model.put("CURRENCIES", this.currencyService.findAll());
            model.put("VCB", LiXiUtils.getVCBExchangeRates());
            model.put("EXCHANGE_RATES", getLastERByTrader());
            model.put("LIXI_EXCHANGE_RATES", this.lxrService.findAll());

            return new ModelAndView("Administration/config/lixiExchangeRate");
        }

        try {

            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String createdBy = auth.getName(); //get logged in username

            LixiExchangeRate lixiexr = new LixiExchangeRate();
            lixiexr.setDateInput(form.getDateInput());
            // time input
            try {
                SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
                lixiexr.setTimeInput(timeFormat.parse(form.getTimeInput()));
            } catch (Exception e) {
            }
            lixiexr.setBuy(form.getBuy());
            lixiexr.setSell(form.getSell());
            lixiexr.setBuyPercentage(form.getBuyPercentage());
            lixiexr.setSellPercentage(form.getSellPercentage());
            lixiexr.setCurrency(this.currencyService.findOne(form.getCurrency()));
            lixiexr.setCreatedBy(createdBy);
            lixiexr.setCreatedDate(Calendar.getInstance().getTime());

            this.lxrService.save(lixiexr);

        } catch (ConstraintViolationException e) {

            //
            log.info(e.getMessage(), e);
            //
            model.put("validationErrors", e.getConstraintViolations());

        }

        model.put("liXiExchangeRateForm", new LiXiExchangeRateForm());
        model.put("CURRENCIES", this.currencyService.findAll());
        model.put("VCB", LiXiUtils.getVCBExchangeRates());
        model.put("EXCHANGE_RATES", getLastERByTrader());
        model.put("LIXI_EXCHANGE_RATES", this.lxrService.findAll());
        return new ModelAndView("Administration/config/lixiExchangeRate");
    }

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "categories", method = RequestMethod.GET)
    public ModelAndView categories(Map<String, Object> model) {

        //
        List<VatgiaCategory> vgcs = new ArrayList<>();
        // get category from BaoKim service
        ListVatGiaCategory vgcpojos = LiXiVatGiaUtils.getInstance().getVatGiaCategory();

        for (VatGiaCategoryPj vgcpojo : vgcpojos.getData()) {

            VatgiaCategory vgc = this.vgcService.findOne(vgcpojo.getId());
            if (vgc == null) {

                vgcs.add(LiXiVatGiaUtils.getInstance().convertFromPojo2Model(vgcpojo));

            } else {

                vgcs.add(vgc);

            }
        }
        // sort vat gia category
        Collections.sort(vgcs, VatgiaCategory.VatgiaCategoryComparator);
        
        // 
        model.put("VATGIA_CATEGORIES", vgcs);
        model.put("SUPPORT_LOCALE", this.slService.findAll());

        return new ModelAndView("Administration/config/categories");

    }

    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "categories", method = RequestMethod.POST)
    public ModelAndView saveCategories(HttpServletRequest request) {

        // 
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String createdBy = auth.getName(); //get logged in username
        
        //
        VatgiaCategory vgc = new VatgiaCategory();
        vgc.setId(Integer.parseInt(request.getParameter("vgId")));
        vgc.setTitle(request.getParameter("vgName"));
        vgc.setActivated(LiXiConstants.LIXI_ACTIVATED);
        Integer sortOrder = Integer.parseInt(request.getParameter("sortOrder"));
        vgc.setSortOrder(sortOrder);
        //
        List<SupportLocale> sls = this.slService.findAll();
        List<LixiCategory> lixiCategories = new ArrayList<>();
        for (SupportLocale sl : sls) {

            String code = sl.getCode();
            String name = request.getParameter(code);
            // if name is empty, we do nothing
            if(name == null || "".equals(name)){
                
                return new ModelAndView(new RedirectView("/Administration/SystemConfig/categories", true, true));
                
            }
            String idStr = request.getParameter(code+"-id");
            
            LixiCategory lxc = new LixiCategory();
            // set id for update if we have
            if(idStr!=null && !"".equals(idStr.trim())){
                lxc.setId(Integer.parseInt(idStr));
            }
            
            lxc.setLocale(sl);
            lxc.setName(name);
            lxc.setActivated(LiXiConstants.LIXI_ACTIVATED);
            lxc.setSortOrder(sortOrder);
            
            // handle upload icon
            // gets absolute path of the web application
            String applicationPath = request.getServletContext().getRealPath("");
            // constructs path of the directory to save uploaded file
            String uploadFilePath = applicationPath + File.separator + LiXiConstants.WEB_INF_FOLDER + File.separator + LiXiConstants.CATEGORY_ICON_FOLDER;
            // creates the save directory if it does not exists
            File fileSaveDir = new File(uploadFilePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdirs();
            }
            
            //log.info("Upload File Directory="+fileSaveDir.getAbsolutePath());
         
            try {
                
                Part filePart = request.getPart("img-"+code); // Retrieves <input type="file" name="img-${code}">
                if(filePart != null){
                    
                    String fileName = filePart.getSubmittedFileName();
                    
                    if(fileName != null && !"".equals(fileName)){
                        
                        String ext = FilenameUtils.getExtension(fileName);
                        String newFileName = System.currentTimeMillis() + "." + ext;

                        filePart.write(uploadFilePath + File.separator + newFileName);

                        lxc.setIcon(newFileName);
                    }
                    else{
                        
                        // keep old file
                        String oldFile = request.getParameter("img-old-"+code);
                        if(oldFile != null && !"".equals(oldFile)){
                            
                            lxc.setIcon(oldFile);
                        }
                        else{
                            // no image
                            lxc.setIcon(LiXiConstants.NO_IMAGE_JPG);
                        }
                    }
                }
                else{
                    // no image
                    lxc.setIcon(LiXiConstants.NO_IMAGE_JPG);
                }
            } catch (Exception e) {
                
                // no icon
                lxc.setIcon(LiXiConstants.NO_IMAGE_JPG);
                
            }
            //
            lxc.setCreatedDate(Calendar.getInstance().getTime());
            lxc.setCreatedBy(createdBy);
            lxc.setVatgiaId(vgc);
            lixiCategories.add(lxc);
        }

        vgc.setLixiCategories(lixiCategories);

        //
        this.vgcService.save(vgc);
        //
        return new ModelAndView(new RedirectView("/Administration/SystemConfig/categories", true, true));
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @RequestMapping(value = "categories/del/{id}", method = RequestMethod.GET)
    public ModelAndView deleteCategory(@PathVariable("id") Integer id){
        
        //
        VatgiaCategory vgc = this.vgcService.findOne(id);
        
        // update non activated status
        vgc.setActivated(LiXiConstants.LIXI_NON_ACTIVATED);
        
        for(LixiCategory lxc : vgc.getLixiCategories()){
            lxc.setActivated(LiXiConstants.LIXI_NON_ACTIVATED);
        }
        
        this.vgcService.save(vgc);
        //
        return new ModelAndView(new RedirectView("/Administration/SystemConfig/categories", true, true));
    }
}
