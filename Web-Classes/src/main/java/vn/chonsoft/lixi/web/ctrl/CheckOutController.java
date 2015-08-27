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
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.form.BankAccountAddForm;
import vn.chonsoft.lixi.model.form.BillingAddressForm;
import vn.chonsoft.lixi.model.form.CardAddForm;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserBankAccountService;
import vn.chonsoft.lixi.repositories.service.UserCardService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("checkout")
public class CheckOutController {
    
    private static final Logger log = LogManager.getLogger(CheckOutController.class);
    
    @Inject
    private UserService userService;
    
    @Inject
    private UserCardService ucService;
    
    @Inject
    private BillingAddressService baService;
    
    @Inject
    private LixiOrderService lxorderService;
    
    @Inject
    private RecipientService recService;
    
    @Inject
    private UserBankAccountService ubcService;
    /**
     * Add a card
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "cards/add", method = RequestMethod.GET)
    public ModelAndView addACard(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        List<UserCard> cards = this.ucService.findByUser(u);
        if(cards == null || cards.isEmpty()){
            
            // back url
            model.put("backUrl", "/gifts/review");
        }
        else{
            model.put("backUrl", "/checkout/cards/change");
        }
        
        CardAddForm addForm = new CardAddForm();
        addForm.setCardType(1);

        model.put("cardAddForm", addForm);
        
        return new ModelAndView("giftprocess/add-a-card", model);
        
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "cards/add", method = RequestMethod.POST)
    public ModelAndView addACard(Map<String, Object> model,
            @Valid CardAddForm form, Errors errors, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        if (errors.hasErrors()) {
            
            return new ModelAndView("giftprocess/add-a-card");
        }
        
        try {
            
            if(!LiXiUtils.checkMonthYearGreaterThanCurrent(form.getExpMonth(), form.getExpYear())){
                
                model.put("expiration_failed", 1);
                
                return new ModelAndView("giftprocess/add-a-card", model);
            }
            
            // check card number
            UserCard lastUC = this.ucService.findByCardNumber(form.getCardNumber());
            if(lastUC != null){
                
                model.put("card_number_failed", 1);
                
                return new ModelAndView("giftprocess/add-a-card", model);
            }
            
            String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            User u = this.userService.findByEmail(email);

            // Add a card
            UserCard uc = new UserCard();
            uc.setUser(u);
            uc.setCardType(form.getCardType());
            uc.setCardName(form.getCardName());
            uc.setCardNumber(form.getCardNumber());
            uc.setExpMonth(form.getExpMonth());
            uc.setExpYear(form.getExpYear());
            uc.setCardCvv(form.getCvv());
            uc.setModifiedDate(Calendar.getInstance().getTime());
            
            uc = this.ucService.save(uc);
            
            // update order, add card
            LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
            order.setCard(uc);
            
            this.lxorderService.save(order);
            
            // check billing address
            Pageable just6rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
            Page<BillingAddress> addresses = this.baService.findByUser(u, just6rec);
            if(addresses != null && addresses.hasContent()){
                // jump to page choose billing address
                return new ModelAndView(new RedirectView("/checkout/choose-billing-address", true, true));
            }
            else{
                // add a new billing address
                return new ModelAndView(new RedirectView("/checkout/billing-address", true, true));
            }
            
        } catch (ConstraintViolationException e) {

            log.info("Insert card failed", e);
            //
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("giftprocess/add-a-card", model);

        }
        
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "cards/change", method = RequestMethod.GET)
    public ModelAndView cards(Map<String, Object> model,  HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        
        List<UserCard> cards = this.ucService.findByUser(u);
        if(cards == null || cards.isEmpty()){
            
            // there is no card, it means user had no order
            return new ModelAndView(new RedirectView("/checkout/cards/add", true, true));
        }
        else{
            
            // choose payment method
            return new ModelAndView(new RedirectView("/checkout/payment-method/change", true, true));
        }
    }
    
    ////////////////////////// Bank Account
    @RequestMapping(value = "pay-by-bank-account/change", method = RequestMethod.GET)
    public ModelAndView payByBankAccount(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        
        List<UserBankAccount> accounts = this.ubcService.findByUser(u);
        if(accounts == null || accounts.isEmpty()){
            
            // there is no bank account, add a new
            return new ModelAndView(new RedirectView("/checkout/pay-by-bank-account/add", true, true));
        }
        else{
            
            // choose payment method
            return new ModelAndView(new RedirectView("/checkout/payment-method/change", true, true));
        }
        
    }
    
    /**
     * 
     * Add bank account
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "pay-by-bank-account/add", method = RequestMethod.GET)
    public ModelAndView addBankAccount(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        model.put("bankAccountAddForm", new BankAccountAddForm());
        
        return new ModelAndView("giftprocess/pay-by-bank-account");
    }
    
    /**
     * 
     * submit new bank account
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "pay-by-bank-account", method = RequestMethod.POST)
    public ModelAndView payByBankAccount(Map<String, Object> model,
            @Valid BankAccountAddForm form, Errors errors, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        if (errors.hasErrors()) {
            
            return new ModelAndView("giftprocess/pay-by-bank-account");
        }
        
        try {
            // login user
            String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            User u = this.userService.findByEmail(email);
            
            UserBankAccount ubc = new UserBankAccount();
            ubc.setName(form.getName());
            ubc.setBankRounting(form.getBankRounting());
            ubc.setCheckingAccount(form.getCheckingAccount());
            ubc.setDriverLicense(form.getDriverLicense());
            ubc.setState(form.getState());
            ubc.setModifiedDate(Calendar.getInstance().getTime());
            ubc.setBillingAddress(null);
            ubc.setUser(u);
            
            ubc = this.ubcService.save(ubc);
            
            // update order, add bank account
            LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
            order.setBankAccount(ubc);
            
            this.lxorderService.save(order);
            
        } catch (ConstraintViolationException e) {
            
            log.info("Insert bank account failed", e);
            //
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("giftprocess/pay-by-bank-account", model);
        }
        
        //
        return new ModelAndView(new RedirectView("/checkout/choose-billing-address", true, true));
    }
    
    /////////////////////////
    @RequestMapping(value = "payment-method/change", method = RequestMethod.GET)
    public ModelAndView changePaymentMethod(Map<String, Object> model, HttpServletRequest request){
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        
        model.put(LiXiConstants.ACCOUNTS, this.ubcService.findByUser(u));
        model.put(LiXiConstants.CARDS, this.ucService.findByUser(u));
        model.put(LiXiConstants.LIXI_ORDER, order);
        
        return new ModelAndView("giftprocess/change-payment-method");
    }
    /**
     * 
     * User change payment method
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "payment-method/change", method = RequestMethod.POST)
    public ModelAndView changePaymentMethod(HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        String cardIdStr = request.getParameter("cardId");
        String accIdStr = request.getParameter("accId");
        
        Long cardId = 0L;
        Long accId = 0L;
        try {
            //
            if(cardIdStr != null && !"".equals(cardIdStr)){
                cardId = Long.parseLong(cardIdStr);
            }
            //
            if(accIdStr != null && !"".equals(accIdStr)){
                accId = Long.parseLong(accIdStr);
            }
        } catch (Exception e) {log.info("parse number wrong", e);}
        
        // There is something wrong
        if(accId <= 0 && cardId <= 0){
            
            return new ModelAndView(new RedirectView("/checkout/payment-method/change?wrong=1", true, true));
        }
        
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        if(cardId > 0){
            //
            order.setCard(this.ucService.findById(cardId));
            order.setBankAccount(null);
        }
        else{
            //
            order.setBankAccount(this.ubcService.findById(accId));
            order.setCard(null);
        }
        
        this.lxorderService.save(order);
        
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }
    /**
     * 
     * @param page
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "choose-billing-address-modal", method = RequestMethod.GET)
    public ModelAndView chooseBillingAddressModal(Map<String, Object> model, @PageableDefault(value = 6) Pageable page,  HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        //Pageable just2rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        Page<BillingAddress> addresses = this.baService.findByUser(u, page);
        
        model.put(LiXiConstants.BILLING_ADDRESS_ES, addresses);
        model.put(LiXiConstants.USER_LOGIN_ID, u.getId());
        
        return new ModelAndView("giftprocess/billing-address-list", model);
    }
    
    /**
     * 
     * Choose a billing address from a list
     * 
     * @param model
     * @param page
     * @param request
     * @return 
     */
    @RequestMapping(value = "choose-billing-address", method = RequestMethod.GET)
    public ModelAndView chooseBillingAddress(Map<String, Object> model, @PageableDefault(value = 6) Pageable page,  HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        //Pageable just2rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        Page<BillingAddress> addresses = this.baService.findByUser(u, page);
        
        model.put(LiXiConstants.BILLING_ADDRESS_ES, addresses);
        model.put(LiXiConstants.USER_LOGIN_ID, u.getId());
        
        return new ModelAndView("giftprocess/choose-billing-address", model);
    }
    
