/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.text.SimpleDateFormat;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.form.AddCardForm;
import vn.chonsoft.lixi.model.form.UserEditEmailForm;
import vn.chonsoft.lixi.model.form.UserEditNameForm;
import vn.chonsoft.lixi.model.form.UserEditPasswordForm;
import vn.chonsoft.lixi.EnumTransactionResponseCode;
import vn.chonsoft.lixi.EnumTransactionStatus;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.CountryService;
import vn.chonsoft.lixi.repositories.service.LixiGlobalFeeService;
import vn.chonsoft.lixi.repositories.service.LixiInvoiceService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.PaymentService;
import vn.chonsoft.lixi.repositories.service.UserBankAccountService;
import vn.chonsoft.lixi.repositories.service.UserCardService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("user")
public class UserManagementController {
    
    private static final Logger log = LogManager.getLogger(UserManagementController.class);
    
    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private VelocityEngine velocityEngine;
    
    @Inject
    private UserService userService;
    
    @Inject
    private ThreadPoolTaskScheduler taskScheduler;
    
    @Autowired
    private LixiOrderService orderService;;
    
    @Autowired
    private CountryService countryService;
    
    @Autowired
    private LixiGlobalFeeService feeService;
    
    @Autowired
    private UserCardService cardService;
    
    @Autowired
    private UserBankAccountService bankService;
    
    @Autowired
    private BillingAddressService baService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private LixiInvoiceService invoiceService;
    
    @Autowired
    private LixiAsyncMethods lxAsyncMethods;

