/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javax.mail.internet.MimeMessage;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.ws.WebServiceException;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.BuyCard;
import vn.chonsoft.lixi.model.BuyCardResult;
import vn.chonsoft.lixi.model.DauSo;
import vn.chonsoft.lixi.model.LixiCardFee;
import vn.chonsoft.lixi.model.LixiFee;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.TopUpResult;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.VtcResponseCode;
import vn.chonsoft.lixi.model.VtcServiceCode;
import vn.chonsoft.lixi.model.form.BankAccountAddForm;
import vn.chonsoft.lixi.model.form.BillingAddressForm;
import vn.chonsoft.lixi.model.form.CardAddForm;
import vn.chonsoft.lixi.model.pojo.EnumLixiOrderSetting;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.BuyCardResultService;
import vn.chonsoft.lixi.repositories.service.BuyCardService;
import vn.chonsoft.lixi.repositories.service.DauSoService;
import vn.chonsoft.lixi.repositories.service.LixiCardFeeService;
import vn.chonsoft.lixi.repositories.service.LixiFeeService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.repositories.service.TopUpResultService;
import vn.chonsoft.lixi.repositories.service.UserBankAccountService;
import vn.chonsoft.lixi.repositories.service.UserCardService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VtcResponseCodeService;
import vn.chonsoft.lixi.repositories.service.VtcServiceCodeService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.beans.VtcPayClient;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CreditCardProcesses;
import vn.chonsoft.lixi.web.beans.LiXiSecurityManager;
import vn.chonsoft.lixi.web.util.LiXiUtils;
import vn.chonsoft.lixi.web.beans.TripleDES;
import vn.vtc.pay.RequestTransactionResponse;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("checkout")
public class CheckOutController {

    private static final Logger log = LogManager.getLogger(CheckOutController.class);

    @Inject
    private RecipientService reciService;

    @Inject
    private UserService userService;

    @Inject
    private UserCardService ucService;

    @Inject
    private BillingAddressService baService;

    @Inject
    private LixiOrderService lxorderService;

    @Inject
    private LixiOrderGiftService lxogiftService;

    @Inject
    private RecipientService recService;

    @Inject
    private UserBankAccountService ubcService;

    @Inject
    private LixiFeeService feeService;

    @Inject
    private LixiCardFeeService cardFeeService;

    @Inject
    private LiXiSecurityManager securityManager;

    @Inject
    private TripleDES tripleDES;

    @Inject
    private VtcPayClient vtcClient;

    @Inject
    private JavaMailSender mailSender;

    @Inject
    private VelocityEngine velocityEngine;

    @Inject
    private DauSoService dauSoService;

    @Inject
    private VtcServiceCodeService vtcServiceCodeService;

    @Inject
    private TopUpResultService turService;

    @Inject
    private BuyCardService bcService;
    
    @Inject
    private BuyCardResultService bcrService;

    @Inject
    private TopUpMobilePhoneService topUpService;
    
    @Inject
    private VtcResponseCodeService responseCodeService;
    