    /**
     * 
     * for modal dialog
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address-modal", method = RequestMethod.GET)
    public ModelAndView billingAddressModal(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        model.put("billingAddressForm", new BillingAddressForm());
        
        return new ModelAndView("giftprocess/billing-address-modal");
        
    }
    
    /**
     * 
     * for modal dialog
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address-modal", method = RequestMethod.POST)
    public ModelAndView billingAddressModal(Map<String, Object> model, 
            @Valid BillingAddressForm form, Errors errors, HttpServletRequest request) {
        
        return billingAddress(model, form, errors, request);
    }

    /**
     * 
     * @param baId
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address/{baId}", method = RequestMethod.GET)
    public ModelAndView billingAddress(@PathVariable Long baId, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        // login user
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        BillingAddress ba = this.baService.findByIdAndUser(baId, u);
        if(ba == null){
            
            return new ModelAndView("giftprocess/billing-address");
        }
        else{
            
            // update bill address attr for selected card
            LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
                
            UserCard uc = order.getCard();
            if(uc != null){
                //
                uc.setBillingAddress(this.baService.findById(baId));
                order.setCard(this.ucService.save(uc));
                // update order
                this.lxorderService.save(order);
            }
            else{

                UserBankAccount ubc = order.getBankAccount();
                if(ubc != null){
                    log.info("update billing address for bank account");
                    // update billing address for ubc
                    ubc.setBillingAddress(this.baService.findById(baId));
                    order.setBankAccount(this.ubcService.save(ubc));
                    //update order
                    this.lxorderService.save(order);
                }
            }
        }
        
        //
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address", method = RequestMethod.GET)
    public ModelAndView billingAddress(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        model.put("billingAddressForm", new BillingAddressForm());
        
        return new ModelAndView("giftprocess/billing-address");
        
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address", method = RequestMethod.POST)
    public ModelAndView billingAddress(Map<String, Object> model, 
            @Valid BillingAddressForm form, Errors errors, HttpServletRequest request) {
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        if (errors.hasErrors()) {
            
            return new ModelAndView("giftprocess/billing-address");
        }
        
        try {

            // login user
            String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            User u = this.userService.findByEmail(email);
            
            if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) == null) {
                // order not exist, go to Choose recipient page
                return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
            }
            
            // created billing address
            BillingAddress bil = new BillingAddress();
            bil.setUser(u);
            bil.setFullName(form.getFullName());
            bil.setAdd1(form.getAdd1());
            bil.setAdd2(form.getAdd2());
            bil.setCity(form.getCity());
            bil.setState(form.getState());
            bil.setZipCode(form.getZipCode());
            bil.setPhone(form.getPhone());
            
            bil = this.baService.save(bil);
            
            // update billing address for card
            LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
            
            if(order.getCard() != null){
                
                UserCard uc = order.getCard();
                if(uc != null){
                    //
                    uc.setBillingAddress(bil);
                    this.ucService.save(uc);
                }
                else{
                    
                    UserBankAccount ubc = order.getBankAccount();
                    if(ubc != null){
                        // update billing address for ubc
                        ubc.setBillingAddress(bil);
                        this.ubcService.save(ubc);
                    }
                }
            }
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("giftprocess/billing-address", model);
        }
        
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }
    
    
    /**
     * 
     * @param model 
     * @param request
     * @return 
     */
    @RequestMapping(value = "place-order", method = RequestMethod.GET)
    public ModelAndView placeOrder(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        LixiOrder order = null;
        // order already created
        Long orderId = (Long)request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {
            
            order = this.lxorderService.findById(orderId);
        }
        else{
            
            // order not exist, go to Choose recipient page
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }
        
        Map<Recipient, List<LixiOrderGift>> recGifts = LiXiUtils.genMapRecGifts(order);
        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.REC_GIFTS, recGifts);
        
        
        return new ModelAndView("giftprocess/place-order");
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "edit-rec-phone", method = RequestMethod.POST)
    public ModelAndView editRecMobilePhone(HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        String recId = request.getParameter("recId");
        String phone = request.getParameter("mobilePhone");
        
        this.recService.updatePhone(phone, Long.parseLong(recId));
        
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }

    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "thank-you", method = RequestMethod.GET)
    public ModelAndView thankYou(HttpServletRequest request){

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
     
        // remove Lixi order id
        request.getSession().removeAttribute(LiXiConstants.LIXI_ORDER_ID);
        
        //
        return new ModelAndView("giftprocess/thank-you");
    }
}