    /**
     * 
     * @param model
     * @param request 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "yourAccount", method = RequestMethod.GET)
    public ModelAndView yourAccount(Map<String, Object> model, HttpServletRequest request) {

        model.put("user", this.userService.findByEmail(loginedUser.getEmail()));
        
        return new ModelAndView("user2/yourAccount", model);
    }
    
    /**
     * 
     * user edit his name
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editName", method = RequestMethod.GET)
    public ModelAndView editName(Map<String, Object> model, HttpServletRequest request) {
        
        //String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        // Already login
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        UserEditNameForm form = new UserEditNameForm();
        
        form.setFirstName(u.getFirstName());
        form.setMiddleName(u.getMiddleName());
        form.setLastName(u.getLastName());
        
        model.put("userEditNameForm", form);
        return new ModelAndView("user2/editName", model);
    }
 
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editName", method = RequestMethod.POST)
    public ModelAndView editName(Map<String, Object> model,
            @Valid UserEditNameForm form, Errors errors, HttpServletRequest request) {
        
        if (errors.hasErrors()) {
            return new ModelAndView("user2/editName");
        }
        
        try {
            // user oldEmail
            String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            
            // exceptions will be thrown if there is no account
            User u = this.userService.findByEmail(email);
            
            u.setFirstName(StringUtils.defaultIfBlank(LiXiGlobalUtils.html2text(form.getFirstName()), null));
            u.setMiddleName(StringUtils.defaultIfBlank(LiXiGlobalUtils.html2text(form.getMiddleName()), null));
            u.setLastName(StringUtils.defaultIfBlank(LiXiGlobalUtils.html2text(form.getLastName()), null));
            
            // save
            this.userService.save(u);
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/editName");
            
        }
        
        model.put("editSuccess", 1);
        return new ModelAndView(new RedirectView("/user/yourAccount", true, true), model);
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editPassword", method = RequestMethod.GET)
    public ModelAndView editPassword(Map<String, Object> model, HttpServletRequest request) {
        
        model.put("userEditPasswordForm", new UserEditPasswordForm());
        return new ModelAndView("user2/editPassword", model);
        
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editPassword", method = RequestMethod.POST)
    public ModelAndView editPassword(Map<String, Object> model,
            @Valid UserEditPasswordForm form, Errors errors, HttpServletRequest request) {
        
        if (errors.hasErrors()) {
            return new ModelAndView("user2/editPassword");
        }
        
        try {
            // user oldEmail
            String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            
            // exceptions will be thrown if there is no account
            User u = this.userService.findByEmail(email);
            
            // check password
            if(BCrypt.checkpw(form.getCurrentPassword(), u.getPassword())){
                
                // currentPassword is OK
                // update password
                this.userService.updatePassword(BCrypt.hashpw(form.getPassword(), BCrypt.gensalt()), u.getId());
                
                // send Email
                MimeMessagePreparator preparator = new MimeMessagePreparator() {

                    @SuppressWarnings({ "rawtypes", "unchecked" })
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {

                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                        message.setTo(u.getEmail());
                        //message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                        //message.addCc(LiXiGlobalConstants.CHONNH_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Your password has been changed");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map model = new HashMap();	             
                        model.put("user", u);
                        model.put("time", (new SimpleDateFormat("MM/dd/yyy HH:mm")).format(Calendar.getInstance().getTime()));
                        // built the path
                        String lixiGlobalLink = "https://www.lixi.global/user/signIn";//
                        try {
                            // this throws nullexception sometime, don't know why
                            lixiGlobalLink =LiXiUtils.remove8080(ServletUriComponentsBuilder.fromRequest(request).path("/user/signIn").build().toUriString());
                        } catch (Exception e) {}
                        model.put("lixiGlobalLink", lixiGlobalLink);
                        
                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                           velocityEngine, "emails/change-password.vm", "UTF-8", model);
                        message.setText(text, true);
                      }
                };        

                // send oldEmail
                taskScheduler.execute(() -> mailSender.send(preparator));
                    
                // return your account page
                model.put("editSuccess", 1);
                return new ModelAndView(new RedirectView("/user/yourAccount", true, true), model);
                
            }
            else{
                //
                log.info("wrong password");
                // wrong password
                model.put("editSuccess", 0);
                return new ModelAndView("user2/editPassword", model);
            }
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/editPassword");
        }
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editEmail", method = RequestMethod.GET)
    public ModelAndView editEmail(Map<String, Object> model, HttpServletRequest request) {

        model.put("userEditEmailForm", new UserEditEmailForm());
        return new ModelAndView("user2/editEmail", model);
        
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editEmail", method = RequestMethod.POST)
    public ModelAndView editEmail(Map<String, Object> model,
            @Valid UserEditEmailForm form, Errors errors, HttpServletRequest request) {
        
        if (errors.hasErrors()) {
            return new ModelAndView("user2/editEmail");
        }
        
        try {
            
            // user oldEmail
            String oldEmail = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            
            // exceptions will be thrown if there is no account
            User u = this.userService.findByEmail(oldEmail);
            
            // check if new oldEmail
            if(oldEmail != null && oldEmail.equals(form.getEmail())){
                
                model.put("reUseEmail", 1);
                return new ModelAndView("user2/editEmail", model);
                
            }
            // check password
            if(BCrypt.checkpw(form.getPassword(), u.getPassword())){
                
                User temp = this.userService.findByEmail(form.getEmail());
                if(temp == null){
                    
                    // update oldEmail
                    this.userService.updateEmail(form.getEmail(), u.getId());
                    
                    // update user
                    u.setEmail(form.getEmail());
                    
                    //update session
                    request.getSession().setAttribute(LiXiConstants.USER_LOGIN_EMAIL, form.getEmail());
                    loginedUser.setEmail(form.getEmail());
                    
                    // send Email
                    MimeMessagePreparator preparator = new MimeMessagePreparator() {

                        @SuppressWarnings({ "rawtypes", "unchecked" })
                        @Override
                        public void prepare(MimeMessage mimeMessage) throws Exception {

                            MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                            message.setTo(u.getEmail());
                            message.addTo(oldEmail);
                            //message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                            message.setFrom("support@lixi.global");
                            message.setSubject("Revision to Your LiXi.Global Account");
                            message.setSentDate(Calendar.getInstance().getTime());

                            Map model = new HashMap();	             
                            model.put("user", u);
                            model.put("oldEmailAddress", oldEmail);

                            String text = VelocityEngineUtils.mergeTemplateIntoString(
                               velocityEngine, "emails/user-edit-email.vm", "UTF-8", model);
                            message.setText(text, true);
                          }
                    };        

                    // send oldEmail
                    taskScheduler.execute(() -> mailSender.send(preparator));
                    
                    // return your account page
                    model.put("editSuccess", 1);
                    return new ModelAndView(new RedirectView("/user/yourAccount", true, true), model);
                }
                else{
                    // email already in use
                    model.put("reUseEmail", 1);
                    return new ModelAndView("user2/editEmail", model);
                }
            }
            // wrong password
            model.put("editSuccess", 0);
            return new ModelAndView("user2/editEmail", model);
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/editEmail");
        }
    }
    
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editPhoneNumber", method = RequestMethod.GET)
    public ModelAndView editPhoneNumber(Map<String, Object> model, HttpServletRequest request) {
        
        // get user
        User u = this.userService.findByEmail(loginedUser.getEmail());
        // get current phone number
        model.put("dialCode", u.getDialCode());
        model.put("phone", u.getPhone());
        return new ModelAndView("user2/editPhoneNumber", model);
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "editPhoneNumber", method = RequestMethod.POST)
    public ModelAndView editPhoneNumber(HttpServletRequest request) {
        
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        String dialCode = request.getParameter("dialCode");
        String phone = LiXiGlobalUtils.html2text(request.getParameter("phone"));
        
        // update
        u.setDialCode(dialCode);
        u.setPhone(phone);
        this.userService.save(u);
        
        // return your account page
        Map<String, Object> model = new HashMap<>();
        model.put("editSuccess", 1);
        return new ModelAndView(new RedirectView("/user/yourAccount", true, true), model);
        
    }
    
    /**
     * 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "orderHistory", method = RequestMethod.GET)
    public ModelAndView orderHistory(HttpServletRequest request) {
        
        return new ModelAndView(new RedirectView("/user/orderHistory/lastWeek", true, true));
    }
    
    /**
     * 
     * @param model
     * @param when
     * @param page
     * @param request 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "orderHistory/{when}", method = RequestMethod.GET)
    public ModelAndView orderHistory(Map<String, Object> model, @PathVariable String when, @PageableDefault(page=0, value = 50, sort = "id", direction = Sort.Direction.DESC) Pageable page, HttpServletRequest request) {
        
        /**/
        User sender = this.userService.findByEmail(loginedUser.getEmail());
        
