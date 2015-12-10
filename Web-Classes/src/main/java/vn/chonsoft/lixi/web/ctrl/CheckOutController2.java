/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.LixiCardFeeService;
import vn.chonsoft.lixi.repositories.service.LixiFeeService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserBankAccountService;
import vn.chonsoft.lixi.repositories.service.UserCardService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CreditCardProcesses;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("checkout")
public class CheckOutController2 {

    private static final Logger log = LogManager.getLogger(CheckOutController2.class);

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
        
        /* display view */
        return new ModelAndView("giftprocess2/select-payment-method");
        
    }
}
