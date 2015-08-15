/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.trader.CurrencyType;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;
import vn.chonsoft.lixi.web.util.LiXiVatGiaUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("gifts")
public class GiftsController {
    
    private static final Logger log = LogManager.getLogger(GiftsController.class);
    
    @Inject
    UserService userService;
    
    @Inject
    RecipientService reciService;
    
    @Inject
    CurrencyTypeService currencyService;
    
    @Inject
    LixiExchangeRateService lxexrateService;
    
    @Inject
    LixiCategoryService lxcService;
    
    @Inject
    LixiOrderService lxorderService;
    
    @Inject
    LixiOrderGiftService lxogiftService;
    
    /**
     * 
     * @param request 
     * @return 
     */
    @RequestMapping(value = "recipient", method = RequestMethod.GET)
    public ModelAndView recipient(HttpServletRequest request){

        Map<String, Object> model = new HashMap<>();
        
        // check login
        if(!LiXiUtils.isLoggined(request)){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        
        // select recipients of user
        User u = this.userService.findByEmail(email);
        if(u != null){
            
            model.put("RECIPIENTS", u.getRecipients());
        }
        
        model.put("chooseRecipientForm", new ChooseRecipientForm());
        
        return new ModelAndView("giftprocess/recipient", model);
        
    }
    
    /**
     * 
     * @param model
     * @param email 
     */
    private void setRecipients(Map<String, Object> model, String email){
        
        User u = this.userService.findByEmail(email);
        if(u != null){

            model.put("RECIPIENTS", u.getRecipients());
        }
        
    }
    
    /**
     * 
     * @param model
     * @param u 
     */
    private void setRecipients(Map<String, Object> model, User u){
        
        if(u != null){

            model.put("RECIPIENTS", u.getRecipients());
        }
        
    }
    
    private boolean addMoreIdToSession(HttpSession session, String attrName, Long id){
        
        // new recipient
        if(id <= 0) return true;
        
        // param session is always not null
        String ids = (String)session.getAttribute(attrName);
        String vid = ","+id+",";
        
        if(ids == null || "".equals(ids)){
            
            session.setAttribute(attrName, vid);
            return true;
        }
        else{
            
            
            if(ids.contains(vid)){
                
                return false;
            }
            else{
                
                ids += vid;
            
                session.setAttribute(attrName, ids);
                return true;
            }
        }
    }
    /**
     * 
     * @param recId
     * @param request
     * @return 
     */
    @RequestMapping(value = "chooseRecipient/{recId}", method = RequestMethod.GET)
    public ModelAndView chooseRecipient(@PathVariable Long recId, HttpServletRequest request){
        
        Map<String, Object> model = new HashMap<>();
        
        // check login
        if(!LiXiUtils.isLoggined(request)){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        
        // select recipients of user
        setRecipients(model, email);
        
        Recipient reci = this.reciService.findById(recId);
        if(reci == null){
            // wrong recId
            model.put("chooseRecipientForm", new ChooseRecipientForm());
        }
        else{
            
            ChooseRecipientForm form = new ChooseRecipientForm();
            form.setRecId(recId);
            form.setFirstName(reci.getFirstName());
            form.setMiddleName(reci.getMiddleName());
            form.setLastName(reci.getLastName());
            form.setEmail(reci.getEmail());
            form.setPhone(reci.getPhone());
            form.setNote(reci.getNote());

            model.put("chooseRecipientForm", form);
        }
        //
        return new ModelAndView("giftprocess/recipient", model);
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = {"recipient", "chooseRecipient/{recId}"}, method = RequestMethod.POST)
    public ModelAndView chooseRecipient(Map<String, Object> model,
            @Valid ChooseRecipientForm form, Errors errors, HttpServletRequest request) {
        
        // check login
        if(!LiXiUtils.isLoggined(request)){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        //
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        // select recipients of user
        setRecipients(model, u);
        
        if (errors.hasErrors()) {

            return new ModelAndView("giftprocess/recipient");
        }
        
        try {
                
            // save new recipient
            Recipient rec = new Recipient();
            rec.setId(form.getRecId());
            rec.setSender(u);
            rec.setFirstName(form.getFirstName());
            rec.setMiddleName(form.getMiddleName());
            rec.setLastName(form.getLastName());
            rec.setEmail(form.getEmail());
            rec.setPhone(form.getPhone());
            rec.setNote(form.getNote());
            rec.setModifiedDate(Calendar.getInstance().getTime());

            rec = this.reciService.save(rec);

            // store selected recipient into session
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_ID, rec.getId());
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_NAME, form.getFirstName()+" "+StringUtils.defaultIfEmpty(form.getMiddleName(), "")+" "+form.getLastName());
            // store id to session
            addMoreIdToSession(request.getSession(), LiXiConstants.SELECTED_RECIPIENT_IDS, rec.getId());

            // jump to page Value Of Gift
            return new ModelAndView(new RedirectView("/gifts/value", true, true));
            
        } catch (ConstraintViolationException e) {
            
            log.info(e.getMessage(), e);
            
            model.put("validationErrors", e.getConstraintViolations());
            
            return new ModelAndView("giftprocess/recipient", model);
            
        }
        
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "value", method = RequestMethod.GET)
    public ModelAndView value(HttpServletRequest request){
        
        // check login
        if(!LiXiUtils.isLoggined(request)){
            
            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
            
        }
        //
        if(request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID) == null){
            
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }
        else{
            
            Map<String, Object> model = new HashMap<>();
            
            // currencies
            model.put(LiXiConstants.CURRENCIES, this.currencyService.findAll());
            
            // exchange rates
            LixiExchangeRate lxexrate = this.lxexrateService.findLastRecord();
            model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxexrate);
            
            // store lixi exhange rate id into session
            request.getSession().setAttribute(LiXiConstants.LIXI_EXCHANGE_RATE, lxexrate.getId());
            
            // jump
            return new ModelAndView("giftprocess/value-of-gift", model);
        }
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "value", method = RequestMethod.POST)
    public ModelAndView saveValue(HttpServletRequest request){
        
        String amountCurrencyCode = request.getParameter("amountCurrency");
        String amount = request.getParameter("amount");
        String exchangeRate = request.getParameter("exchangeRate");
        String giftInCurrencyCode = request.getParameter("giftInCurrencyValue");
        String giftInValue = request.getParameter("giftInValue");
        
        // sender
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        // recipient
        Recipient rec = this.reciService.findById((Long)request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
        
        // amount currency
        CurrencyType amountCurrency = this.currencyService.findByCode(amountCurrencyCode);
        
        // GiftIn currency
        CurrencyType giftInCurrency = this.currencyService.findByCode(giftInCurrencyCode);
        
        // Lixi Exchange Rate
        Long lxExchangerateId = (Long)request.getSession().getAttribute(LiXiConstants.LIXI_EXCHANGE_RATE);
        LixiExchangeRate lxExchangerate = this.lxexrateService.findById(lxExchangerateId);
        
        // always use Locale.US for  number format
        NumberFormat nf = NumberFormat.getNumberInstance(Locale.US);
        DecimalFormat df = (DecimalFormat)nf;
        //df.applyPattern("###,###.##");
        
        try {
            
            LixiOrder order = null;
            
            // check order already created
            if(request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null){
                
                Long orderId = (Long)request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
                
                order = this.lxorderService.findById(orderId);
                
            }
            else{
                // create order
                order = new LixiOrder();
                order.setSender(u);
                order.setLixiStatus(0);
                order.setLixiMessage(null);
                order.setModifiedDate(Calendar.getInstance().getTime());

                // save order
                order = this.lxorderService.save(order);
                
                // store ID into session
                request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
                
            }
            
            // check recipient already selected
            LixiOrderGift lxogift = this.lxogiftService.findByOrderAndRecipient(order, rec);
            if(lxogift != null){
                
                // update
                lxogift.setAmountCurrency(amountCurrency);
                lxogift.setAmount(df.parse(amount).floatValue());
                lxogift.setExchangeRate(df.parse(exchangeRate).floatValue());
                lxogift.setLxExchangeRate(lxExchangerate);
                lxogift.setGiftinCurrency(giftInCurrency);
                lxogift.setGiftin(df.parse(giftInValue).floatValue());
                lxogift.setModifiedDate(Calendar.getInstance().getTime());
                // save
                this.lxogiftService.save(lxogift);
                
            }
            else{
                // create lixi order gift
                lxogift = new LixiOrderGift();
                lxogift.setRecipient(rec);
                lxogift.setNote(rec.getNote());// note for each gift
                lxogift.setOrder(order);
                lxogift.setAmountCurrency(amountCurrency);
                lxogift.setAmount(df.parse(amount).floatValue());
                lxogift.setExchangeRate(df.parse(exchangeRate).floatValue());
                lxogift.setLxExchangeRate(lxExchangerate);
                lxogift.setGiftinCurrency(giftInCurrency);
                lxogift.setGiftin(df.parse(giftInValue).floatValue());
                lxogift.setModifiedDate(Calendar.getInstance().getTime());
                // save
                this.lxogiftService.save(lxogift);
            }
            
            // store amount and curreny into session for back button
            request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT, amount);
            request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_CURRENCY, amountCurrencyCode);
            // store amount in vnd
            request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND, LiXiUtils.getAmountInVnd(amountCurrencyCode, amount, giftInValue));
            // store current Lixi order gift id
            request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_GIFT_ID, lxogift.getId());
            
        } catch (Exception e) {
            //
            log.info("Save LixiOrder failed", e);
            
            return new ModelAndView(new RedirectView("/gifts/value?wrong=1", true, true));
            
        }
        
        // jump to type of gift
        return new ModelAndView(new RedirectView("/gifts/type", true, true));
        
    }
    
    /**
     * 
     * @return 
     */
    @RequestMapping(value = "type", method = RequestMethod.GET)
    public ModelAndView typeOfGift(){
    
        log.info(LocaleContextHolder.getLocale());
        
        List<LixiCategory> categories = this.lxcService.findByLocaleCode(LocaleContextHolder.getLocale().toString());
        
        log.info(categories.size());
        
        Map<String, Object> model = new HashMap<>();
        
        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        
        return new ModelAndView("giftprocess/type-of-gift", model);
        
    }
    
    /**
     * 
     * @param category 
     * @param request
     * @return 
     */
    @RequestMapping(value = "type", method = RequestMethod.POST)
    public ModelAndView typeOfGift(@RequestParam("type-of-gift") int category,  HttpServletRequest request){
        
        // check login
        if(!LiXiUtils.isLoggined(request)){
            
            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
            
        }
        
        LixiCategory lxcategory = this.lxcService.findById(new Integer(category));
        
        if(lxcategory == null){
            
            return new ModelAndView(new RedirectView("/gifts/type?wrong=1", true, true));
            
        }
        // get current order gift id
        Long orderGiftId = (Long)request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_GIFT_ID);
        
        LixiOrderGift lxogift = this.lxogiftService.findById(orderGiftId);
        lxogift.setCategory(lxcategory);
        // save category
        this.lxogiftService.save(lxogift);
        
        // store lixi category id into session for next and back action
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY, lxcategory.getId());
        
        // jump
        return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        
    }
    
    /**
     * 
     * @param request 
     * @return 
     */
    @RequestMapping(value = "choose", method = RequestMethod.GET)
    public ModelAndView chooseGift(HttpServletRequest request){

        // check login
        if(!LiXiUtils.isLoggined(request)){
            
            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
            
        }
        
        // prepare for Choose the gift page
        Integer lxcatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY);
        LixiCategory lxcategory = this.lxcService.findById(lxcatId);
        
        // float price = Float.parse(request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND));
        float price = 250000; //for test only
        ListVatGiaProduct products = LiXiVatGiaUtils.getInstance().getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
        
        log.info("products: " +(products == null));
        log.info(products.getData().size());
        
        Map<String, Object> model = new HashMap<>();
        model.put("PRODUCTS", products);
        
        return new ModelAndView("giftprocess/choose-the-gift", model);
        
    }
}