        Calendar calendar = Calendar.getInstance(); // this would default to now
        Date end = calendar.getTime();
        Date begin = null;
        
        switch(when){
            case "last30Days":
            {
                calendar.add(Calendar.DAY_OF_MONTH, -30);
                begin = calendar.getTime();
                break;
            }
            case "last6Months":
            {
                calendar.add(Calendar.MONTH, -6);
                begin = calendar.getTime();
                break;
            }
            case "allOrders":
            {
                begin = null;
                break;
            }
            default:{
                // last week
                calendar.add(Calendar.DAY_OF_MONTH, -7);
                begin = calendar.getTime();
            }
        }
        
        log.info("order history: begin " + begin + " : " + end);
        
        Page<LixiOrder> ps = null;
        if(begin != null){
            
            ps = this.orderService.findByModifiedDate(sender, begin, end, page);
            
        }
        else{
            
            /* all orders */
            ps = this.orderService.findBySender(sender, page);
        }
        
        log.info("page sort: " + page.getSort().toString());
        
        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        if(ps.hasContent()){
            ps.getContent().forEach(o -> {
                if(!EnumLixiOrderStatus.UN_FINISHED.getValue().equals(o.getLixiStatus())){
                    mOs.put(o, LiXiUtils.genMapRecGifts(o));
                }
            });
        }
        /* forward time */
        model.put("when", when);
        
        model.put("orders", ps);
        
        model.put("mOs", mOs);
        
