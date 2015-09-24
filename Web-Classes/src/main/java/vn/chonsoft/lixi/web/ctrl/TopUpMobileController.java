/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Sort;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.BuyPhoneCard;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.model.pojo.EnumLixiOrderSetting;
import vn.chonsoft.lixi.repositories.service.BuyPhoneCardService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VtcServiceCodeService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("topUp")
public class TopUpMobileController {
    
    private static final Logger log = LogManager.getLogger(TopUpMobileController.class);

    @Inject
    private UserService userService;
    
    @Inject
    private RecipientService reciService;

    @Inject
    private LixiOrderService lxorderService;
    
    @Inject
    private LixiExchangeRateService lxexrateService;

    @Inject
    private LixiCategoryService lxcService;
    
    @Inject
    private VtcServiceCodeService vtcServiceCodeService;
    
    @Inject
    private TopUpMobilePhoneService topUpService;
    
    @Inject
    private BuyPhoneCardService buyPhoneCardService;
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView show(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        // for debug: what is in model
        //if(model.isEmpty()){
            //System.out.println("Wow ! It's empty");
        //}
        //for (Map.Entry<String, Object> entry : model.entrySet())
        //{
            //System.out.println(entry.getKey() + "/" + entry.getValue());
        //}
        
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        // sort categories
        Sort sort = new Sort(new Sort.Order(Sort.Direction.DESC, "activated"), 
                            new Sort.Order(Sort.Direction.ASC, "sortOrder"));
        List<LixiCategory> categories = this.lxcService.findByLocaleCode(LocaleContextHolder.getLocale().toString(), sort);
        // get exchange rate
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        // check current payment <==> maximum payment
        LixiExchangeRate lxExch = null;
        //double buy = lxExch.getBuy();
        if(order != null){
            
            // get buy from order
            lxExch = order.getLxExchangeRate();
        }
        else{
            // get latest from database
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        }
        /* get recipient */
        Recipient rec = this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
        model.put(LiXiConstants.SELECTED_RECIPIENT, rec);
        
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        model.put(LiXiConstants.PHONE_COMPANIES, this.vtcServiceCodeService.findAll());
        // maximum payment & current payment
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.CURRENT_PAYMENT, LiXiUtils.calculateCurrentPayment(order));
        
