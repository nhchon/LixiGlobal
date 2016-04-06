/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.text.SimpleDateFormat;
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
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
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
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiGlobalFee;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderCard;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.form.AddCardForm;
import vn.chonsoft.lixi.model.form.BankAccountAddForm;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.EnumTransactionStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiCashrun;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.pojo.CashRun;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.CountryService;
import vn.chonsoft.lixi.repositories.service.LixiCashrunService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiGlobalFeeService;
import vn.chonsoft.lixi.repositories.service.LixiInvoiceService;
import vn.chonsoft.lixi.repositories.service.LixiOrderCardService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.PaymentService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.repositories.service.TransactionMonitorService;
import vn.chonsoft.lixi.repositories.service.UserBankAccountService;
import vn.chonsoft.lixi.repositories.service.UserCardService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("checkout")
public class CheckOutController {

    private static final Logger log = LogManager.getLogger(CheckOutController.class);

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
    private LixiOrderCardService ocService;

    @Autowired
    private BillingAddressService baService;

    @Autowired
    private LixiOrderService lxorderService;

    @Autowired
    private LixiOrderGiftService lxogiftService;

    @Autowired
    private LixiExchangeRateService lxexrateService;

    //@Autowired
    private LixiCashrunService cashRunService;

    @Autowired
    private UserBankAccountService ubcService;

    @Autowired
    private LixiInvoiceService invoiceService;
    
    @Autowired
    private TopUpMobilePhoneService topUpService;
    
    @Autowired
    private LixiGlobalFeeService feeService;

    @Autowired
    private CountryService countryService;
    
    @Autowired
    private VatgiaProductService vgpService;
    
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
    
