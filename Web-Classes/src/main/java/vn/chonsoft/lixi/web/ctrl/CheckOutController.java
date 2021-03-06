/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
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
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.EnumTransactionStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.LixiCashrun;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiGlobalFee;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderCard;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.ShippingCharged;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.form.AddCardForm;
import vn.chonsoft.lixi.model.form.BankAccountAddForm;
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
import vn.chonsoft.lixi.repositories.service.ShippingChargedService;
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
@PropertySource(value = "classpath:cashrun.properties")
public class CheckOutController {

    private static final Logger log = LogManager.getLogger(CheckOutController.class);
    
    @Autowired
    private Environment env;
    
    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private ShippingChargedService shipService;
    
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

    @Autowired
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
            bl.setFirstName(LiXiGlobalUtils.html2text(form.getFirstName()));
            bl.setLastName(LiXiGlobalUtils.html2text(form.getLastName()));
            bl.setAddress(LiXiGlobalUtils.html2text(form.getAddress()));
            bl.setCity(LiXiGlobalUtils.html2text(form.getCity()));
            bl.setState(LiXiGlobalUtils.html2text(form.getState()));
            bl.setZipCode(LiXiGlobalUtils.html2text(form.getZipCode()));
            bl.setCountry(LiXiGlobalUtils.html2text(form.getCountry()));
            bl.setUser(u);
            
            bl = this.baService.save(bl);
            