    @Inject
    private CreditCardProcesses creaditCardProcesses;
    /**
     * Add a card
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "cards/add", method = RequestMethod.GET)
    public ModelAndView addACard(Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        List<UserCard> cards = this.ucService.findByUser(u);
        if (cards == null || cards.isEmpty()) {

            // back url
            model.put("backUrl", "/gifts/more-recipient");
        } else {
            model.put("backUrl", "/checkout/cards/change");
        }

        CardAddForm addForm = new CardAddForm();
        addForm.setCardType(1);

        model.put("cardAddForm", addForm);

        return new ModelAndView("giftprocess/add-a-card", model);

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

            if (!LiXiUtils.checkMonthYearGreaterThanCurrent(form.getExpMonth(), form.getExpYear())) {

                model.put("expiration_failed", 1);

                return new ModelAndView("giftprocess/add-a-card", model);
            }

            // check card number
            UserCard lastUC = this.ucService.findByCardNumber(form.getCardNumber());
            if (lastUC != null) {

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
            //remove bank account IF it has
            order.setBankAccount(null);

            this.lxorderService.save(order);

            // check billing address
            Pageable just6rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
            Page<BillingAddress> addresses = this.baService.findByUser(u, just6rec);
            if (addresses != null && addresses.hasContent()) {
                // jump to page choose billing address
                return new ModelAndView(new RedirectView("/checkout/choose-billing-address", true, true));
            } else {
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
     * pay by card
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "cards/change", method = RequestMethod.GET)
    public ModelAndView cards(Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        // check already have card
        List<UserCard> cards = this.ucService.findByUser(u);
        if (cards == null || cards.isEmpty()) {

            // pay by card, set bank account is null
            order.setBankAccount(null);
            this.lxorderService.save(order);

            // there is no card, it means user had no order
            return new ModelAndView(new RedirectView("/checkout/cards/add", true, true));
        } else {

            // choose payment method
            return new ModelAndView(new RedirectView("/checkout/payment-method/change", true, true));
        }
    }

    ////////////////////////// Bank Account
    /**
     * pay by bank account
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "pay-by-bank-account/change", method = RequestMethod.GET)
    public ModelAndView payByBankAccount(Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        List<UserBankAccount> accounts = this.ubcService.findByUser(u);
        if (accounts == null || accounts.isEmpty()) {

            // pay by bank account, set card is null
            order.setCard(null);
            this.lxorderService.save(order);

            // there is no bank account, add a new
            return new ModelAndView(new RedirectView("/checkout/pay-by-bank-account/add", true, true));
        } else {

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
    public ModelAndView addBankAccount(Map<String, Object> model, HttpServletRequest request) {

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
    @RequestMapping(value = "pay-by-bank-account/add", method = RequestMethod.POST)
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
    public ModelAndView changePaymentMethod(Map<String, Object> model, HttpServletRequest request) {
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        List<UserBankAccount> accs = this.ubcService.findByUser(u);
        List<UserCard> cards = this.ucService.findByUser(u);

        // no card and no bank account
        if (accs.isEmpty() && cards.isEmpty()) {
            return new ModelAndView(new RedirectView("/checkout/cards/add", true, true));
        } else {
            model.put(LiXiConstants.ACCOUNTS, accs);
            model.put(LiXiConstants.CARDS, cards);
            model.put(LiXiConstants.LIXI_ORDER, order);

            return new ModelAndView("giftprocess/change-payment-method");
        }
    }

    /**
     *
     * User change payment method
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "payment-method/change", method = RequestMethod.POST)
    public ModelAndView changePaymentMethod(HttpServletRequest request) {

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
            if (cardIdStr != null && !"".equals(cardIdStr)) {
                cardId = Long.parseLong(cardIdStr);
            }
            //
            if (accIdStr != null && !"".equals(accIdStr)) {
                accId = Long.parseLong(accIdStr);
            }
        } catch (Exception e) {
            log.info("parse number wrong", e);
        }

        // There is something wrong
        if (accId <= 0 && cardId <= 0) {

            return new ModelAndView(new RedirectView("/checkout/payment-method/change?wrong=1", true, true));
        }

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        if (cardId > 0) {
            //
            order.setCard(this.ucService.findById(cardId));
            order.setBankAccount(null);
        } else {
            //
            order.setBankAccount(this.ubcService.findById(accId));
            order.setCard(null);
        }

        this.lxorderService.save(order);

        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
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
    public ModelAndView chooseBillingAddress(Map<String, Object> model, @PageableDefault(value = 6) Pageable page, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        //Pageable just2rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        Page<BillingAddress> addresses = this.baService.findByUser(u, page);
        if (addresses == null || addresses.getContent() == null || addresses.getContent().isEmpty()) {
            // jump to add new address
            return new ModelAndView(new RedirectView("/checkout/billing-address", true, true));
        }
        model.put(LiXiConstants.BILLING_ADDRESS_ES, addresses);
        model.put(LiXiConstants.USER_LOGIN_ID, u.getId());

        return new ModelAndView("giftprocess/choose-billing-address", model);
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
    @RequestMapping(value = "choose-billing-address-modal", method = RequestMethod.GET)
    public ModelAndView chooseBillingAddressModal(Map<String, Object> model, @PageableDefault(value = 6) Pageable page, HttpServletRequest request) {

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
     * Enter a new billing address on a modal popup
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "billing-address-modal", method = RequestMethod.GET)
    public ModelAndView billingAddressModal(Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        model.put("billingAddressForm", new BillingAddressForm());

        return new ModelAndView("giftprocess/billing-address-modal");

    }

    /**
     *
     * Submit a new billing address from a modal popup
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
     * A billing address is selected
     *
     * @param baId
     * @param request
     * @return
     */
    @RequestMapping(value = "billing-address/{baId}", method = RequestMethod.GET)
    public ModelAndView billingAddress(@PathVariable Long baId, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        // login user
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        BillingAddress ba = this.baService.findByIdAndUser(baId, u);
        if (ba == null) {

            return new ModelAndView("giftprocess/billing-address");
        } else {

            // update bill address attr for selected card
            LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

            UserCard uc = order.getCard();
            if (uc != null) {
                //
                uc.setBillingAddress(this.baService.findById(baId));
                order.setCard(this.ucService.save(uc));
                // update order
                this.lxorderService.save(order);
            } else {

                UserBankAccount ubc = order.getBankAccount();
                if (ubc != null) {
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
     * Add new billing address
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "billing-address", method = RequestMethod.GET)
    public ModelAndView billingAddress(Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        model.put("billingAddressForm", new BillingAddressForm());

        return new ModelAndView("giftprocess/billing-address");

    }

    /**
     *
     * Submit a new billing address
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

            // update billing address for card or bank account
            LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

            UserCard uc = order.getCard();
            if (uc != null) {
                //
                uc.setBillingAddress(bil);
                this.ucService.save(uc);
            } else {

                UserBankAccount ubc = order.getBankAccount();
                if (ubc != null) {
                    // update billing address for ubc
                    ubc.setBillingAddress(bil);
                    this.ubcService.save(ubc);
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
     * Edit recipient's phone number
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "edit-rec-phone", method = RequestMethod.POST)
    public ModelAndView editRecMobilePhone(HttpServletRequest request) {

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
     * Edit recipient's phone number
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "edit-email", method = RequestMethod.POST)
    public ModelAndView editRecEmail(HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        String recId = request.getParameter("recId");
        String email = request.getParameter("emailAddress");

        this.recService.updateEmail(email, Long.parseLong(recId));

        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }

    /**
     *
     * @param model
     * @param order
     */
    private void calculateFee(Map<String, Object> model, LixiOrder order) {

        LixiFee handlingFee = this.feeService.findByCode(LiXiConstants.LIXI_HANDLING_FEE);
        LixiFee cardProcessingFeeAddOn = this.feeService.findByCode(LiXiConstants.LIXI_CARD_PROCESSING_FEE_ADD_ON);

        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.REC_GIFTS, recGifts);

        // calculate the total
        double finalTotal = 0;
        SumVndUsd[] totals = LiXiUtils.calculateCurrentPayment(order);
        double total = totals[0].getUsd();//usd

        // card processing fee
        double cardFeeNumber = 0;
        if (order.getCard() != null) {

            // get card fee
            LixiCardFee cardFeeByThirdParty = this.cardFeeService.findByCardTypeAndCreditDebitAndCountry(order.getCard().getCardType(), "DEBIT", "USA");

            if (order.getSetting() == EnumLixiOrderSetting.ALLOW_REFUND.getValue()) {
                cardFeeNumber = ((total * cardFeeByThirdParty.getAllowRefund()) / 100.0);
            } else {
                cardFeeNumber = ((total * cardFeeByThirdParty.getGiftOnly()) / 100.0);
            }
        } else {

            // payment by bank account
            LixiFee eCheckFee = null;
            if (order.getSetting() == EnumLixiOrderSetting.ALLOW_REFUND.getValue()) {
                // get echeck fee
                eCheckFee = this.feeService.findByCode(LiXiConstants.LIXI_ECHECK_FEE_ALLOW_REFUND);
            } else {
                eCheckFee = this.feeService.findByCode(LiXiConstants.LIXI_ECHECK_FEE_GIFT_ONLY);
            }

            cardFeeNumber = ((total * eCheckFee.getFee()) / 100.0);
        }

        // LIXI_CARD_PROCESSING_FEE_ADD_ON
        cardFeeNumber += cardProcessingFeeAddOn.getFee();
        // round two decimals
        cardFeeNumber = Math.round(cardFeeNumber * 100.0) / 100.0;

        // final total 
        finalTotal = total + cardFeeNumber + (handlingFee.getFee() * (recGifts.isEmpty() ? 0 : recGifts.size()));

        // update final total into db
        order.setTotalAmount(new BigDecimal(LiXiUtils.getNumberFormat().format(finalTotal)));
        
        this.lxorderService.save(order);
        //
        model.put(LiXiConstants.LIXI_ALL_TOTAL, totals);
        model.put(LiXiConstants.LIXI_FINAL_TOTAL, finalTotal);
        model.put(LiXiConstants.LIXI_HANDLING_FEE, handlingFee);
        model.put(LiXiConstants.LIXI_HANDLING_FEE_TOTAL, handlingFee.getFee() * recGifts.size());
        model.put(LiXiConstants.CARD_PROCESSING_FEE_THIRD_PARTY, cardFeeNumber);
    }

    /**
     *
     *
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "place-order", method = RequestMethod.GET)
    public ModelAndView placeOrder(Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);
        } else {

            // order not exist, go to Choose recipient page
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }

        // calculate fee
        calculateFee(model, order);

        return new ModelAndView("giftprocess/place-order");
    }

    /**
     *
     * Ajax call to re-calculate fee
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "place-order/calculateFee/{setting}", method = RequestMethod.GET)
    public ModelAndView calculateFee(Map<String, Object> model, @PathVariable Integer setting, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

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
        calculateFee(model, order);

        return new ModelAndView("giftprocess/fees");
    }

    /**
     *
     * @param model
     * @param recId
     * @param request
     * @return
     */
    @RequestMapping(value = "deleteReceiver/{recId}", method = RequestMethod.GET)
    public ModelAndView deleteReceiver(Map<String, Object> model, @PathVariable Long recId, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);
        } else {

            // order not exist, go to Choose recipient page
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }

        Recipient rec = this.reciService.findById(recId);
        // delete recipient
        this.lxogiftService.deleteByOrderAndRecipient(order, rec);

        // jump
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }

