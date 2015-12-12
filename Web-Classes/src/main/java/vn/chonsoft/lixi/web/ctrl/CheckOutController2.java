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
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.form.AddCardForm;
import vn.chonsoft.lixi.model.form.BankAccountAddForm;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.LixiCardFeeService;
import vn.chonsoft.lixi.repositories.service.LixiFeeService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
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
    private JavaMailSender mailSender;

    @Inject
    private ThreadPoolTaskScheduler taskScheduler;

    @Inject
    private VelocityEngine velocityEngine;

    @Inject
    private CreditCardProcesses creaditCardProcesses;

    @Inject
    private LixiAsyncMethods lxAsyncMethods;
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "paymentMethods", method = RequestMethod.GET)
    public ModelAndView changePaymentMethod(Map<String, Object> model, HttpServletRequest request) {
        
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
     * @param model
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "addCard", method = RequestMethod.GET)
    public ModelAndView addCard(Map<String, Object> model) {
        
        User u = this.userService.findByEmail(loginedUser.getEmail());
        List<UserCard> cards = this.ucService.findByUser(u);
        if (cards == null || cards.isEmpty()) {
            // return url
            model.put("returnUrl", "/gifts/order-summary");
        } else {
            model.put("returnUrl", "/checkout/paymentMethods");
        }
        
        /* card form */
        AddCardForm addForm = new AddCardForm();
        addForm.setCardType(1);
        model.put("addCardForm", addForm);
        
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

        log.info("hi ! I'm here");
        
        if (errors.hasErrors()) {
            log.info("hi ! error");
            log.info(errors.getFieldError().getField());
            //errors.getAllErrors().forEach(x -> {log.info(x.getObjectName());});
            return new ModelAndView("giftprocess2/add-a-card");
        }

        try {

            if (!LiXiUtils.checkMonthYearGreaterThanCurrent(form.getExpMonth(), form.getExpYear())) {

                log.info("hi ! error 2");
                model.put("expiration_failed", 1);

                return new ModelAndView("giftprocess2/add-a-card", model);
            }

            User u = this.userService.findByEmail(loginedUser.getEmail());

            // Add a card
            UserCard uc = new UserCard();
            uc.setUser(u);
            uc.setCardType(form.getCardType());
            uc.setCardName(form.getCardName());
            /* Don't store full card information */
            uc.setCardNumber("XXXX"+StringUtils.right(form.getCardNumber(), 4));
            uc.setExpMonth(0);
            uc.setExpYear(0);
            uc.setCardCvv(0);
            uc.setModifiedDate(Calendar.getInstance().getTime());
            
            uc = this.ucService.save(uc);
            
            // pass real information
            uc.setCardNumber(form.getCardNumber());
            uc.setExpMonth(form.getExpMonth());
            uc.setExpYear(form.getExpYear());
            uc.setCardCvv(form.getCvv());
            
            log.info(form.getCardNumber());
            /* Create authorize.net profile */
            if(StringUtils.isEmpty(u.getAuthorizeProfileId())){
                this.creaditCardProcesses.createCustomerProfile(u, uc);
            }
            else{
                this.creaditCardProcesses.createPaymentProfile(uc);
            }
            
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
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "place-order", method = RequestMethod.GET)
    public ModelAndView placeOrder(Map<String, Object> model, HttpServletRequest request) {
        
        return new ModelAndView("giftprocess2/place-order");
    }
}