            // Add a card
            UserCard uc = new UserCard();
            uc.setUser(u);
            uc.setCardType(form.getCardType());
            uc.setCardName(LiXiGlobalUtils.html2text(form.getCardName()));
            uc.setBillingAddress(bl);
            uc.setModifiedDate(Calendar.getInstance().getTime());
            uc.setCardBin(StringUtils.left(form.getCardNumber(), 6));
            // pass real information to authorize.net
            uc.setCardNumber(LiXiGlobalUtils.html2text(form.getCardNumber()));
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
                //uc.setCardCvv(null); // comment on 2016/08/02, Mr Yuric asked
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
                this.countryService.findByCode(LiXiUtils.getBillingAddress(order).getCountry())), this.shipService.findAll());

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
            return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        }
        // check card is exist
        if((order.getCard() == null) || (this.ucService.findById(order.getCard().getId())==null)){
            // chua co thong tin thanh toan, hoac card da bi removed
            return new ModelAndView(new RedirectView("/checkout/addCard", true, true));
        }
        
        // calculate fee
        List<LixiGlobalFee> fees = this.feeService.findByCountry(this.countryService.findByCode(LiXiUtils.getBillingAddress(order).getCountry()));
        List<ShippingCharged> charged = this.shipService.findAll();
        LiXiUtils.calculateFee(model, order, fees, charged);

        model.put("LIXI_ORDER_ID", LiXiUtils.getBeautyOrderId(orderId));
        // current total order
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/place-order");
    }
    
    private void setReturnValue(Map<String, Object> model, String error, String returnPage, String message){
        
        model.put("error", error);
        model.put("returnPage", returnPage);
        model.put("message", message);
        
    }
    
    private void insertLxCashRun(long inv, long order, String cashrun, String actionType){
        
        log.info(cashrun);

        LixiCashrun lxCashRun = new LixiCashrun();
        
        lxCashRun.setActionType(actionType);
        lxCashRun.setCashrun(cashrun);
        lxCashRun.setInvId(inv);
        lxCashRun.setOrderId(order);
        lxCashRun.setCreatedDate(Calendar.getInstance().getTime());

        this.cashRunService.save(lxCashRun);
                
    }
    
    private CashRun connectCashRun(LixiInvoice invoice, LixiOrder order, HttpServletRequest request) throws IOException{
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
            orderPrice.append(LiXiUtils.getNumberFormat().format(gift.getUsdPrice())).append(";");
        }
        
        for(TopUpMobilePhone t : order.getTopUpMobilePhones()){
            orderDesc.append("Topup mobile number ").append(t.getPhone()).append(";");
            orderQuantity.append("1").append(";");
            orderPrice.append(LiXiUtils.getNumberFormat().format(t.getAmountUsd())).append(";");
        }
        
        /**
         * RECEIVER_DETAILS[]	Required
         * https://cashshieldasia.cashrun.com/merchant/iguide/guide_main.php
         */
        List<RecipientInOrder> rio = LiXiUtils.genMapRecGifts(order);
        //String[] receivers = null;
        List<NameValuePair> receivers = new ArrayList<>();
        if(rio != null && !rio.isEmpty()){
            for(int i = 0; i < rio.size(); i++){
                
                RecipientInOrder rec = rio.get(i);
                StringBuilder t = new StringBuilder();
                
                t.append(rec.getRecipient().getFullName());
                t.append(";");
                t.append(rec.getRecipient().getDialCode());
                t.append(rec.getRecipient().getPhone());
                t.append(";");
                t.append(rec.getRecipient().getEmail());
                t.append(";");
                t.append(rec.getRecipient().getNote());
                
                //log.info(t.toString());
                
                receivers.add(new BasicNameValuePair("RECEIVER_DETAILS[]", t.toString()));
            }
        }
        
        String countryCode = order.getCard().getBillingAddress().getCountry();
        String clientIpAddress = LiXiGlobalUtils.getClientIp(request);
        
        //log.info("Connect CashRun from Client Ip: " + clientIpAddress);
        //log.info("ORDER_ID (order.getId().toString()): " + order.getId().toString());
        //log.info("CASHRUN_PRODUCTION_PAGE: " + env.getProperty("cashrun.production-page"));
        
        Connection conn = Jsoup.connect(env.getProperty("cashrun.production-page")).timeout(0).maxBodySize(0);

        for(NameValuePair nv : receivers){
            conn.data(nv.getName(), nv.getValue());
        }
        
        // get first purchase for DATE_FIRSTPURCHASE
        // Date of customer's first successful purchase
        LixiInvoice firstPurchase = this.invoiceService.findFirstPurchase(invoice.getPayer(), LiXiGlobalConstants.TRANS_REPORT_STATUS_PROCESSED);
        if(firstPurchase != null){
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");
            conn.data("DATE_FIRSTPURCHASE", sdf.format(firstPurchase.getCreatedDate()));
        }
        
        Connection.Response doc = conn.data("SITE_ID", env.getProperty("cashrun.site-id"))
            .data("API_KEY", env.getProperty("cashrun.api-key"))
            .data("ORDER_ID", order.getId().toString())
            .data("SESSION_ID", request.getSession().getId())
            .data("CUSTOMER_ID", invoice.getPayer().toString())
            .data("HAS_RETURNS", "N")
            .data("BILLING_FIRST_NAME", order.getCard().getBillingAddress().getFirstName())
            .data("BILLING_LAST_NAME", order.getCard().getBillingAddress().getLastName())
            .data("BILLING_STREET", order.getCard().getBillingAddress().getAddress())
            .data("BILLING_CITY", order.getCard().getBillingAddress().getCity())
            .data("BILLING_ZIP", order.getCard().getBillingAddress().getZipCode())
            .data("BILLING_EMAIL", order.getSender().getEmail())
            .data("BILLING_COUNTRY", countryCode)
            .data("SHIPPING_FIRST_NAME", order.getCard().getBillingAddress().getFirstName())
            .data("SHIPPING_LAST_NAME", order.getCard().getBillingAddress().getLastName())
            .data("SHIPPING_STREET", order.getCard().getBillingAddress().getAddress())
            .data("SHIPPING_CITY", order.getCard().getBillingAddress().getCity())
            .data("SHIPPING_ZIP", order.getCard().getBillingAddress().getZipCode())
            .data("SHIPPING_EMAIL", order.getSender().getEmail())
            .data("SHIPPING_PHONE", order.getSender().getPhone())
            .data("SHIPPING_COUNTRY", countryCode)
            .data("IP_ADDRESS", clientIpAddress)
            .data("AMOUNT", LiXiUtils.getNumberFormat().format(invoice.getTotalAmount()))
            .data("BILLING_CURRENCY", "USD")
            .data("ORDER_DESC", orderDesc.toString())
            .data("ORDER_QUANTITY", orderQuantity.toString())
            .data("ORDER_PRICE", orderPrice.toString())
            .data("PAYMENT_METHOD", LiXiUtils.getPaymentMethod4CashRun(order.getCard().getCardType()))
            .data("PAYMENT_STATUS", "0")
            .data("PAYMENT_PROVIDER", "Authorize.Net")
            .data("LANG", "EN")
            .data("DOMAIN", "lixi.global")
            .data("CUSTOMER_STATUS", "2")
            .data("PRODUCT_TYPE", "2")
            .data("PAYMENT_BIN", order.getCard().getCardBin())
            .data("PAYMENT_FIRST_NAME", order.getSender().getFirstName())
            .data("PAYMENT_LAST_NAME", order.getSender().getLastName())
            .data("PAYMENT_CARDNO", order.getCard().getCardNumber())
            .data("PAYMENT_EXPIRYDATE", LiXiUtils.getCardExpiryDateMMYY(order.getCard().getExpMonth(), order.getCard().getExpYear()))
            .data("PAYMENT_3DSECURE", "0")
            .data("PAYMENT_COUNTRY", order.getCard().getBillingAddress().getCountry())
            .data("CUST_RATING", "0")
            .data("TEST_FLAG", "0")
            .ignoreContentType(true)
            //"Mozilla"
            .userAgent(request.getHeader("User-Agent"))
            .method(Connection.Method.POST)
            .execute();
            //.post();

        /* */
        insertLxCashRun(invoice.getId(), order.getId(), doc.body(), "Creating POST Request");
        
        CashRun cashRunResult = LiXiUtils.parseCashRunResult(doc.body());

        return cashRunResult;
    }
    
    /**
     * 
     * @param model
     * @param invoice
     * @return 
     */
    private ModelAndView failedAuthorizeNet(Map<String, Object> model, LixiInvoice invoice){
        
        /* update invoice's status */
        invoice.setNetTransStatus(EnumTransactionStatus.paymentError.getValue());
        this.invoiceService.save(invoice);

        /**/
        setReturnValue(model, "1", "/checkout/paymentMethods?wrong=1", "error.payment-method");
        //return new ModelAndView(new RedirectView("/checkout/paymentMethods?wrong=1", true, true));
        return new ModelAndView("ajax/place-order-message", model);
        
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
            LiXiUtils.calculateFee(model, order, this.feeService.findByCountry(this.countryService.findByCode(bl.getCountry())), this.shipService.findAll());

            invoice.setOrder(order);
            invoice.setPayer(loginedUser.getId());// payer is sender
            invoice.setInvoiceCode(LiXiUtils.getBeautyOrderId(orderId));
            invoice.setCardFee((Double)model.get(LiXiConstants.CARD_PROCESSING_FEE_THIRD_PARTY));
            invoice.setGiftPrice((Double)model.get(LiXiConstants.LIXI_GIFT_PRICE));
            invoice.setLixiFee((Double)model.get(LiXiConstants.LIXI_HANDLING_FEE_TOTAL));
            invoice.setVndShip((Double)model.get(LiXiConstants.TOTAL_SHIPPING_CHARGED_VND));
            invoice.setUsdShip((Double)model.get(LiXiConstants.TOTAL_SHIPPING_CHARGED));
            invoice.setTotalAmount((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL));//
            invoice.setTotalAmountVnd((Double)model.get(LiXiConstants.LIXI_FINAL_TOTAL_VND));
            invoice.setNetTransStatus(EnumTransactionStatus.beforePayment.getValue());
            invoice.setInvoiceStatus(LiXiGlobalUtils.translateNetTransStatus(EnumTransactionStatus.beforePayment.getValue()));
            invoice.setInvoiceDate(currDate);
            invoice.setCreatedDate(currDate);

            this.invoiceService.save(invoice);
            
            //////////////////////// CHARGE CREDIT CARD ////////////////////////
            //log.info("Begin Authorize Visa Card at: " + Calendar.getInstance().getTime());
            //long startTime = System.currentTimeMillis();
            boolean chargeResult = paymentService.chargeByCustomerProfile(invoice);
            //log.info("It takes " + (System.currentTimeMillis() - startTime)/1000 + " seconds.");
            //log.info("End Authorize Visa Card at: " + Calendar.getInstance().getTime());
            if (chargeResult == false) {
                
                return failedAuthorizeNet(model, invoice);
            }
            else {
                // CashRun
                //log.info("Begin Connect Card Run at: " + Calendar.getInstance().getTime());
                //startTime = System.currentTimeMillis();
                CashRun cashRunResult = connectCashRun(invoice, order, request);;
                //log.info("It takes " + (System.currentTimeMillis() - startTime)/1000 + " seconds.");
                //log.info("End Connect Card Run at: " + Calendar.getInstance().getTime());
                
                if(cashRunResult!=null && "001".equals(cashRunResult.getCode())){
                    
                    /* Capture a Previously Authorized Transaction */
                    //log.info("Begin Charged Visa Card at: " + Calendar.getInstance().getTime());
                    //startTime = System.currentTimeMillis();
                    boolean capture = paymentService.capturePreviouslyAuthorizedAmount(invoice);
                    //log.info("It takes " + (System.currentTimeMillis() - startTime)/1000 + " seconds.");
                    //log.info("End Charged Visa Card at: " + Calendar.getInstance().getTime());
                    if(capture == false){
                        
                        return failedAuthorizeNet(model, invoice);
                    }
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
                            //message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                            //message.addCc(LiXiGlobalConstants.CHONNH_GMAIL);
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
                            LiXiUtils.calculateFee(model, refOrder, feeService.findByCountry(countryService.findByCode(bl.getCountry())), shipService.findAll());

                            String text = VelocityEngineUtils.mergeTemplateIntoString(
                                    velocityEngine, "emails/paid-order-alert.vm", "UTF-8", model);
                            message.setText(text, true);
                        }
                    };
                    // send oldEmail
                    taskScheduler.execute(() -> mailSender.send(preparator));

                    ////////////////////////////////////////////////////////////////////
                    //log.info("Call Async methods");
                    //log.info("VTC_AUTO: " + loginedUser.getConfig(LiXiConstants.VTC_AUTO));
                    if(LiXiConstants.YES.equals(loginedUser.getConfig(LiXiConstants.VTC_AUTO))){
                        // The order is paid, top up mobile
                        lxAsyncMethods.processTopUpItems(order);

                        // Buy Cards
                        //lxAsyncMethods.processBuyCardItems(order);
                    }
                    /* CashShield Post Transaction Status Update */
                    lxAsyncMethods.cashRunTransactionStatusUpdate(request.getHeader("User-Agent"), invoice.getId(), orderId, LiXiUtils.getNumberFormat().format(invoice.getTotalAmount()), "USD");
                    
                    //////////////////////// SUBMIT ORDER to BAOKIM:  Asynchronously ///
                    //log.info("submitOrdersToBaoKim");

                    //lxAsyncMethods.submitOrdersToBaoKim(order); // remove BaoKim 2016-10-04

                    //log.info(" // END of submitOrdersToBaoKim");
                    
                    // email to all receivers
                    final String senderFullName = order.getSender().getFullName();
                    for(RecipientInOrder rio : recGifts){
                        MimeMessagePreparator m = new MimeMessagePreparator() {
                            @SuppressWarnings({"rawtypes", "unchecked"})
                            @Override
                            public void prepare(MimeMessage mimeMessage) throws Exception {
                                MimeMessageHelper message = new MimeMessageHelper(mimeMessage, "UTF-8");
                                message.setTo(rio.getRecipient().getEmail());
                                message.setFrom("support@lixi.global");
                                message.setSubject("LiXi.Global - New Gift Alert");
                                message.setSentDate(Calendar.getInstance().getTime());

                                Map<String, Object> model = new HashMap<>();
                                model.put("firstName", rio.getRecipient().getFirstName());
                                model.put("senderFullName", senderFullName);

                                String text = VelocityEngineUtils.mergeTemplateIntoString(
                                        velocityEngine, "emails/alert-rec-new-gifts.vm", "UTF-8", model);
                                message.setText(text, true);
                            }
                        };
                        // send oldEmail
                        taskScheduler.execute(() -> mailSender.send(m));
                    }
                    
                    ////////////////////////////////////////////////////////////////////
                    //log.info("END OF Call Async methods");

                    setReturnValue(model, "0", "/checkout/thank-you", "error.payment-method");
                    return new ModelAndView("ajax/place-order-message", model);

                    // jump to thank you page
                    //return new ModelAndView(new RedirectView("/checkout/thank-you", true, true));
                }
                else{
                    // cashrun returns NO OK
                    setReturnValue(model, "1", "/checkout/paymentMethods?wrong=1", "error.payment-method");
                    return new ModelAndView("ajax/place-order-message", model);
                }
            } // charge is success
        }
        else {

            // order not exist, go to Choose recipient page
            // return new ModelAndView(new RedirectView("/gifts/chooseCategory", true, true));
            setReturnValue(model, "1", "/gifts/chooseCategory", "error.payment-method");
            return new ModelAndView("ajax/place-order-message", model);
        }

    }

    /**
     *
     * Submit the order
     * 
     * @param model
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "thank-you", method = RequestMethod.GET)
    public ModelAndView thankYou(Map<String, Object> model, HttpServletRequest request) {

        if(request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) == null){
            return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        }
        else{
            
            model.put("LIXI_ORDER_ID", LiXiUtils.getBeautyOrderId((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID)));

            // remove Lixi order id
            request.getSession().removeAttribute(LiXiConstants.LIXI_ORDER_ID);

            //
            return new ModelAndView("giftprocess2/thank-you");
        }
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
    @RequestMapping(value = {"update/gift/{giftId}/{quantity}", "ajax/update/gift/{giftId}/{quantity}"}, method = RequestMethod.GET)
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
        
        model.put(LiXiConstants.SELECTED_RECIPIENT_ID, alreadyGift.getRecipient().getId());
        
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
            currentPayment += (LiXiGlobalUtils.toUsdPrice(price, buy) * quantity);
            
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
                this.countryService.findByCode(LiXiUtils.getBillingAddress(order).getCountry())), this.shipService.findAll());

        return new ModelAndView("ajax/exceed");
    }
    
    /**
     * 
     * @param giftId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = {"delete/gift/{giftId}", "ajax/delete/gift/{giftId}"}, method = RequestMethod.GET)
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
            if(gift.getOrder().getId().equals(orderId)){
                
                // get back RECIPIENT id
                model.put(LiXiConstants.SELECTED_RECIPIENT_ID, gift.getRecipient().getId());
                
                this.lxogiftService.delete(giftId);
                
            }
            
            model.put("error", 0);
        }
        
        LixiOrder order = this.lxorderService.findById(orderId);
        // calculate fee
        List<LixiGlobalFee> fees = this.feeService.findByCountry(
                this.countryService.findByCode(LiXiUtils.getBillingAddress(order).getCountry()));
        LiXiUtils.calculateFee(model, order, fees, this.shipService.findAll());
        
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
                this.countryService.findByCode(LiXiUtils.getBillingAddress(order).getCountry())), this.shipService.findAll());
        
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
                this.countryService.findByCode(LiXiUtils.getBillingAddress(order).getCountry())), this.shipService.findAll());
        
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
