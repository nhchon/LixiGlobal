/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.form.TraderCreateForm;
import vn.chonsoft.lixi.model.form.TraderExchangeRateForm;
import vn.chonsoft.lixi.model.form.TraderLoginForm;
import vn.chonsoft.lixi.model.trader.ExchangeRate;
import vn.chonsoft.lixi.model.trader.Trader;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.ExchangeRateService;
import vn.chonsoft.lixi.repositories.service.TraderService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("trader")
public class TraderController {
    
    @Inject TraderService traderService;
    @Inject CurrencyTypeService currencyService;
    @Inject ExchangeRateService exrService;
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(Map<String, Object> model) {

        model.put("traderCreateForm", new TraderCreateForm());
        return "trader/create";
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @return 
     */
    @RequestMapping(value = "create", method = RequestMethod.POST)
    public ModelAndView create(Map<String, Object> model,
            @Valid TraderCreateForm form, Errors errors) {
        
        if (errors.hasErrors()) {
            return new ModelAndView("trader/create");
        }
        
        Trader trader = new Trader();
        
        trader.setName(form.getName());
        trader.setEmail(form.getEmail());
        trader.setPhone(form.getPhone());
        
        trader.setUsername(form.getUsername());
        trader.setPassword(BCrypt.hashpw(form.getPassword(), BCrypt.gensalt()));
        
        trader.setCreatedDate(Calendar.getInstance().getTime());
        
        try {
            // check unique username
            // exceptions will be thrown if the username is not unique
            this.traderService.checkUniqueUsername(form.getUsername());
            
            // check unique email
            // exceptions will be thrown if the email is not unique
            Trader temp = this.traderService.checkUniqueEmail(trader.getEmail());
            
            if(temp == null){
                
                // check unique phone
                // exception will be thrown if the phone is not unique
                Trader tempPhone = this.traderService.checkUniquePhone(trader.getPhone());
                if(tempPhone == null){
                    this.traderService.save(trader);
                }
            }
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("trader/create");
            
        }
        
        return new ModelAndView(new RedirectView("/trader/login", true, true));
    }
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "login", method = RequestMethod.GET)
    public ModelAndView login(Map<String, Object> model, HttpServletRequest request) {

        HttpSession session = request.getSession();
        Long traderId = (Long)session.getAttribute("TRADER_LOGIN_ID");
        
        if(traderId == null){

            // login
            model.put("traderLoginForm", new TraderLoginForm());
            return new ModelAndView("trader/login", model);
            
        }
        else{
            // Already login
            return new ModelAndView(new RedirectView("/trader/exchangeRate", true, true));
            
        }
    }

    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public ModelAndView login(Map<String, Object> model,
            @Valid TraderLoginForm form, Errors errors, HttpServletRequest request) {
        
        if (errors.hasErrors()) {
            
            return new ModelAndView("trader/login");
            
        }
        
        try {
            // exceptions will be thrown if there is no account
            Trader trader = this.traderService.findByUsername(form.getUsername());
            if(BCrypt.checkpw(form.getPassword(), trader.getPassword())){
                
                HttpSession session = request.getSession();
                session.setAttribute("TRADER_LOGIN_USERNAME", trader.getUsername());
                session.setAttribute("TRADER_LOGIN_ID", trader.getId());
                // change session id
                request.changeSessionId();
                
            }
            else{
                model.put("LOGIN_FAILED", "1");
                return new ModelAndView("trader/login");
            }
        } catch (ConstraintViolationException e) {
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("trader/login");
        }
        
        return new ModelAndView(new RedirectView("/trader/exchangeRate", true, true));
    }
    
    /**
     * 
     * @param model
     * @param session
     * @return 
     */
    @RequestMapping(value = "exchangeRate", method = RequestMethod.GET)
    public String exchangeRate(Map<String, Object> model, HttpSession session){
        
        Long traderId = (Long)session.getAttribute("TRADER_LOGIN_ID");
        
        if(traderId == null || traderId<=0){
            model.put("traderLoginForm", new TraderLoginForm());
            return "trader/login";
        }
        
        model.put("traderExchangeRateForm", new TraderExchangeRateForm());
        model.put("VCB", LiXiUtils.getVCBExchangeRates());
        model.put("CURRENCIES", this.currencyService.findAll());
        model.put("EXCHANGE_RATES", this.exrService.findByTraderId(this.traderService.findById(traderId)));
        //
        return "trader/exchangeRate";
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param session
     * @return 
     */
    @RequestMapping(value = "exchangeRate", method = RequestMethod.POST)
    public ModelAndView exchangeRate(Map<String, Object> model,
            @Valid TraderExchangeRateForm form, Errors errors, HttpSession session){

        Long traderId = (Long)session.getAttribute("TRADER_LOGIN_ID");
        
        if(traderId == null || traderId<=0){
            
            return new ModelAndView(new RedirectView("/trader/login", true, true));
            
        }
        /* */
        if (errors.hasErrors()) {
            
            // pass values
            model.put("VCB", LiXiUtils.getVCBExchangeRates());
            model.put("CURRENCIES", this.currencyService.findAll());
            model.put("EXCHANGE_RATES", this.exrService.findByTraderId(this.traderService.findById(traderId)));
            //
            return new ModelAndView("trader/exchangeRate");
            
        }
        /* */
        try {
            
            ExchangeRate exr = new ExchangeRate();
            exr.setBuy(form.getBuy());
            exr.setSell(form.getSell());
            exr.setVcbBuy(form.getVcbBuy());
            exr.setVcbSell(form.getVcbSell());
            exr.setDateInput(form.getDateInput());
            // time input
            try {
                SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
                exr.setTimeInput(timeFormat.parse(form.getTimeInput()));
            } catch (Exception e) {}
            //
            exr.setCurrency(this.currencyService.findOne(form.getCurrency()));
            exr.setTraderId(this.traderService.findById(traderId));
            
            // save
            this.exrService.save(exr);
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            
        }
        
        //
        return new ModelAndView(new RedirectView("/trader/exchangeRate", true, true));
        
    }
}