    @Autowired
    private TransactionMonitorService transMoniService;
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "paymentMethods", method = RequestMethod.GET)
    public ModelAndView choosePaymentMethod(Map<String, Object> model, HttpServletRequest request) {
        
        // check order created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(orderId == null){
            
            // to do
            return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        }
        
        User u = this.userService.findByEmail(loginedUser.getEmail());

        LixiOrder order = this.lxorderService.findById(orderId);

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
            
            LixiOrderCard c = this.ocService.findById(cardId);
            if(c == null){
                c = this.ocService.save(LiXiUtils.toLxOrderCard(this.ucService.findById(cardId)));
            }
            
            order.setCard(c);
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
            
            /* check num of cards <= 5 */
            if(cards.size() >= LiXiGlobalConstants.USER_MAX_NUM_OF_CARD){
                
                return new ModelAndView(new RedirectView("/checkout/paymentMethods?overNumOfCard=1", true, true));
            }
        }
        
        /* card form */
        AddCardForm addCardForm = new AddCardForm();
        addCardForm.setCardType(1);
        addCardForm.setFirstName(loginedUser.getFirstName());
        addCardForm.setLastName(loginedUser.getLastName());
        
        model.put("addCardForm", addCardForm);
        
        model.put("COUNTRIES", this.countryService.findAll());
        
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
        
        /* for turn back */
        model.put("COUNTRIES", this.countryService.findAll());
        
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
            bl.setId(form.getBlId());
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
            uc.setCardBin(StringUtils.left(form.getCardNumber(), 6));
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
                String secretCardNumber= StringUtils.leftPad(StringUtils.right(form.getCardNumber(), 4), form.getCardNumber().length(), "X");
                uc.setCardNumber(secretCardNumber);
                uc.setCardCvv(null);
                uc = this.ucService.save(uc);
                
                // update order, add card
                LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
                order.setCard(this.ocService.save(LiXiUtils.toLxOrderCard(uc)));
                
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
            return new ModelAndView("giftprocess2/add-a-card");

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
     * Show user's list billing address on a popup modal
     *
     * @param page
     * @param model
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "choose-billing-address-modal", method = RequestMethod.GET)
    public ModelAndView chooseBillingAddressModal(Map<String, Object> model, @PageableDefault(value = 6) Pageable page, HttpServletRequest request) {

        //Pageable just2rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        User u = this.userService.findByEmail(loginedUser.getEmail());

        Page<BillingAddress> addresses = this.baService.findByUser(u, page);

        model.put(LiXiConstants.BILLING_ADDRESS_ES, addresses);
        model.put(LiXiConstants.USER_LOGIN_ID, u.getId());

        return new ModelAndView("giftprocess2/billing-address-list", model);
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address/{id}", method = RequestMethod.GET)
    public ModelAndView getBillingAddress(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {

        //Pageable just2rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        User u = this.userService.findByEmail(loginedUser.getEmail());

        BillingAddress address = this.baService.findByIdAndUser(id, u);

        model.put(LiXiConstants.BILLING_ADDRESS, address);

        return new ModelAndView("giftprocess2/billing-address");
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
     * @param model
     * @param order
     * @param fees 
     */
    private void updateInvoiceBeforePayment(Map<String, Object> model, LixiOrder order, List<LixiGlobalFee> fees){
        
        LiXiUtils.calculateFee(model, order, fees);
        
        LixiInvoice invoice = order.getInvoice();
        if(invoice == null){
            invoice = new LixiInvoice();
        }
            
        invoice.setOrder(order);
        invoice.setInvoiceCode(LiXiUtils.getBeautyOrderId(order.getId()));
        invoice.setCardFee((Double)model.get(LiXiConstants.CARD_PROCESSING_FEE_THIRD_PARTY));
        invoice.setGiftPrice((Double)model.get(LiXiConstants.LIXI_GIFT_PRICE));
        invoice.setLixiFee(LiXiGlobalUtils.round2Decimal((Double)model.get(LiXiConstants.LIXI_HANDLING_FEE_TOTAL)));
        invoice.setTotalAmount(LiXiGlobalUtils.getTestTotalAmount((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL)));//
        invoice.setTotalAmountVnd((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL_VND));
        invoice.setNetTransStatus(EnumTransactionStatus.beforePayment.getValue());
        /* */
        Date currDate = Calendar.getInstance().getTime();
        invoice.setInvoiceDate(currDate);
        invoice.setCreatedDate(currDate);

        this.invoiceService.save(invoice);
        
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
            return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        }
        
        // calculate fee
        LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(
                this.countryService.findByName(LiXiUtils.getBillingAddress(order).getCountry())));

        model.put("LIXI_ORDER_ID", LiXiUtils.getBeautyOrderId(orderId));
        
        return new ModelAndView("giftprocess2/place-order");
    }
    
    private void setReturnValue(Map<String, Object> model, String error, String returnPage, String message){
        
        model.put("error", error);
        model.put("returnPage", returnPage);
        model.put("message", message);
        
    }
    
    private void insertLxCashRun(long inv, long order, String cashrun){
        
        LixiCashrun lxCashRun = new LixiCashrun();
        lxCashRun.setCashrun(cashrun);
        lxCashRun.setInvId(inv);
        lxCashRun.setOrderId(order);
        lxCashRun.setCreatedDate(Calendar.getInstance().getTime());

        this.cashRunService.save(lxCashRun);
                
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
        Map<String, Object> model = new HashMap<>();

        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            Date currDate = Calendar.getInstance().getTime();

            order = this.lxorderService.findById(orderId);
            LixiInvoice invoice = order.getInvoice();
            if(invoice == null){
                invoice = new LixiInvoice();
            }
            
            /* update invoice */
            /* get billing address */
            BillingAddress bl = LiXiUtils.getBillingAddress(order);

            // calculate fee
            LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(this.countryService.findByName(bl.getCountry())));

            invoice.setOrder(order);
            invoice.setPayer(loginedUser.getId());// payer is sender
            invoice.setInvoiceCode(LiXiUtils.getBeautyOrderId(orderId));
            invoice.setCardFee((Double)model.get(LiXiConstants.CARD_PROCESSING_FEE_THIRD_PARTY));
            invoice.setGiftPrice((Double)model.get(LiXiConstants.LIXI_GIFT_PRICE));
            invoice.setLixiFee((Double)model.get(LiXiConstants.LIXI_HANDLING_FEE_TOTAL));
            invoice.setTotalAmount((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL));//
            invoice.setTotalAmountVnd((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL_VND));
            invoice.setNetTransStatus(EnumTransactionStatus.beforePayment.getValue());
            invoice.setInvoiceStatus(LiXiGlobalUtils.translateNetTransStatus(EnumTransactionStatus.beforePayment.getValue()));
            invoice.setInvoiceDate(currDate);
            invoice.setCreatedDate(currDate);

            this.invoiceService.save(invoice);
            
            //////////////////////// CHARGE CREDIT CARD ////////////////////////
            boolean chargeResult = paymentService.chargeByCustomerProfile(invoice);
            if (chargeResult == false) {
                
                /* update invoice's status */
                invoice.setNetTransStatus(EnumTransactionStatus.paymentError.getValue());
                this.invoiceService.save(invoice);
                
                /**/
                setReturnValue(model, "1", "/checkout/paymentMethods?wrong=1", "error.payment-method");
                //return new ModelAndView(new RedirectView("/checkout/paymentMethods?wrong=1", true, true));
                return new ModelAndView("ajax/place-order-message", model);
            }
            else {
                // CashRun
                // ORDER_DESC
                StringBuilder orderDesc = new StringBuilder("");
                //ORDER_QUANTITY
                StringBuilder orderQuantity = new StringBuilder("");
                // ORDER_PRICE
                StringBuilder orderPrice = new StringBuilder("");
                
                for(LixiOrderGift gift : order.getGifts()){
                    orderDesc.append(gift.getProductName()).append(";");
                    orderQuantity.append(gift.getProductQuantity()).append(";");
                    orderPrice.append(LiXiUtils.getNumberFormat().format(gift.getProductPrice()));
                }
                
                Document doc = Jsoup.connect(LiXiGlobalConstants.CASHRUN_PRODUCTION_PAGE)
                    .timeout(0)
                    .maxBodySize(0)
                    .data("SITE_ID", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("ORDER_ID", invoice.getId().toString())
                    .data("SESSION_ID", request.getSession().getId())
                    .data("CUSTOMER_ID", invoice.getPayer().toString())
                    .data("BILLING_FIRST_NAME", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("BILLING_LAST_NAME", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("BILLING_STREET", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("BILLING_CITY", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("BILLING_ZIP", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("BILLING_EMAIL", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("BILLING_COUNTRY", "2b57448f3013fc513dcc7a4ab933e6928ab74672")
                    .data("IP_ADDRESS", LiXiGlobalUtils.getClientIp(request))
                    .data("AMOUNT", LiXiUtils.getNumberFormat().format(invoice.getTotalAmount()))
                    .data("BILLING_CURRENCY", "USD")
                    .data("ORDER_DESC", orderDesc.toString())
                    .data("ORDER_QUANTITY", orderQuantity.toString())
                    .data("ORDER_PRICE", orderPrice.toString())
                    .data("PAYMENT_METHOD", LiXiUtils.getPaymentMethod4CashRun(order.getCard().getCardType()))
                    .data("PAYMENT_STATUS", "1")
                    .data("LANG", "EN")
                    .data("DOMAIN", "lixi.global")
                    .data("CUSTOMER_STATUS", "2")
                    .data("PAYMENT_BIN", order.getCard().getCardBin())
                    .data("PAYMENT_FIRST_NAME", order.getSender().getFirstName())
                    .data("PAYMENT_CARDNO", order.getCard().getCardNumber())
                    .data("PAYMENT_EXPIRYDATE", LiXiUtils.getCardExpiryDateMMYY(order.getCard().getExpMonth(), order.getCard().getExpYear()))
                    .data("PAYMENT_3DSECURE", "0")
                    .data("TEST_FLAG", "0")
                    .data("API_KEY", "UkX5P9GIOL3ruCzMYRKFDJvQxbV86wpa")
                    //"Mozilla"
                    .userAgent(request.getHeader("User-Agent"))
                    .post();
                
                CashRun cashRunResult = LiXiUtils.parseCashRunResult(doc.toString());
                
                /* */
                insertLxCashRun(invoice.getId(), order.getId(), doc.toString());
                
                if(cashRunResult!=null && "001".equals(cashRunResult.getCode())){
                ////////////////////////////////////////////////////////////////
                /* update invoice's status */
                invoice.setNetTransStatus(EnumTransactionStatus.inProgress.getValue());
                this.invoiceService.save(invoice);
                
                /* update top up status */
                if(order.getTopUpMobilePhones()!= null){
                    order.getTopUpMobilePhones().forEach(t -> {t.setStatus(EnumLixiOrderStatus.TopUpStatus.UN_SUBMITTED.getValue());});
                    this.topUpService.save(order.getTopUpMobilePhones());
                }
                
                /* update order status */
                order.setLixiStatus(EnumLixiOrderStatus.UN_PROCESSED.getValue());
                order.setLixiSubStatus(EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue());
                order.setModifiedDate(currDate);
                this.lxorderService.save(order);
                
                /* Transaction Monitor, Async */
                this.transMoniService.transactions(order);
                
                // send mail to sender
                final String emailSender = order.getSender().getEmail();
                final List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
                final LixiOrder refOrder = order;
                // order date
                SimpleDateFormat sdfr = new SimpleDateFormat("MMM/dd/yyyy KK:mm:ss a");
                final String orderDate = sdfr.format(order.getModifiedDate());
                        
                MimeMessagePreparator preparator = new MimeMessagePreparator() {
                    @SuppressWarnings({"rawtypes", "unchecked"})
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {
                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage, "UTF-8");
                        message.setTo(emailSender);
                        message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                        message.addCc(LiXiGlobalConstants.CHONNH_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Invoice Alert");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map<String, Object> model = new HashMap<>();
                        model.put("sender", u);
                        model.put("orderDate", orderDate);
                                
                        model.put("LIXI_ORDER_ID", LiXiUtils.getBeautyOrderId(refOrder.getId()));
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

                ////////////////////////////////////////////////////////////////////
                log.info("Call Async methods");
                if(LiXiConstants.YES.equals(loginedUser.getConfig(LiXiConstants.VTC_AUTO))){
                    // The order is paid, top up mobile
                    lxAsyncMethods.processTopUpItems(order);

                    // Buy Cards
                    //lxAsyncMethods.processBuyCardItems(order);
                }
                //////////////////////// SUBMIT ORDER to BAOKIM:  Asynchronously ///
                log.info("submitOrdersToBaoKim");

                lxAsyncMethods.submitOrdersToBaoKim(order);

                log.info(" // END of submitOrdersToBaoKim");
                ////////////////////////////////////////////////////////////////////
                log.info("END OF Call Async methods");

                setReturnValue(model, "0", "/checkout/paymentMethods?wrong=1", "error.payment-method");
                return new ModelAndView("giftprocess2/thank-you", model);
                
                // jump to thank you page
                //return new ModelAndView(new RedirectView("/checkout/thank-you", true, true));
                }
                else{
                    // cashrun returns NO OK
                    setReturnValue(model, "0", "/checkout/paymentMethods?wrong=1", "error.payment-method");
                    return new ModelAndView("giftprocess2/thank-you", model);
                }
            } // charge is success
        }
        else {

            // order not exist, go to Choose recipient page
            // return new ModelAndView(new RedirectView("/gifts/chooseCategory", true, true));
            setReturnValue(model, "0", "/checkout/paymentMethods?wrong=1", "error.payment-method");
            return new ModelAndView("giftprocess2/thank-you", model);
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
    public ModelAndView thankYou(Map<String, Object> model, HttpServletRequest request) {

        model.put("LIXI_ORDER_ID", LiXiUtils.getBeautyOrderId((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID)));
        
        // remove Lixi order id
        request.getSession().removeAttribute(LiXiConstants.LIXI_ORDER_ID);

        //
        return new ModelAndView("giftprocess2/thank-you");
    }
    
    /**
     * 
     * @param model
     * @param giftId
     * @param quantity
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "update/gift/{giftId}/{quantity}", method = RequestMethod.GET)
    public ModelAndView update(Map<String, Object> model, @PathVariable Long giftId, @PathVariable Integer quantity, HttpServletRequest request) {
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        LixiOrder order = null;
        // check order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {
            order = this.lxorderService.findById(orderId);

        }
        /* get recipient */
        //Recipient rec = this.reciService.findById(recId);
        LixiOrderGift alreadyGift = this.lxogiftService.findById(giftId);
        
        
        // get price
        VatgiaProduct vgp = this.vgpService.findById(alreadyGift.getProductId());
        double price = vgp.getPrice();
        
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
        
        SumVndUsd[] currentPayments;
        currentPayments = LiXiUtils.calculateCurrentPayment(order, alreadyGift);
        
        double currentPayment = currentPayments[0].getUsd();//USD
        double currPaymentVnd = currentPayments[0].getVnd();
        if(quantity>0){
            // add selected gift
            currentPayment += (LiXiUtils.toUsdPrice(price, buy) * quantity);
            
            currPaymentVnd += (price * quantity);
        }
        
        if (currentPayment > (u.getUserMoneyLevel().getMoneyLevel().getAmount())) {

            // maximum payment is over
            model.put("exceed", 1);
            
            double exceededPaymentVND = (currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount()) * buy;
            double exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            
            model.put(LiXiConstants.EXCEEDED_VND, exceededPaymentVND);
            
            model.put(LiXiConstants.EXCEEDED_USD, exceededPaymentUSD);
         
            // restore value for already selected gift
            model.put(LiXiConstants.SELECTED_PRODUCT_ID, alreadyGift.getProductId());
            model.put(LiXiConstants.SELECTED_PRODUCT_QUANTITY, alreadyGift.getProductQuantity());
        }
        else{
            // the order is not exceeded
            model.put("exceed", 0);

            if(quantity > 0){
                // update quantity
                alreadyGift.setProductQuantity(quantity);

                this.lxogiftService.save(alreadyGift);
            }
            else{
                // remove the gift
                this.lxogiftService.delete(alreadyGift.getId());
            }
        }
        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currPaymentVnd);
        
        model.put("NEW_QUANTITY", quantity);
        model.put("NEW_TOTAL_ITEM_USD", quantity * vgp.getPriceInUSD(buy));
        model.put("NEW_TOTAL_ITEM_VND", quantity * vgp.getPrice());
        
        // calculate fee
        LiXiUtils.calculateFee(model, this.lxorderService.findById(orderId), this.feeService.findByCountry(
                this.countryService.findByName(LiXiUtils.getBillingAddress(order).getCountry())));

        return new ModelAndView("ajax/exceed");
    }
    
    /**
     * 
     * @param giftId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "delete/gift/{giftId}", method = RequestMethod.GET)
    public ModelAndView deleteGift(Map<String, Object> model, @PathVariable Long giftId, HttpServletRequest request) {
        
        // check the order
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(orderId == null){
            
            model.put("error", 1);
            model.put("message", "gift.wrong_with_value");
        }
        else{
            
            //LixiOrder order = this.lxorderService.findById(orderId);
            LixiOrderGift gift = this.lxogiftService.findById(giftId);
            Long recId = gift.getRecipient().getId();
            Integer catId = gift.getCategory().getId();
            if(gift.getOrder().getId().equals(orderId)){
                
                this.lxogiftService.delete(giftId);
                
            }
            
            model.put("error", 0);
        }
        
        LixiOrder order = this.lxorderService.findById(orderId);
        // calculate fee
        LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(
                this.countryService.findByName(LiXiUtils.getBillingAddress(order).getCountry())));
        
        return new ModelAndView("ajax/exceed");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "delete/topUp/{id}", method = RequestMethod.GET)
    public ModelAndView deleteTopUp(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {
        // check the order
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(orderId == null){
            
            model.put("error", 1);
            model.put("message", "gift.wrong_with_value");
        }
        else{
            // check top up belong to current order
            TopUpMobilePhone topUp = this.topUpService.findById(id);
            if(topUp.getOrder().getId().equals(orderId)){
                
                this.topUpService.deleteById(id);
                
            }
            
            model.put("error", 0);
        }
        
        LixiOrder order = this.lxorderService.findById(orderId);
        
        // calculate fee
        LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(
                this.countryService.findByName(LiXiUtils.getBillingAddress(order).getCountry())));
        
        return new ModelAndView("ajax/exceed");
        
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "delete/receiver/{id}", method = RequestMethod.GET)
    public ModelAndView deleteReceiver(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {
        // check the order
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(orderId == null){
            
            model.put("error", 1);
            model.put("message", "gift.wrong_with_value");
        }
        else{
            
            LixiOrder order = this.lxorderService.findById(orderId);
            Recipient recipient = this.reciService.findById(id);
            
            this.lxogiftService.deleteByOrderAndRecipient(order, recipient);
            this.topUpService.deleteByOrderAndRecipient(order, recipient);
            
            model.put("error", 0);
        }
        
        LixiOrder order = this.lxorderService.findById(orderId);
        
        // calculate fee
        LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(
                this.countryService.findByName(LiXiUtils.getBillingAddress(order).getCountry())));
        
        return new ModelAndView("ajax/exceed");
        
    }    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "jump2", method = RequestMethod.GET)
    public ModelAndView jump2(Map<String, Object> model, HttpServletRequest request){
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        if(order == null){
            
            return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        }
        else{
            if(order.getCard() != null || order.getBankAccount()!=null){
                return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
            }
            else{
                return new ModelAndView(new RedirectView("/gifts/order-summary", true, true));
            }
        }
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "updateInvoiceCode", method = RequestMethod.GET)
    public ModelAndView updateInvoiceCode(Map<String, Object> model, HttpServletRequest request){
        
        List<LixiInvoice> invoices = this.invoiceService.findAll();
        
        for(LixiInvoice inv : invoices){
            
            if(inv.getInvoiceCode() == null){
                
                inv.setInvoiceCode(LiXiUtils.getBeautyOrderId(inv.getOrder().getId()));
                
                this.invoiceService.save(inv);
            }
        }
        
        return new ModelAndView(new RedirectView("/user/orderHistory/lastWeek", true, true));
    }
    
    @UserSecurityAnnotation
    @RequestMapping(value = "updateInvoiceStatus", method = RequestMethod.GET)
    public ModelAndView updateInvoiceStatus(Map<String, Object> model, HttpServletRequest request){
        
        List<LixiInvoice> invoices = this.invoiceService.findAll();
        
        for(LixiInvoice inv : invoices){
            
            if(inv.getInvoiceStatus()== null){
                
                inv.setInvoiceStatus(LiXiGlobalUtils.translateNetTransStatus(inv.getNetTransStatus()));
                
                this.invoiceService.save(inv);
            }
        }
        
        return new ModelAndView(new RedirectView("/user/orderHistory/lastWeek", true, true));
    }    
}
