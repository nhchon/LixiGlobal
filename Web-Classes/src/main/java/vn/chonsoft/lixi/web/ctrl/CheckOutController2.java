/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.form.AddCardForm;
import vn.chonsoft.lixi.model.form.BankAccountAddForm;
import vn.chonsoft.lixi.model.pojo.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.pojo.EnumTransactionStatus;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.CountryService;
import vn.chonsoft.lixi.repositories.service.LixiCardFeeService;
import vn.chonsoft.lixi.repositories.service.LixiGlobalFeeService;
import vn.chonsoft.lixi.repositories.service.LixiInvoiceService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.PaymentService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserBankAccountService;
import vn.chonsoft.lixi.repositories.service.UserCardService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CreditCardProcesses;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("checkout")
public class CheckOutController2 {

    private static final Logger log = LogManager.getLogger(CheckOutController2.class);

    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private RecipientService reciService;

    @Autowired
    private UserService userService;

    @Autowired
    private UserCardService ucService;

    @Autowired
    private BillingAddressService baService;

    @Autowired
    private LixiOrderService lxorderService;

    //@Autowired
    //private LixiOrderGiftService lxogiftService;

    //@Autowired
    //private RecipientService recService;

    @Autowired
    private UserBankAccountService ubcService;

    @Autowired
    private LixiGlobalFeeService feeService;

    @Autowired
    private LixiInvoiceService invoiceService;
    
    @Autowired
    private CountryService countryService;
    
    //@Autowired
    //private LixiCardFeeService cardFeeService;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;