    /**
     *
     * Set setting: gift only or allow refund
     *
     * @param setting
     * @param request
     * @return
     */

    @RequestMapping(value = "place-order/settings/{setting}", method = RequestMethod.GET)
    public ModelAndView settings(@PathVariable Integer setting, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);

            // save setting
            order.setSetting(setting);

            this.lxorderService.save(order);

        }
        // jump
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));

    }

    /**
     * 
     * @param phone
     * @return 
     */
    private DauSo getDauSo(String phone) {

        // check phone number belongs to which networks ?
        if (!phone.startsWith("0")) {
            phone = "0" + phone;
        }
        // check first three numbers
        List<DauSo> dauSos = dauSoService.findByCode(StringUtils.substring(phone, 0, 3));
        if (dauSos.isEmpty()) {
            //check four numbers
            dauSos = dauSoService.findByCode(StringUtils.substring(phone, 0, 4));
        }

        return dauSos.get(0);
    }

    /**
     *
     * submit order Set setting: gift only or allow refund
     *
     * @param setting
     * @param request
     * @return
     */
    @RequestMapping(value = "place-order", method = RequestMethod.POST)
    public ModelAndView placeOrder(@RequestParam Integer setting, HttpServletRequest request) throws Exception {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        User u = this.userService.findByEmail((String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL));

        LixiOrder order = null;
        // order already created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);

            // save setting
            order.setSetting(setting);
            // modified date
            order.setModifiedDate(Calendar.getInstance().getTime());

            this.lxorderService.save(order);
            //////////////////////// CHARGE CREDIT CARD ////////////////////////
            boolean chargeResult = creaditCardProcesses.charge(order);
            if(chargeResult == false){
                return new ModelAndView(new RedirectView("/checkout/payment-method/change?wrong=1", true, true));
            }
            else{
                // already paid
                order.setIsPaid(Boolean.TRUE);
                this.lxorderService.save(order);
               
                // send mail to sender
                final String emailSender = order.getSender().getEmail();
                final List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
                final LixiOrder refOrder = order;
                MimeMessagePreparator preparator = new MimeMessagePreparator() {
                    @SuppressWarnings({"rawtypes", "unchecked"})
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {
                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                        message.setTo(emailSender);
                        message.setCc(LiXiConstants.YHANNART_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Invoice Alert");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map<String, Object> model = new HashMap<>();
                        model.put("sender", u);
                        model.put("LIXI_ORDER", refOrder);
                        model.put("REC_GIFTS", recGifts);
                        calculateFee(model, refOrder);

                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                                velocityEngine, "emails/paid-order-alert.vm", "UTF-8", model);
                        message.setText(text, true);
                    }
                };
                // send oldEmail
                ExecutorService executor = Executors.newSingleThreadExecutor();
                executor.execute(() -> mailSender.send(preparator));
                executor.shutdown();
                
            }
            ////////////////////////////////////////////////////////////////////
            // The order is paid, top up mobile
            for (TopUpMobilePhone topUp : order.getTopUpMobilePhones()) {

                Recipient rec = topUp.getRecipient();
                String amount = "10000"; // new Long((long)topUp.getAmount()).toString();
                String account = rec.getPhone(); // phone number

                DauSo dauSo = getDauSo(account);
                    //if(!dauSos.isEmpty()){

                VtcServiceCode serviceCode = this.vtcServiceCodeService.findByNetworkAndLxChucNang(dauSo.getNetwork(), LiXiConstants.NAP_TIEN_TRA_TRUOC);

                String requestData = vtcClient.topUpRequestData(topUp.getId(), serviceCode.getCode(), account, amount);
                
                RequestTransactionResponse response = null;
                try {
                    // call vtc's service
                    response = vtcClient.topupTelco(requestData);
                    
                } catch (WebServiceException e) {
                    log.info(e.getMessage(), e);
                    /* handle exception */
                    // update topup
                    topUp.setIsSubmitted(-1);
                    topUp.setResponseCode(-1);
                    topUp.setResponseMessage(e.getMessage());
                    
                    this.topUpService.save(topUp);
                    
                    // email to sender, receiver, admin
                    
                }
                
                if(response != null){
                    // <ResponseCode>|<OrgTransID>|<PartnerBalance>|<DataSign>
                    String vtcReturned = response.getRequestTransactionResult();
                    log.info(vtcReturned);

                    // save result into database
                    TopUpResult tur = new TopUpResult();
                    tur.setTopUp(topUp);
                    tur.setRequestData(requestData);
                    tur.setResponseData(vtcReturned);
                    tur.setTopUp(topUp);
                    tur.setModifiedDate(Calendar.getInstance().getTime());

                    this.turService.save(tur);

                    // parse result
                    String[] results = vtcReturned.split("\\|");
                    if (LiXiConstants.VTC_OK.equals(results[0])) {
                        // update topup
                        topUp.setIsSubmitted(1);
                        topUp.setResponseCode(1);//OK
                        topUp.setResponseMessage("OK");

                        this.topUpService.save(topUp);

                        // send email
                        MimeMessagePreparator preparator = new MimeMessagePreparator() {
                            @SuppressWarnings({"rawtypes", "unchecked"})
                            @Override
                            public void prepare(MimeMessage mimeMessage) throws Exception {
                                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                                message.setTo(rec.getEmail());
                                message.setCc(LiXiConstants.CHONNH_GMAIL);
                                message.setFrom("support@lixi.global");
                                message.setSubject("LiXi.Global - Top Up Mobile Minutes Alert");
                                message.setSentDate(Calendar.getInstance().getTime());

                                Map model = new HashMap();
                                model.put("rec", rec);
                                model.put("sender", u);
                                model.put("amount", topUp.getAmount());

                                String text = VelocityEngineUtils.mergeTemplateIntoString(
                                        velocityEngine, "emails/topup-confirmation.vm", "UTF-8", model);
                                message.setText(text, true);
                            }
                        };
                        // send oldEmail
                        ExecutorService executor = Executors.newSingleThreadExecutor();
                        executor.execute(() -> mailSender.send(preparator));
                        executor.shutdown();
                    }// enf if TOP UP is OK
                    else {

                        // what to do if VTC TOP UP is failed ???

                        // update topup
                        VtcResponseCode vtcResponse = this.responseCodeService.findByCode(Integer.parseInt(results[0]));

                        topUp.setIsSubmitted(1);
                        topUp.setResponseCode(vtcResponse.getCode());//OK
                        topUp.setResponseMessage(vtcResponse.getDescription());

                        this.topUpService.save(topUp);
                    }
                }
            }// forEach topUps

            // Buy cards
            log.info("buyCard is empty:" + order.getBuyCards().isEmpty());
            for (BuyCard bc : order.getBuyCards()) {
                Long id = bc.getId();
                Recipient rec = bc.getRecipient();
                String amount = "10000";
                String quantity = "1";
                DauSo dauSo = getDauSo(rec.getPhone());
                VtcServiceCode serviceCode = this.vtcServiceCodeService.findByNetworkAndLxChucNang(dauSo.getNetwork(), LiXiConstants.MUA_LAY_THE_CAO);
                String requestData = vtcClient.buyCardRequestData(id, serviceCode.getCode(), amount, quantity);
                RequestTransactionResponse response = vtcClient.buyCard(requestData);
                String vtcReturned = response.getRequestTransactionResult();
                log.info("buyCard: " + vtcReturned);
                BuyCardResult bcr = new BuyCardResult();
                bcr.setBuyCard(bc);
                bcr.setBuyRequest(requestData);
                bcr.setBuyResponse(vtcReturned);
                bcr.setModifiedDate(Calendar.getInstance().getTime());
                bcr = this.bcrService.save(bcr);
                String[] rs = vtcReturned.split("\\|");
                if (LiXiConstants.VTC_OK.equals(rs[0])) {

                    // VTCTransID
                    String vtcTransId = rs[2];
                    log.info("vtcTransId: " + vtcTransId);
                    // generate request data
                    String getCardRequestData = vtcClient.getCardData(vtcTransId, serviceCode.getCode(), amount);
                    
                    log.info("getCardRequestData: " + getCardRequestData);
                    
                    // cal vtc's get card service
                    RequestTransactionResponse getCardRresponse = vtcClient.getCard(getCardRequestData);
                    // 
                    String getCardRReturned = getCardRresponse.getRequestTransactionResult();
                    log.info("getCardRReturned: "+getCardRReturned);

                    // dycrept
                    String getCardDecrypt = vtcClient.decryptTripleDES(getCardRReturned);
                    log.info("getCardDecrypt: "+getCardDecrypt);

                    // store into db
                    bcr.setGetRequest(getCardRequestData);
                    bcr.setGetResponse(getCardRReturned);
                    bcr.setGetResponseDecrypt(getCardDecrypt);

                    bcr.setModifiedDate(Calendar.getInstance().getTime());

                    this.bcrService.save(bcr);
                    //
                    String[] rss = getCardDecrypt.split("\\|");
                    log.info("rss.length: " + rss.length);

                    String[] cards = new String[rss.length - 2];

                    System.arraycopy(rss, 2, cards, 0, cards.length);

                    if (LiXiConstants.VTC_OK.equals(rss[0])) {
                        // update buycard
                        bc.setIsSubmitted(1);
                        bc.setResponseCode(1);// OK
                        bc.setResponseMessage("OK");
                        
                        this.bcService.save(bc);
                        
                        // add type of card
                        for(int i = 0; i< cards.length; i++){
                            cards[i] = serviceCode.getName() + " " + cards[i];
                        }
                        // send email
                        MimeMessagePreparator preparator = new MimeMessagePreparator() {
                            @SuppressWarnings({"rawtypes", "unchecked"})
                            @Override
                            public void prepare(MimeMessage mimeMessage) throws Exception {
                                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                                message.setTo(rec.getEmail());
                                message.setCc(LiXiConstants.CHONNH_GMAIL);
                                message.setFrom("support@lixi.global");
                                message.setSubject("LiXi.Global - Phone Cards Alert");
                                message.setSentDate(Calendar.getInstance().getTime());

                                Map model = new HashMap();
                                model.put("rec", rec);
                                model.put("sender", u);
                                model.put("numOfCard", bc.getNumOfCard());
                                model.put("valueOfCard", bc.getValueOfCard());
                                model.put("cards", Arrays.asList(cards));

                                String text = VelocityEngineUtils.mergeTemplateIntoString(
                                        velocityEngine, "emails/buycard-alert.vm", "UTF-8", model);

                                message.setText(text, true);
                            }
                        };
                        // send oldEmail
                        ExecutorService executor = Executors.newSingleThreadExecutor();
                        executor.execute(() -> mailSender.send(preparator));
                        executor.shutdown();
                    } else {
                        
                        // what to do when getcard is failed
                        
                        // update buycard
                        VtcResponseCode vtcResponse = this.responseCodeService.findByCode(Integer.parseInt(rss[0]));
                        bc.setIsSubmitted(1);
                        bc.setResponseCode(vtcResponse.getCode());// OK
                        bc.setResponseMessage(vtcResponse.getDescription());
                        
                        this.bcService.save(bc);
                        //
                        
                    }
                } else {
                    // what to do when buy card failed

                    // update buycard
                    VtcResponseCode vtcResponse = this.responseCodeService.findByCode(Integer.parseInt(rs[0]));
                    bc.setIsSubmitted(1);
                    bc.setResponseCode(vtcResponse.getCode());// OK
                    bc.setResponseMessage(vtcResponse.getDescription());

                    this.bcService.save(bc);
                    //
                }
            }
            //}
            // jump to thank you page
            return new ModelAndView(new RedirectView("/checkout/thank-you", true, true));
        } else {

            // order not exist, go to Choose recipient page
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }

    }

    /**
     *
     * Submit the order
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "thank-you", method = RequestMethod.GET)
    public ModelAndView thankYou(HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        log.info("update lixiStatus");
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        LixiOrder order = this.lxorderService.findById(orderId);
        log.info("orderId: " + orderId);
        log.info("LIXI_ORDER_NOT_YET_SUBMITTED: " + LiXiConstants.LIXI_ORDER_NOT_YET_SUBMITTED);
        // update finished status
        log.info("order.getLixiStatus: " + order.getLixiStatus());
        order.setLixiStatus(LiXiConstants.LIXI_ORDER_NOT_YET_SUBMITTED);
        order = this.lxorderService.save(order);
        log.info("update result: " +order.getLixiStatus());

        // remove Lixi order id
        request.getSession().removeAttribute(LiXiConstants.LIXI_ORDER_ID);

        //
        return new ModelAndView("giftprocess/thank-you");
    }
}