        return new ModelAndView("topup/topup", model);
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "editRecipient", method = RequestMethod.GET)
    public ModelAndView editRecipient(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        /* get recipient */
        Recipient rec = this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
        ChooseRecipientForm form = new ChooseRecipientForm();
        if(rec != null){
            form.setFirstName(rec.getFirstName());
            form.setMiddleName(rec.getMiddleName());
            form.setLastName(rec.getLastName());
            form.setEmail(rec.getEmail());
            form.setDialCode(rec.getDialCode());
            form.setPhone(rec.getPhone());
            form.setNote(rec.getNote());
            form.setRecId(rec.getId());
        }
        
        model.put("chooseRecipientForm", form);
        
        return new ModelAndView("topup/editRecipientModal", model);
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "topUpMobilePhone", method = RequestMethod.POST)
    public ModelAndView topUpMobilePhone(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);

        }
        
        String amountTopUpStr = request.getParameter("amountTopUp");
        String topUpAction = request.getParameter("topUpAction");
        
        Integer amountTopUp = 0;
        try{amountTopUp = Integer.parseInt(amountTopUpStr);}catch(Exception ex){};
        
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        double userMoneyLevelAmount = u.getUserMoneyLevel().getMoneyLevel().getAmount();
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        LixiExchangeRate lxExch = null;
        double buy = 0;
        if(order != null){
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        }
        else{
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }
        
        boolean exceed = checkExceed(model, order, userMoneyLevelAmount, amountTopUp*buy, buy);
        // order is exceed
        if(exceed){
            
            model.put("topUpExceed", 1);
            model.put(LiXiConstants.TOP_UP_AMOUNT, amountTopUp);
            
            //
            model.put("TOPUP_ACTION", "MOBILE_MINUTE");
            return new ModelAndView("topup/topup", model);
        }
        else{
            
            if(order == null){
                
                order = createOrder(u, lxExch);
                //
                request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
            }
            //
            String currency = request.getParameter("currency");
            String recPhone = request.getParameter("recPhone");
            
            TopUpMobilePhone topUp = new TopUpMobilePhone();
            topUp.setAmount(amountTopUp);
            topUp.setCurrency(currency);
            topUp.setPhone(recPhone);
            topUp.setOrder(order);
            topUp.setRecipient(this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID)));
            topUp.setModifiedDate(Calendar.getInstance().getTime());
            
            // save
            this.topUpService.save(topUp);
            
        }
        
        if(LiXiConstants.BUY_NOW.equals(topUpAction)){
            
            // reivew order
            return new ModelAndView(new RedirectView("/gifts/more-recipient", true, true));
        }
        else{
            // keep shopping
            model.put("addSuccess", 1);
            model.put("TOPUP_ACTION", "MOBILE_MINUTE");
            return show(model, request);
        }
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "buyPhoneCard", method = RequestMethod.POST)
    public ModelAndView buyPhoneCard(Map<String, Object> model, HttpServletRequest request){
        
        String phoneCompany = request.getParameter("phoneCompany");
        String numOfCardStr = request.getParameter("numOfCard");
        String valueOfCardStr = request.getParameter("valueOfCard");
        Integer valueOfCard = 0;
        Integer numOfCard = 0;
        try { 
            valueOfCard = Integer.parseInt(valueOfCardStr);
            numOfCard = Integer.parseInt(numOfCardStr);
        } catch (Exception e) {}
        
        //
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        double userMoneyLevelAmount = u.getUserMoneyLevel().getMoneyLevel().getAmount();
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        LixiExchangeRate lxExch = null;
        double buy = 0;
        if(order != null){
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        }
        else{
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }
        
        boolean exceed = checkExceed(model, order, userMoneyLevelAmount, numOfCard * valueOfCard, buy);
        // order is exceed
        if(exceed){
            
            model.put("phoneCardExceed", 1);
            //model.put(LiXiConstants.TOP_UP_AMOUNT, amountTopUp);
            
            //
            model.put("TOPUP_ACTION", "PHONE_CARD");
            return new ModelAndView("topup/topup", model);
        }
        else{
            
            if(order == null){
                
                order = createOrder(u, lxExch);
                //
                request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
            }
            //
            
            BuyPhoneCard phoneCard = new BuyPhoneCard();
            phoneCard.setNumOfCard(numOfCard);
            phoneCard.setValueOfCard(valueOfCard);
            phoneCard.setVtcCode(this.vtcServiceCodeService.findByCode(phoneCompany));
            phoneCard.setOrder(order);
            phoneCard.setRecipient(this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID)));
            phoneCard.setModifiedDate(Calendar.getInstance().getTime());
            
            // save
            this.buyPhoneCardService.save(phoneCard);
            
            model.put("buySuccess", 1);
            model.put("TOPUP_ACTION", "PHONE_CARD");
            return show(model, request);
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
    @RequestMapping(value = "editRecipient", method = RequestMethod.POST)
    public ModelAndView editRecipient(Map<String, Object> model,
            @Valid ChooseRecipientForm form, Errors errors, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);

        }
        //
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        if (errors.hasErrors()) {

            return new ModelAndView("topup/editRecipientModal");
        }

        try {
            Recipient rec = null;
            
            // correct name, fix encode, capitalize
            log.info("firstName:" + form.getFirstName());
            log.info("firstName:" + LiXiUtils.fixEncode(form.getFirstName()));
            log.info("firstName:" + LiXiUtils.correctName(form.getFirstName()));
            form.setFirstName(LiXiUtils.correctName(form.getFirstName()));
            form.setMiddleName(LiXiUtils.correctName(form.getMiddleName()));
            form.setLastName(LiXiUtils.correctName(form.getLastName()));
            
            // save or update the recipient
            rec = new Recipient();
            rec.setId((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
            rec.setSender(u);
            rec.setFirstName(form.getFirstName());
            rec.setMiddleName(form.getMiddleName());
            rec.setLastName(form.getLastName());
            rec.setEmail(form.getEmail());
            rec.setDialCode(form.getDialCode());
            rec.setPhone(form.getPhone());
            rec.setNote(LiXiUtils.fixEncode(form.getNote()));// note
            rec.setModifiedDate(Calendar.getInstance().getTime());

            rec = this.reciService.save(rec);

            // store selected recipient into session
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_ID, rec.getId());
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_NAME, form.getFirstName() + " " + StringUtils.defaultIfEmpty(form.getMiddleName(), "") + " " + form.getLastName());

            // jump to page Value Of Gift
            model.put("success", 1);
            return new ModelAndView("topup/editRecipientModalResult", model);

        } catch (ConstraintViolationException e) {

            log.info(e.getMessage(), e);

            model.put("validationErrors", e.getConstraintViolations());

            return new ModelAndView("topup/editRecipientModalResult", model);

        }

    }
    
    /**
     * 
     * @param u
     * @param lxExch
     * @return 
     */
    private LixiOrder createOrder(User u, LixiExchangeRate lxExch){
        
        // create order
        LixiOrder order = new LixiOrder();
        order.setSender(u);
        order.setLxExchangeRate(lxExch);
        order.setLixiStatus(LiXiConstants.LIXI_ORDER_UNFINISHED);
        order.setLixiMessage(null);
        // default is allow refund
        order.setSetting(EnumLixiOrderSetting.ALLOW_REFUND.getValue());
        order.setModifiedDate(Calendar.getInstance().getTime());

        // set card and billing address from last order
        LixiOrder lastOrder = this.lxorderService.findLastOrder(u);
        // last user's order
        if(lastOrder != null){
            // use the last payment method
            order.setCard(lastOrder.getCard());
            order.setBankAccount(lastOrder.getBankAccount());
        }

        // save order
        return this.lxorderService.save(order);

        // store ID into session
        //request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
    }
    /**
     * 
     * check exceed
     * 
     * @param model
     * @param order
     * @param userMoneyLevel
     * @param addedAmount
     * @return 
     */
    private boolean checkExceed(Map<String, Object> model, LixiOrder order, double userMoneyLevel, double addedAmount, double buy){
        
        // check current payment <==> maximum payment
        
        double[] currentPayments = LiXiUtils.calculateCurrentPayment(order); // in VND
        double currentPayment = currentPayments[0];//vnd
        currentPayment += addedAmount;// in VND

        if (currentPayment > (userMoneyLevel * buy)) {

            // maximum payment is over
            model.put("exceed", 1);
            
            double exceededPaymentVND = currentPayment - (userMoneyLevel * buy);
            double exceededPaymentUSD = (currentPayment/buy) - userMoneyLevel;
            
            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));
            
            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));
            
            return true;
        }
        else{
            // the order is not exceeded
            model.put("exceed", 0);
            return false;
        }
    }
    /**
     * 
     * Check topup exceed
     * 
     * @param model
     * @param amount
     * @param request
     * @return 
     */
    @RequestMapping(value = "checkTopUpExceed/{amount}", method = RequestMethod.GET)
    public ModelAndView checkTopUpExceed(Map<String, Object> model, @PathVariable Integer amount, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        // check current payment <==> maximum payment
        LixiExchangeRate lxExch = null;
        double buy = 0;
        if(order != null){
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        }
        else{
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }
        
        double[] currentPayments = LiXiUtils.calculateCurrentPayment(order); // in VND
        double currentPayment = currentPayments[0];//vnd
        currentPayment += (amount * buy);// in VND

        if (currentPayment > (u.getUserMoneyLevel().getMoneyLevel().getAmount() * buy)) {

            // maximum payment is over
            model.put("exceed", 1);
            
            double exceededPaymentVND = currentPayment - (u.getUserMoneyLevel().getMoneyLevel().getAmount() * buy);
            double exceededPaymentUSD = (currentPayment/buy) - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            
            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));
            
            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));
         
        }
        else{
            // the order is not exceeded
            model.put("exceed", 0);
        }
        // forward topup amount
        model.put(LiXiConstants.TOP_UP_AMOUNT, amount);
        
        // topup in VND
        model.put(LiXiConstants.TOP_UP_IN_VND, LiXiUtils.getNumberFormat().format(amount * buy));
        
        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, LiXiUtils.getNumberFormat().format(currentPayment / buy));
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, LiXiUtils.getNumberFormat().format(currentPayment));
        
        return new ModelAndView("topup/exceedTopUp", model);
    }
}
