/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.validation.ConstraintViolationException;
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
import vn.chonsoft.lixi.model.pojo.ListVatGiaCategoryPojo;
import vn.chonsoft.lixi.model.pojo.VatGiaCategoryPojo;
import vn.chonsoft.lixi.model.trader.ExchangeRate;
import vn.chonsoft.lixi.model.trader.Trader;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.ExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.SupportLocaleService;
import vn.chonsoft.lixi.repositories.service.TraderService;
import vn.chonsoft.lixi.repositories.service.VatgiaCategoryService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

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
    CurrencyTypeService currencyService;
    
    @Inject
    TraderService traderService;
    
    @Inject
    ExchangeRateService exrService;
    
    @Inject
    LixiExchangeRateService lxrService;
    
    @Inject
    VatgiaCategoryService vgcService;
    
    @Inject
    LixiCategoryService lxcService;
    
    @Inject
    SupportLocaleService slService;

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
        ListVatGiaCategoryPojo vgcpojos = LiXiUtils.getVatGiaCategory();

        for (VatGiaCategoryPojo vgcpojo : vgcpojos.getData()) {

            VatgiaCategory vgc = this.vgcService.findOne(vgcpojo.getId());
            if (vgc == null) {

                vgcs.add(LiXiUtils.convertFromPojo2Model(vgcpojo));

            } else {

                vgcs.add(vgc);

            }
        }

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

        //
        List<SupportLocale> sls = this.slService.findAll();
        List<LixiCategory> lixiCategoryList = new ArrayList<>();
        for (SupportLocale sl : sls) {

            String code = sl.getCode();
            String name = LiXiUtils.fixEncode(request.getParameter(code));
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
            
            try {
                
                lxc.setName(name);
                // for debug vietnamese on 112.213.86.84
                log.info("request encode: " + request.getCharacterEncoding());
                log.info("1: " + name);
                log.info("2: " + (new String(name.getBytes("UTF-8")))); 
                log.info("3: " + (new String(name.getBytes(), "UTF-8")));
                log.info("4: " + (new String(name.getBytes("ISO-8859-1"), "UTF-8")));
                
            } catch (Exception e) {
                
                log.info(e.getMessage(), e);
            }
            
            lxc.setCreatedDate(Calendar.getInstance().getTime());
            lxc.setCreatedBy(createdBy);
            lxc.setVatgiaId(vgc);
            lixiCategoryList.add(lxc);
        }

        vgc.setLixiCategoryList(lixiCategoryList);

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
        this.vgcService.delete(id);
        //
        return new ModelAndView(new RedirectView("/Administration/SystemConfig/categories", true, true));
    }
}
