/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.validation.ConstraintViolationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiConfig;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.model.form.LiXiExchangeRateForm;
import vn.chonsoft.lixi.model.pojo.ListVatGiaCategory;
import vn.chonsoft.lixi.model.pojo.VatGiaCategoryPj;
import vn.chonsoft.lixi.model.trader.ExchangeRate;
import vn.chonsoft.lixi.model.trader.Trader;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.ExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiConfigService;
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
    
    @Autowired
    private LixiConfigService configService;
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
     * 
     * @param model 
     * @return 
     */
    @RequestMapping(value = "configs", method = RequestMethod.GET)
    public ModelAndView configs(Map<String, Object> model){
        
        List<LixiConfig> configs = this.configService.findAll();
        
        model.put("configs", configs);
        
        return new ModelAndView("Administration/config/configs");
    }
    
    /**
     * 
     * 
     * @param model 
     * @param name 
     * @param value 
     * @param id
     * @return 
     */
    @RequestMapping(value = "configs/save", method = RequestMethod.POST)
    public ModelAndView saveConfig(Map<String, Object> model, @RequestParam String name, @RequestParam String value, @RequestParam Integer id){
        
        LixiConfig config = new LixiConfig();
        config.setName(name);
        config.setValue(value);
        if(id>0) config.setId(id);
        
        this.configService.save(config);
        
        RedirectView r = new RedirectView("/Administration/SystemConfig/configs", true, true);
        r.setExposeModelAttributes(false);
        return new ModelAndView(r);
    }
    /**
     * 
     * 
     * @param model 
     * @param id
     * @return 
     */
    @RequestMapping(value = "configs/delete/{id}", method = RequestMethod.POST)
    public ModelAndView saveConfig(Map<String, Object> model, @PathVariable Integer id){
        
        this.configService.delete(id);
        
        RedirectView r = new RedirectView("/Administration/SystemConfig/configs", true, true);
        r.setExposeModelAttributes(false);
        return new ModelAndView(r);
    }
    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "lixiExchangeRate", method = RequestMethod.GET)
    public ModelAndView lixiExchangeRate(Map<String, Object> model) {

        LiXiExchangeRateForm form = new LiXiExchangeRateForm();
        LixiExchangeRate lastXr = this.lxrService.findLastRecord(LiXiConstants.USD);
        form.setBuy(lastXr.getBuy());
        form.setBuyPercentage(lastXr.getBuyPercentage());
        form.setRoundBuy(lastXr.getBuy());
        form.setSell(lastXr.getSell());
        form.setSellPercentage(lastXr.getSellPercentage());
        form.setRoundSell(lastXr.getSell());
        
        model.put("liXiExchangeRateForm",form);
        model.put("CURRENCIES", this.currencyService.findAll());
        model.put("VCB", LiXiUtils.getVCBExchangeRates());
        model.put("EXCHANGE_RATES", getLastERByTrader());
        model.put("LIXI_EXCHANGE_RATES", this.lxrService.findAll());
        model.put("LAST_X_R", this.lxrService.findLastRecord(LiXiConstants.USD));

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

            //model.put("CURRENCIES", this.currencyService.findAll());
            //model.put("VCB", LiXiUtils.getVCBExchangeRates());
            //model.put("EXCHANGE_RATES", getLastERByTrader());
            //model.put("LIXI_EXCHANGE_RATES", this.lxrService.findAll());

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
            lixiexr.setBuy(form.getRoundBuy());
            lixiexr.setSell(form.getRoundSell());
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
            return new ModelAndView("Administration/config/lixiExchangeRate");
        }

        //model.put("liXiExchangeRateForm", new LiXiExchangeRateForm());
        //model.put("CURRENCIES", this.currencyService.findAll());
        //model.put("VCB", LiXiUtils.getVCBExchangeRates());
        //model.put("EXCHANGE_RATES", getLastERByTrader());
        //model.put("LIXI_EXCHANGE_RATES", this.lxrService.findAll());
        
        RedirectView r = new RedirectView("/Administration/SystemConfig/lixiExchangeRate", true, true);
        r.setExposeModelAttributes(false);
        return new ModelAndView(r);
        
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
        //model.put("SUPPORT_LOCALE", this.slService.findAll());

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
        
        /* LixiCategory */
        LixiCategory lxc = new LixiCategory();
        
        String idStr = request.getParameter("lxId");
        // set id for update if we have
        if(idStr!=null && !"".equals(idStr.trim())){
            lxc.setId(Integer.parseInt(idStr));
        }
        
        lxc.setCode(request.getParameter("code"));
        lxc.setEnglish(request.getParameter("english"));
        lxc.setVietnam(request.getParameter("vietnam"));
        lxc.setActivated(LiXiConstants.LIXI_ACTIVATED);
        lxc.setSortOrder(sortOrder);

        //
        lxc.setCreatedDate(Calendar.getInstance().getTime());
        lxc.setCreatedBy(createdBy);
        lxc.setVatgiaId(vgc);

        vgc.setLixiCategory(lxc);

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
        
        vgc.getLixiCategory().setActivated(LiXiConstants.LIXI_NON_ACTIVATED);
        
        this.vgcService.save(vgc);
        //
        return new ModelAndView(new RedirectView("/Administration/SystemConfig/categories", true, true));
    }
    
    
}