        return new ModelAndView("user2/orderHistory");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param request 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "orderDetail/{id}", method = RequestMethod.GET)
    public ModelAndView orderHistory(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {
        
        /* */
        User sender = this.userService.findByEmail(loginedUser.getEmail());
        
        /* load the order */
        LixiOrder order = this.orderService.findById(id);
        
        /* check the owner */
        if(order == null || (!order.getSender().equals(sender))){
            
            // sign out
            return new ModelAndView(new RedirectView("/user/signOut", true, true));
        }
        
        /* do business */
        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
        
        model.put(LiXiConstants.LIXI_ORDER, order);
        
        // calculate fee
        LiXiUtils.calculateFee(model, order, feeService.findByCountry(
                countryService.findByCode(LiXiUtils.getBillingAddress(order).getCountry())));
        
        /* return */
        return new ModelAndView("user2/orderDetail");
    }
    
    /**
     * 
     * @param model
     * @param 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "payments", method = RequestMethod.GET)
    public ModelAndView payments(Map<String, Object> model, HttpServletRequest request) {
        
        User u = this.userService.findByEmail(loginedUser.getEmail());
        List<UserCard> cards = this.cardService.findByUser(u);
        List<UserBankAccount> accounts = this.bankService.findByUser(u);
        
        model.put("cards", cards);
        model.put("banks", accounts);
        
        return new ModelAndView("user2/payment/list");
    }

    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "edit/card/{id}", method = RequestMethod.GET)
    public ModelAndView addCard(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {
        
        User u = this.userService.findByEmail(loginedUser.getEmail());
        UserCard card = this.cardService.findByIdAndUser(id, u);
        
        if(card == null){
            return new ModelAndView(new RedirectView("/user/payments?error=1", true, true));
        }

        paymentService.getPaymentProfile(card);
        
        /* */
        AddCardForm addCardForm = new AddCardForm(card);
        
        model.put("addCardForm", addCardForm);
        
        model.put("COUNTRIES", this.countryService.findAll());
        
        return new ModelAndView("user2/payment/add-a-card");
    }
    /**
     * 
     * @param model
     * @param request 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "addCard", method = RequestMethod.GET)
    public ModelAndView addCard(Map<String, Object> model, HttpServletRequest request) {
        
        /* card form */
        AddCardForm addCardForm = new AddCardForm();
        addCardForm.setCardType(1);
        addCardForm.setFirstName(loginedUser.getFirstName());
        addCardForm.setLastName(loginedUser.getLastName());
        
        model.put("addCardForm", addCardForm);
        
        model.put("COUNTRIES", this.countryService.findAll());
        
        return new ModelAndView("user2/payment/add-a-card");
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
            return new ModelAndView("user2/payment/add-a-card");
        }

        try {

            if (!LiXiUtils.checkMonthYearGreaterThanCurrent(form.getExpMonth(), form.getExpYear())) {

                model.put("expiration_failed", 1);

                return new ModelAndView("user2/payment/add-a-card");
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
                //String secretCardNumber= "XXXX"+StringUtils.right(form.getCardNumber(), 4);
                String secretCardNumber= StringUtils.leftPad(StringUtils.right(form.getCardNumber(), 4), form.getCardNumber().length(), "X");
                uc.setCardNumber(secretCardNumber);
                //uc.setCardCvv("000");// comment on 2016/08/02, Mr Yuric asked
                
                this.cardService.save(uc);
                
                return new ModelAndView(new RedirectView("/user/payments?add=1", true, true));
            }
            else{
                model.put("authorizeError", returned);

                return new ModelAndView("user2/payment/add-a-card");
            }
            
        } catch (ConstraintViolationException e) {

            log.info("Insert card failed", e);
            //
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/payment/add-a-card");

        }
        
        
    }

    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "delete/card/{id}", method = RequestMethod.GET)
    public ModelAndView deleteCard(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {
        
        UserCard card = this.cardService.findById(id);
        
        /* delete card on authorize.net */
        paymentService.deletePaymentProfile(card);
        
        /* delete on our database */
        this.cardService.delete(id);
        
        return new ModelAndView(new RedirectView("/user/payments", true, true));
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "cancelOrder/{id}", method = RequestMethod.GET)
    public ModelAndView cancelOrder(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request) {
        
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        LixiOrder order = this.orderService.findByIdAndSender(id, u);
        
        if(order != null){
            
            LixiInvoice invoice = order.getInvoice();
            
            //log.info("status before update: " + invoice.getNetTransStatus() + " - " + invoice.getTranslatedStatus());
            
            this.paymentService.updateInvoiceStatus(invoice);
            
            //log.info("status after update: " + invoice.getNetTransStatus() + " - " + invoice.getTranslatedStatus());
            
            if(LiXiGlobalConstants.TRANS_STATUS_IN_PROGRESS.equals(invoice.getTranslatedStatus())){
                
                String rs = this.paymentService.voidTransaction(invoice);
                if(EnumTransactionResponseCode.APPROVED.getValue().equals(rs)){
                    
                    /* update order status */
                    order.setLixiStatus(EnumLixiOrderStatus.CANCELED.getValue());
                    order.setLixiMessage("Cancelled by sender");
                    this.orderService.save(order);
                    
                    /* invoice status */
                    invoice.setNetTransStatus(EnumTransactionStatus.voidedByUser.getValue());
                    this.invoiceService.save(invoice);
                    
                    /* cancel order */
                    lxAsyncMethods.cancelOrdersOnBaoKimNoAsync(order);
                    
                    /* send email */
                // send Email
                MimeMessagePreparator preparator = new MimeMessagePreparator() {

                    @SuppressWarnings({ "rawtypes", "unchecked" })
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {

                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                        message.setTo(u.getEmail());
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Cancel Order");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map model = new HashMap();
                        model.put("user", u);
                        model.put("time", (new SimpleDateFormat("hh:mm a MM/dd/yyy")).format(Calendar.getInstance().getTime()));
                        model.put("orderId", invoice.getInvoiceCode());
                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                           velocityEngine, "emails/sender-cancel-order.vm", "UTF-8", model);
                        message.setText(text, true);
                      }
                };        

                // send oldEmail
                taskScheduler.execute(() -> mailSender.send(preparator));
                    
                    
                }

                return new ModelAndView(new RedirectView("/user/orderHistory/lastWeek?voidRs="+rs, true, true));
            }
            else{
                return new ModelAndView(new RedirectView("/user/orderHistory/lastWeek?voidRs=0", true, true));
            }
        }
        else{
            return new ModelAndView(new RedirectView("/user/orderHistory/lastWeek", true, true));
        }
    }
}