    @Autowired
    private VelocityEngine velocityEngine;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private LixiAsyncMethods lxAsyncMethods;
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "paymentMethods", method = RequestMethod.GET)
    public ModelAndView choosePaymentMethod(Map<String, Object> model, HttpServletRequest request) {
        
        User u = this.userService.findByEmail(loginedUser.getEmail());

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        List<UserBankAccount> accs = this.ubcService.findByUser(u);
        List<UserCard> cards = this.ucService.findByUser(u);

        // no card and no bank account
        if (accs.isEmpty() && cards.isEmpty()) {
            return new ModelAndView(new RedirectView("/checkout/addCard", true, true));
        } else {
            model.put(LiXiConstants.ACCOUNTS, accs);
            model.put(LiXiConstants.CARDS, cards);
            model.put(LiXiConstants.LIXI_ORDER, order);

            /* display view */
            return new ModelAndView("giftprocess2/select-payment-method");
        }
    }
    
    /**
     * 
     * @param cardId
     * @param accId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "paymentMethods", method = RequestMethod.POST)
    public ModelAndView choosePaymentMethod(@RequestParam(required = false) Long cardId, @RequestParam(required = false) Long accId, HttpServletRequest request) {
        
        if(cardId == null && accId == null){
            
            return new ModelAndView(new RedirectView("/checkout/paymentMethods?wrong=1", true, true));
        }
        
        /* get order */
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        
        if(cardId != null){
            
            order.setCard(this.ucService.findById(cardId));
            order.setBankAccount(null);
            
        }
        else if(cardId != null){
            
            order.setBankAccount(this.ubcService.findById(accId));
            order.setCard(null);
            
        }
        
        this.lxorderService.save(order);

        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
        
    }
    /**
     * 
     * @param model
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "addCard", method = RequestMethod.GET)
    public ModelAndView addCard(Map<String, Object> model, HttpServletRequest request) {
        
        User u = this.userService.findByEmail(loginedUser.getEmail());
        List<UserCard> cards = this.ucService.findByUser(u);
        if (cards == null || cards.isEmpty()) {
            // return url
            model.put("returnUrl", "/gifts/order-summary");
        } else {
            model.put("returnUrl", "/checkout/paymentMethods");
        }
        
        /* card form */
        AddCardForm addCardForm = new AddCardForm();
        addCardForm.setCardType(1);
        addCardForm.setFirstName(loginedUser.getFirstName());
        addCardForm.setLastName(loginedUser.getLastName());
        
        model.put("addCardForm", addCardForm);
        
        return new ModelAndView("giftprocess2/add-a-card", model);
    }
    
    /**
     *
     * submit a new card
     *
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "addCard", method = RequestMethod.POST)
    public ModelAndView addACard(Map<String, Object> model,
            @Valid AddCardForm form, Errors errors, HttpServletRequest request) {

        if (errors.hasErrors()) {
            return new ModelAndView("giftprocess2/add-a-card");
        }

        try {

            if (!LiXiUtils.checkMonthYearGreaterThanCurrent(form.getExpMonth(), form.getExpYear())) {

                model.put("expiration_failed", 1);

                return new ModelAndView("giftprocess2/add-a-card", model);
            }

            User u = this.userService.findByEmail(loginedUser.getEmail());
            
            // billing address
            BillingAddress bl = new BillingAddress();
            bl.setFirstName(form.getFirstName());
            bl.setLastName(form.getLastName());
            bl.setAddress(form.getAddress());
            bl.setCity(form.getCity());
            bl.setState(form.getState());
            bl.setZipCode(form.getZipCode());
            bl.setCountry(form.getCountry());
            bl.setUser(u);
            
            bl = this.baService.save(bl);
            
            // Add a card
            UserCard uc = new UserCard();
            uc.setUser(u);
            uc.setCardType(form.getCardType());
            uc.setCardName(form.getCardName());
            uc.setBillingAddress(bl);
            uc.setModifiedDate(Calendar.getInstance().getTime());
            // pass real information to authorize.net
            uc.setCardNumber(form.getCardNumber());
            uc.setExpMonth(form.getExpMonth());
            uc.setExpYear(form.getExpYear());
            uc.setCardCvv(form.getCvv());
            
            /* Create authorize.net profile */
            String returned = LiXiConstants.OK;
            if(StringUtils.isEmpty(u.getAuthorizeProfileId())){
                returned = this.paymentService.createCustomerProfile(u, uc);
            }
            else{
                returned = this.paymentService.createPaymentProfile(uc);
            }
            
            /* if we store card information on authorize.net OK */
            if(LiXiConstants.OK.equals(returned)){

                /* Don't store full card information */
                String secretCardNumber= "XXXX"+StringUtils.right(form.getCardNumber(), 4);
                uc.setCardNumber(secretCardNumber);
                uc.setCardCvv("000");
                uc = this.ucService.save(uc);
                
                // update order, add card
                LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
                order.setCard(uc);
                //remove bank account IF it has
                order.setBankAccount(null);

                this.lxorderService.save(order);

                // check billing address
                //Pageable just6rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
                //Page<BillingAddress> addresses = this.baService.findByUser(u, just6rec);
                //if (addresses != null && addresses.hasContent()) {
                    // jump to page choose billing address
                //    return new ModelAndView(new RedirectView("/checkout/choose-billing-address", true, true));
                //} else {
                    // add a new billing address
                //    return new ModelAndView(new RedirectView("/checkout/billing-address", true, true));
                //}
                return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
            }
            else{
                model.put("authorizeError", returned);

                return new ModelAndView("giftprocess2/add-a-card");
            }
        } catch (ConstraintViolationException e) {

            log.info("Insert card failed", e);
            //
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("giftprocess2/add-a-card", model);

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
    @UserSecurityAnnotation
    @RequestMapping(value = "addBankAccount", method = RequestMethod.GET)
    public ModelAndView addBankAccount(Map<String, Object> model, HttpServletRequest request) {

        model.put("bankAccountAddForm", new BankAccountAddForm());

        return new ModelAndView("giftprocess2/add-bank-account");
    }

    /**
     * 
     * @param model
     * @param setting
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "place-order/calculateFee/{setting}", method = RequestMethod.GET)
    public ModelAndView calculateFee(Map<String, Object> model, @PathVariable Integer setting, HttpServletRequest request) {

        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);
            // save setting
            order.setSetting(setting);

            this.lxorderService.save(order);
        } else {

            // order not exist
            model.put("error", 1);
        }
        //
        model.put("error", 0);

        // calculate fee
        LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(
                this.countryService.findByName(LiXiUtils.getBillingAddress(order).getCountry())));

        return new ModelAndView("giftprocess2/fees");
    }
    
    /**
     * 
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "place-order", method = RequestMethod.GET)
    public ModelAndView placeOrder(Map<String, Object> model, HttpServletRequest request) {
        
        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);
        } else {

            // order not exist, go to Choose recipient page
            return new ModelAndView(new RedirectView("/gifts/chooseCategory", true, true));
        }
        
        // calculate fee
        LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(
                this.countryService.findByName(LiXiUtils.getBillingAddress(order).getCountry())));

        return new ModelAndView("giftprocess2/place-order");
    }
    
    /**
     * 
     * @param request
     * @return
     * @throws Exception 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "place-order", method = RequestMethod.POST)
    public ModelAndView placeOrder(HttpServletRequest request) throws Exception {

        User u = this.userService.findByEmail(loginedUser.getEmail());

        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);
            Date currDate = Calendar.getInstance().getTime();
            
            order.setLixiStatus(EnumLixiOrderStatus.NOT_YET_SUBMITTED.getValue());
            order.setModifiedDate(currDate);
            this.lxorderService.save(order);
            
            LixiInvoice invoice = order.getInvoice();
            if(invoice == null){
                /* create invoice */
                Map<String, Object> model = new HashMap<>();
                /* get billing address */
                BillingAddress bl = LiXiUtils.getBillingAddress(order);

                // calculate fee
                LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(this.countryService.findByName(bl.getCountry())));
                
                invoice = new LixiInvoice();
                invoice.setOrder(order);
                invoice.setCardFee((Double)model.get(LiXiConstants.CARD_PROCESSING_FEE_THIRD_PARTY));
                invoice.setGiftPrice((Double)model.get(LiXiConstants.LIXI_GIFT_PRICE));
                invoice.setLixiFee((Double)model.get(LiXiConstants.LIXI_HANDLING_FEE_TOTAL));
                invoice.setTotalAmount((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL));
                invoice.setTotalAmountVnd((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL_VND));
                invoice.setNetTransStatus(EnumTransactionStatus.begin.getValue());
                invoice.setInvoiceDate(currDate);
                invoice.setCreatedDate(currDate);

                invoice = this.invoiceService.save(invoice);
            }
            //////////////////////// CHARGE CREDIT CARD ////////////////////////
            boolean chargeResult = paymentService.chargeByCustomerProfile(invoice);
            if (chargeResult == false) {
                return new ModelAndView(new RedirectView("/checkout/paymentMethods?wrong=1", true, true));
            } 
            else {
                // send mail to sender
                final String emailSender = order.getSender().getEmail();
                final List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
                final LixiOrder refOrder = order;
                MimeMessagePreparator preparator = new MimeMessagePreparator() {
                    @SuppressWarnings({"rawtypes", "unchecked"})
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {
                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage, "UTF-8");
                        message.setTo(emailSender);
                        message.setCc(LiXiConstants.YHANNART_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Invoice Alert");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map<String, Object> model = new HashMap<>();
                        model.put("sender", u);
                        model.put("LIXI_ORDER", refOrder);
                        model.put("REC_GIFTS", recGifts);
                        /* get billing address */
                        BillingAddress bl = LiXiUtils.getBillingAddress(refOrder);
                        // calculate fee
                        LiXiUtils.calculateFee(model, refOrder, feeService.findByCountry(countryService.findByName(bl.getCountry())));

                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                                velocityEngine, "emails/paid-order-alert.vm", "UTF-8", model);
                        message.setText(text, true);
                    }
                };
                // send oldEmail
                taskScheduler.execute(() -> mailSender.send(preparator));

            }
            ////////////////////////////////////////////////////////////////////
            log.info("Call Async methods");
            log.info("processTopUpItems");
            // The order is paid, top up mobile
            lxAsyncMethods.processTopUpItems(order);
            
            // Buy Cards
            //lxAsyncMethods.processBuyCardItems(order);
            
            //////////////////////// SUBMIT ORDER to BAOKIM:  Asynchronously ///
            log.info("submitOrdersToBaoKim");
            lxAsyncMethods.submitOrdersToBaoKim(order);
            ////////////////////////////////////////////////////////////////////
            log.info("END OF Call Async methods");
            
            // jump to thank you page
            return new ModelAndView(new RedirectView("/checkout/thank-you", true, true));
        } else {

            // order not exist, go to Choose recipient page
            return new ModelAndView(new RedirectView("/gifts/chooseCategory", true, true));
        }

    }

    /**
     *
     * Submit the order
     *
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "thank-you", method = RequestMethod.GET)
    public ModelAndView thankYou(HttpServletRequest request) {

        // remove Lixi order id
        request.getSession().removeAttribute(LiXiConstants.LIXI_ORDER_ID);

        //
        return new ModelAndView("giftprocess2/thank-you");
    }
    
}
