/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserMoneyLevel;
import vn.chonsoft.lixi.model.UserSecretCode;
import vn.chonsoft.lixi.model.UserSession;
import vn.chonsoft.lixi.model.form.UserResetPasswordForm;
import vn.chonsoft.lixi.model.form.UserSignInForm;
import vn.chonsoft.lixi.model.form.UserSignUpForm;
import vn.chonsoft.lixi.model.form.UserSignUpWithOutEmailForm;
import vn.chonsoft.lixi.repositories.service.LixiConfigService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.MoneyLevelService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.repositories.service.UserMoneyLevelService;
import vn.chonsoft.lixi.repositories.service.UserSecretCodeService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.UserSessionService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("user")
public class UserGeneralController {

    private static final Logger log = LogManager.getLogger(UserGeneralController.class);

    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private VelocityEngine velocityEngine;

    @Autowired
    private UserService userService;

    @Autowired
    private UserSessionService userSessionService;
    
    @Autowired
    private UserSecretCodeService uscService;

    @Autowired
    private MoneyLevelService mlService;

    @Autowired
    private UserMoneyLevelService umlService;

    @Autowired
    private LixiOrderService lxorderService;

    @Autowired
    private LixiOrderGiftService lxogiftService;

    @Autowired
    private TopUpMobilePhoneService topUpService;
    
    @Autowired
    private LixiExchangeRateService lxexrateService;

    @Autowired
    private LixiConfigService configService;

    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "signUp", method = RequestMethod.GET)
    public String signUp(Map<String, Object> model) {

        UserSignUpForm signUp = new UserSignUpForm();
        signUp.setAgree("yes");

        model.put("userSignUpForm", signUp);
        //model.put("userSignUpForm", new UserSignUpForm());

        model.put("userSignInForm", new UserSignInForm());

        // forward action
        model.put("action", "join");

        return "user2/register";
    }

    /**
     * User submit form
     *
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return
     */
    @RequestMapping(value = "signUp", method = RequestMethod.POST)
    public ModelAndView signUp(Map<String, Object> model,
            @Valid UserSignUpForm form, Errors errors, HttpServletRequest request) {
        
        // put sign in form
        model.put("userSignInForm", new UserSignInForm());

        if (errors.hasErrors()) {
            return new ModelAndView("user2/register");
        }

        User u = new User();
        u.setFirstName(StringUtils.defaultIfBlank(LiXiGlobalUtils.html2text(form.getFirstName()), null));
        u.setMiddleName(StringUtils.defaultIfBlank(LiXiGlobalUtils.html2text(form.getMiddleName()), null));
        u.setLastName(StringUtils.defaultIfBlank(LiXiGlobalUtils.html2text(form.getLastName()), null));
        u.setEmail(form.getEmail());
        u.setPassword(BCrypt.hashpw(form.getPassword(), BCrypt.gensalt()));
        u.setDialCode(form.getDialCode());
        u.setPhone(form.getPhone());
        u.setAccountNonExpired(true);
        u.setAccountNonLocked(true);
        u.setCredentialsNonExpired(true);
        u.setEnabled(true);// enable
        u.setActivated(false);// but not active

        // created date and by
        Date currentDate = Calendar.getInstance().getTime();
        u.setCreatedDate(currentDate);
        u.setCreatedBy(u.getEmail());

        // generate active_code
        String activeCode = UUID.randomUUID().toString();

        try {

            // check if email already in use
            User temp = this.userService.findByEmail(u.getEmail(), Boolean.TRUE);

            // Email address already in use
            if (temp != null) {

                model.put("inUseEmail", form.getEmail());
                //
                return new ModelAndView("user2/email-in-use");

            }
            if (temp == null) {

                // get id returned
                u = this.userService.save(u);

                // inser default money level
                UserMoneyLevel uml = new UserMoneyLevel();
                uml.setUser(u);
                uml.setMoneyLevel(this.mlService.findByIsDefault());
                uml.setModifiedDate(currentDate);
                uml.setModifiedBy(LiXiConstants.SYSTEM_AUTO);

                this.umlService.save(uml);

                // inser activate code
                UserSecretCode usc = new UserSecretCode();
                usc.setUserId(u);
                usc.setCode(activeCode);
                usc.setCreatedDate(currentDate);
                // activate code is expired after one day
                usc.setExpiredDate(DateUtils.addDays(currentDate, 1));

                this.uscService.save(usc);
            }
        } catch (ConstraintViolationException e) {

            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/register");

        }

        // SignUp process complete. Check oldEmail for verification
        MimeMessagePreparator preparator = new MimeMessagePreparator() {

            @SuppressWarnings({"rawtypes", "unchecked"})
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {

                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(form.getEmail());
                //message.setCc(LiXiGlobalConstants.CHONNH_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global - Confirm your registration");
                message.setSentDate(Calendar.getInstance().getTime());

                Map model = new HashMap();
                model.put("user", userService.findByEmail(form.getEmail()));
                // built the path
                String regisConfirmPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/registrationConfirm/" + activeCode).build().toUriString());
                model.put("regisConfirmPath", regisConfirmPath);

                String text = VelocityEngineUtils.mergeTemplateIntoString(
                        velocityEngine, "emails/registration-confirmation.vm", "UTF-8", model);
                message.setText(text, true);

            }

        };

        // send oldEmail
        taskScheduler.execute(() -> mailSender.send(preparator));

        model.put("email", form.getEmail());
        return new ModelAndView("user2/signUpComplete", model);
    }

    /**
     *
     * Registration confirmation
     *
     * @param code
     * @return
     */
    @RequestMapping(value = "registrationConfirm/{code}", method = RequestMethod.GET)
    public ModelAndView registrationConfirm(@PathVariable String code) {

        Map<String, Object> model = new HashMap<>();

        // get user activation code
        UserSecretCode usc = this.uscService.findByCode(code);

        // code is wrong
        if (usc == null) {

            model.put("codeWrong", 1);

            return new ModelAndView("user2/regisConfirm", model);
        } else {

            // check expired
            Date currentDate = Calendar.getInstance().getTime();
            if (usc.getExpiredDate().before(currentDate)) {

                // delete expired code
                this.uscService.delete(usc.getId());

                model.put("codeExpired", 1);

                return new ModelAndView("user2/regisConfirm", model);
            } else {

                // activate
                this.userService.updateActivated(Boolean.TRUE, usc.getUserId().getId());

                // delete activated code
                this.uscService.delete(usc.getId());

                // return
                model.put("activeResult", 1);
                return new ModelAndView("user2/regisConfirm", model);
            }
        }
    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "sendActiveCode", method = RequestMethod.POST)
    public ModelAndView sendActiveCode(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<>();

        String email = request.getParameter("email");

        try {

            User u = this.userService.findByEmail(email, Boolean.TRUE);

            // if user already activated
            if (u.getActivated()) {

                // return
                model.put("activeResult", 1);
                return new ModelAndView("user2/regisConfirm", model);
            } else {

                String activeCode = UUID.randomUUID().toString();
                Date currentDate = Calendar.getInstance().getTime();
                // inser activate code
                UserSecretCode usc = new UserSecretCode();
                usc.setUserId(u);
                usc.setCode(activeCode);
                usc.setCreatedDate(currentDate);
                // activate code is expired after one day
                usc.setExpiredDate(DateUtils.addDays(currentDate, 1));

                this.uscService.save(usc);

                // re-send active code
                MimeMessagePreparator preparator = new MimeMessagePreparator() {

                    @SuppressWarnings({"rawtypes", "unchecked"})
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {

                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                        message.setTo(u.getEmail());
                        //message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Resend activation code");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map model = new HashMap();
                        model.put("user", u);
                        // built the path
                        String regisConfirmPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/registrationConfirm/" + activeCode).build().toUriString());
                        model.put("regisConfirmPath", regisConfirmPath);

                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                                velocityEngine, "emails/resend-active-code.vm", "UTF-8", model);
                        message.setText(text, true);

                    }

                };

                // send oldEmail
                taskScheduler.execute(() -> mailSender.send(preparator));
                // return page
                model.put("email", u.getEmail());
                return new ModelAndView("user2/signUpComplete", model);
            }
        } catch (Exception e) {

            log.info(e.getMessage(), e);

            // There is something wrong
            model.put("codeWrong", 1);

            return new ModelAndView("user2/regisConfirm", model);
        }

    }

    /**
     *
     * User forgot password
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "passwordAssistance2", method = RequestMethod.GET)
    public String passwordAssistance(Map<String, Object> model) {

        return "user2/passwordAssistance";

    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "passwordAssistance2", method = RequestMethod.POST)
    public ModelAndView sendPasswordAssistance2(HttpServletRequest request) {

        // model
        Map<String, Object> model = new HashMap<>();

        String captcha = request.getParameter("captcha");
        // captcha is correct
        if (captcha != null && captcha.equalsIgnoreCase((String) request.getSession().getAttribute("captcha"))) {

            String email = request.getParameter("email");
            try {

                User u = this.userService.findByEmail(email, Boolean.TRUE);

                /* user is not null. Send oldEmail */
                // update new active code
                String activeCode = UUID.randomUUID().toString();
                Date currentDate = Calendar.getInstance().getTime();
                // inser activate code
                UserSecretCode usc = new UserSecretCode();
                usc.setUserId(u);
                usc.setCode(activeCode);
                usc.setCreatedDate(currentDate);
                // activate code is expired after one day
                usc.setExpiredDate(DateUtils.addDays(currentDate, 1));

                this.uscService.save(usc);

                // re-send active code
                MimeMessagePreparator preparator = new MimeMessagePreparator() {

                    @SuppressWarnings({"rawtypes", "unchecked"})
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {

                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                        message.setTo(u.getEmail());
                        //message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Reset Your Password");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map model = new HashMap();
                        model.put("user", u);
                        // built the path
                        String resetPasswordPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/resetPassword/" + activeCode).build().toUriString());
                        model.put("resetPasswordPath", resetPasswordPath);

                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                                velocityEngine, "emails/reset-password.vm", "UTF-8", model);
                        message.setText(text, true);

                    }

                };

                // send oldEmail
                taskScheduler.execute(() -> mailSender.send(preparator));
                // complete
                model.put("email", email);

                return new ModelAndView("user2/passwordAssistanceComplete", model);

            } catch (Exception e) {

                log.info(e.getMessage(), e);

            }
        }

        // show error message
        model.put("passwordAssistance", false);
        //
        return new ModelAndView("user2/passwordAssistance", model);

    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "passwordAssistance", method = RequestMethod.POST)
    public ModelAndView sendPasswordAssistance(HttpServletRequest request) {

        // model
        Map<String, Object> model = new HashMap<>();

        String email = request.getParameter("email");
        try {

            User u = this.userService.findByEmail(email, Boolean.TRUE);

            /* user is not null. Send oldEmail */
            // update new active code
            String activeCode = UUID.randomUUID().toString();
            Date currentDate = Calendar.getInstance().getTime();
            // inser activate code
            UserSecretCode usc = new UserSecretCode();
            usc.setUserId(u);
            usc.setCode(activeCode);
            usc.setCreatedDate(currentDate);
            // activate code is expired after one day
            usc.setExpiredDate(DateUtils.addDays(currentDate, 1));

            this.uscService.save(usc);

            // re-send active code
            MimeMessagePreparator preparator = new MimeMessagePreparator() {

                @SuppressWarnings({"rawtypes", "unchecked"})
                @Override
                public void prepare(MimeMessage mimeMessage) throws Exception {

                    MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                    message.setTo(u.getEmail());
                    //message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                    message.setFrom("support@lixi.global");
                    message.setSubject("LiXi.Global - Reset Your Password");
                    message.setSentDate(Calendar.getInstance().getTime());

                    Map model = new HashMap();
                    model.put("user", u);
                    // built the path
                    String resetPasswordPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/resetPassword/" + activeCode).build().toUriString());
                    model.put("resetPasswordPath", resetPasswordPath);

                    String text = VelocityEngineUtils.mergeTemplateIntoString(
                            velocityEngine, "emails/reset-password.vm", "UTF-8", model);
                    message.setText(text, true);

                }

            };

            // send oldEmail
            taskScheduler.execute(() -> mailSender.send(preparator));
            
            // complete
            model.put("error", 0);

        } catch (Exception e) {

            log.info(e.getMessage(), e);

            // show error message
           model.put("error", 1);
       
        }

        //
        return new ModelAndView("user2/passwordAssistanceMessage", model);
    }

    /**
     *
     * @param code
     * @return
     */
    @RequestMapping(value = "resetPassword/{code}", method = RequestMethod.GET)
    public ModelAndView resetPassword(@PathVariable String code) {

        Map<String, Object> model = new HashMap<>();
        Date currentDate = Calendar.getInstance().getTime();
        // get reset-password code
        UserSecretCode usc = this.uscService.findByCode(code);
        if (usc == null || usc.getExpiredDate().before(currentDate)) {

            // show error message
            model.put("passwordAssistance", 1);

            //return new ModelAndView("user2/passwordAssistance");
            return new ModelAndView(new RedirectView("/", true, true));

        } else {

            UserResetPasswordForm form = new UserResetPasswordForm();
            form.setCode(code);

            model.put("userResetPasswordForm", form);

            return new ModelAndView("user2/resetPassword", model);
        }
    }

    /**
     *
     * @param model
     * @param form
     * @param errors
     * @return
     */
    @RequestMapping(value = "resetPassword/{code}", method = RequestMethod.POST)
    public ModelAndView resetPassword(Map<String, Object> model,
            @Valid UserResetPasswordForm form, Errors errors) {

        if (errors.hasErrors()) {
            return new ModelAndView("user2/resetPassword");
        }

        try {

            // check expired
            Date currentDate = Calendar.getInstance().getTime();
            // get reset-password code
            UserSecretCode usc = this.uscService.findByCode(form.getCode());
            if (usc == null || usc.getExpiredDate().before(currentDate)) {

                // show error message
                model.put("passwordAssistance", 1);

                return new ModelAndView("user2/passwordAssistance");

            } else {
                // update password
                this.userService.updatePassword(BCrypt.hashpw(form.getPassword(), BCrypt.gensalt()), usc.getUserId().getId());

                // delete re-set code
                this.uscService.delete(usc.getId());
            }

        } catch (ConstraintViolationException e) {

            // log
            log.info(e.getMessage(), e);

            //
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/resetPassword");

        }

        return new ModelAndView("user2/resetPasswordComplete");

    }

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "signIn", method = RequestMethod.GET)
    public String signIn(Map<String, Object> model) {

        UserSignUpForm signUp = new UserSignUpForm();
        signUp.setAgree("yes");

        model.put("userSignUpForm", signUp);

        model.put("userSignInForm", new UserSignInForm());

        // forward action
        model.put("action", "login");

        return "user2/register";
    }

    /**
     * 
     * count num of sign in failed for showing security code image
     * 
     * @param session 
     */
    private void countSigninFailed(HttpSession session){
        
        Integer numOfSiginFailed = (Integer)session.getAttribute("numOfSiginFailed");
        
        if(numOfSiginFailed == null){
            session.setAttribute("numOfSiginFailed", 1);
        }
        else{
            // increase sign in failed counter
            session.setAttribute("numOfSiginFailed", numOfSiginFailed + 1);
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
    @RequestMapping(value = "signIn", method = RequestMethod.POST)
    public ModelAndView signIn(Map<String, Object> model,
            @Valid UserSignInForm form, Errors errors, HttpServletRequest request) {
        
        // prepare for signUp form 
        model.put("action", "login");
        model.put("userSignUpForm", new UserSignUpForm());

        // get session, check security code
        HttpSession session = request.getSession();
        Integer numOfSiginFailed = (Integer)session.getAttribute("numOfSiginFailed");
        // sign in failed 4 times
        if((numOfSiginFailed != null) && numOfSiginFailed >= 4){
            String secCode = request.getParameter("secCode");
            if(StringUtils.isBlank(secCode) || !secCode.equalsIgnoreCase((String)session.getAttribute("captcha"))){
                model.put("signInFailed", 5);
                return new ModelAndView("user2/register");
            }
        }
        
        /* */
        if (errors.hasErrors()) {
            return new ModelAndView("user2/register");
        }

        try {
            // 
            User u = this.userService.findByEmail(form.getEmail());

            // email is not exist
            if (u == null) {
                
                // count
                countSigninFailed(session);
                
                model.put("signInFailed", 1);
                return new ModelAndView("user2/register");

            }

            // check activation
            if (!u.getActivated()) {
                
                // count
                countSigninFailed(session);

                model.put("notActivated", 1);
                return new ModelAndView("user2/register");

            }

            // check enabled
            if (!u.getEnabled()) {
                
                // count
                countSigninFailed(session);
                
                model.put("notEnabled", 1);
                return new ModelAndView("user2/register");

            }

            // check password
            if (BCrypt.checkpw(form.getPassword(), u.getPassword())) {

                
                session.setAttribute(LiXiConstants.USER_LOGIN_EMAIL, u.getEmail());
                session.setAttribute(LiXiConstants.USER_LOGIN_FIRST_NAME, u.getFirstName());

                // change session id
                request.changeSessionId();
                
                /* save to user session table */
                //UserSession userSess = this.userSessionService.findByEmail(u.getEmail());
                //if(userSess == null){
                //    userSess = new UserSession();
                //}
                //userSess.setEmail(u.getEmail());
                //userSess.setLoginDate(Calendar.getInstance().getTime());
                //userSess.setCreatedBeanDate(loginedUser.getCreatedDateBean());
                //SimpleDateFormat sdfr = new SimpleDateFormat("MMM/dd/yyyy KK:mm:ss a");
                //log.info("setLoginDate: " + sdfr.format(userSess.getLoginDate()) + " - setCreatedBeanDate: " + sdfr.format(loginedUser.getCreatedDateBean()));
                //this.userSessionService.save(userSess);
                
                //
                LiXiUtils.setLoginedUser(loginedUser, u, this.configService.findAll());

                // check the order that unfinished
                LixiOrder order = this.lxorderService.findLastBySenderAndLixiStatus(u, EnumLixiOrderStatus.UN_FINISHED.getValue());
                if (order != null) {
                    
                    log.info("User " + u.getEmail() + " has order " + order.getId() + " UN_FINISHED");

                    /* get latest exchange rate */
                    LixiExchangeRate exRate = this.lxexrateService.findLastRecord(LiXiConstants.USD);
                    order.setLxExchangeRate(exRate);
                    
                    this.lxorderService.save(order);
                    
                    /* update gifts*/
                    if(order.getGifts() != null){
                        
                        for(LixiOrderGift gift : order.getGifts()){
                            
                            gift.setUsdPrice(LiXiUtils.toUsdPrice(gift.getProductPrice(), exRate.getBuy()));
                            
                            this.lxogiftService.save(gift);
                        }
                    }
                    
                    /* update top up */
                    if(order.getTopUpMobilePhones()!=null){
                        for(TopUpMobilePhone t : order.getTopUpMobilePhones()){
                            
                            t.setAmountUsd(LiXiUtils.toUsdPrice(t.getAmount(), exRate.getBuy()));
                            this.topUpService.save(t);
                        }
                    }
                    // continue to finish this order
                    request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
                }
                else{
                    log.info("User " + u.getEmail() + " has no UN_FINISHED order");
                }
            } else {
                // wrong password
                countSigninFailed(session);
                
                model.put("signInFailed", 1);
                return new ModelAndView("user2/register");

            }
        } catch (ConstraintViolationException e) {

            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/register");

        }

        // goto next page
        RedirectView r = new RedirectView(LiXiUtils.getPathOfNextUrl(request.getParameter("nextUrl")), true, true);
        r.setExposeModelAttributes(false);
        return new ModelAndView(r);        
    }

    /**
     *
     * @param session
     * @return
     */
    @RequestMapping(value = "signOut", method = RequestMethod.GET)
    public ModelAndView signOut(HttpSession session) {

        /* delete user session */
        //this.userSessionService.deleteByEmail(loginedUser.getEmail());
        
        session.invalidate();
        //
        return new ModelAndView(new RedirectView("/", true, true));
    }

    /**
     *
     * verify the email
     *
     * @param inUseEmail
     * @param request
     * @return
     */
    @RequestMapping(value = "verifyThisEmail", method = RequestMethod.POST)
    public ModelAndView verifyThisEmail(@RequestParam String inUseEmail, HttpServletRequest request) {

        //MapUtils.debugPrint(System.out, "model", model);
        // put into session
        request.getSession().setAttribute(LiXiConstants.LIXI_IN_USE_EMAIL, inUseEmail);

        //
        Map<String, Object> model = new HashMap<>();
        model.put("inUseEmail", inUseEmail);
        //
        return new ModelAndView("user2/verify-email", model);
    }

    /**
     *
     * Send verification email
     *
     * @param model
     * @param captcha
     * @param request
     * @return
     */
    @RequestMapping(value = "verify/sendEmail", method = RequestMethod.POST)
    public ModelAndView verifyThisEmail(Map<String, Object> model, @RequestParam String captcha, HttpServletRequest request) {

        String inUseEmail = (String) request.getSession().getAttribute(LiXiConstants.LIXI_IN_USE_EMAIL);

        if (captcha != null && captcha.equalsIgnoreCase((String) request.getSession().getAttribute("captcha"))) {

            // captcha is correct
            User u = this.userService.findByEmail(inUseEmail, Boolean.TRUE);

            /* store secret code into database */
            String activeCode = UUID.randomUUID().toString();
            Date currentDate = Calendar.getInstance().getTime();
            // inser activate code
            UserSecretCode usc = new UserSecretCode();
            usc.setUserId(u);
            usc.setCode(activeCode);
            usc.setDescription("Create new account with the in use email");
            usc.setCreatedDate(currentDate);
            // activate code is expired after one day
            usc.setExpiredDate(DateUtils.addDays(currentDate, 1));

            this.uscService.save(usc);

            //
            MimeMessagePreparator preparator = new MimeMessagePreparator() {

                @SuppressWarnings({"rawtypes", "unchecked"})
                @Override
                public void prepare(MimeMessage mimeMessage) throws Exception {

                    MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                    message.setTo(u.getEmail());
                    //message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                    //message.addCc(LiXiGlobalConstants.CHONNH_GMAIL);
                    message.setFrom("support@lixi.global");
                    message.setSubject("LiXi.Global - Verify your email");
                    message.setSentDate(Calendar.getInstance().getTime());

                    Map model = new HashMap();
                    model.put("user", u);
                    // built the path
                    String resetPasswordPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/verifyEmail/" + activeCode).build().toUriString());
                    model.put("newAccountPath", resetPasswordPath);

                    String text = VelocityEngineUtils.mergeTemplateIntoString(
                            velocityEngine, "emails/newaccount-oldemail.vm", "UTF-8", model);
                    message.setText(text, true);

                }

            };

            // send oldEmail
            taskScheduler.execute(() -> mailSender.send(preparator));

        } else {

            return new ModelAndView("user2/verify-email", model);
        }
        // remove LIXI_IN_USE_EMAIL in session
        request.getSession().removeAttribute(LiXiConstants.LIXI_IN_USE_EMAIL);

        //
        model.put("inUseEmail", inUseEmail);
        return new ModelAndView("user2/alert-verify-email", model);
    }

    /**
     *
     *
     * @param model
     * @param code
     * @param request
     *
     * @return
     */
    @RequestMapping(value = "verifyEmail/{code}", method = RequestMethod.GET)
    public ModelAndView verifyTheCode(Map<String, Object> model, @PathVariable String code, HttpServletRequest request) {

        Date currentDate = Calendar.getInstance().getTime();
        UserSecretCode usc = this.uscService.findByCode(code);
        if (usc == null || usc.getExpiredDate().before(currentDate)) {

            // show error message
            model.put("wrongSecretCode", 1);

            return new ModelAndView("user2/verify-email-failed");

        } else {

            // disable the current user
            this.userService.updateEnaled(Boolean.FALSE, usc.getUserId().getId());

            // store email
            request.getSession().setAttribute(LiXiConstants.LIXI_IN_USE_EMAIL, usc.getUserId().getEmail());

            // store secret code into session and delete after user created account
            request.getSession().setAttribute(LiXiConstants.LIXI_IN_USE_EMAIL_SECRET_CODE, code);

            return new ModelAndView(new RedirectView("/user/signUpWithExistingEmail", true, true));
        }
    }

    /**
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "signUpWithExistingEmail", method = RequestMethod.GET)
    public ModelAndView signUpWithExistingEmail(Map<String, Object> model, HttpServletRequest request) {

        // get email from session
        String inUseEmail = (String) request.getSession().getAttribute(LiXiConstants.LIXI_IN_USE_EMAIL);

        UserSignUpWithOutEmailForm form = new UserSignUpWithOutEmailForm();

        form.setEmail(inUseEmail);
        form.setConfEmail(inUseEmail);

        model.put("userSignUpWithOutEmailForm", form);

        return new ModelAndView("user2/signUpWithOutEmail");
    }

    /**
     *
     *
     *
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return
     */
    @RequestMapping(value = "signUpWithExistingEmail", method = RequestMethod.POST)
    public ModelAndView signUpWithExistingEmail(Map<String, Object> model,
            @Valid UserSignUpWithOutEmailForm form, Errors errors, HttpServletRequest request) {

        if (errors.hasErrors()) {
            return new ModelAndView("user2/signUpWithOutEmail");
        }

        // get email from session
        String inUseEmail = (String) request.getSession().getAttribute(LiXiConstants.LIXI_IN_USE_EMAIL);

        User u = new User();
        u.setFirstName(form.getFirstName());
        u.setMiddleName(form.getMiddleName());
        u.setLastName(form.getLastName());
        u.setEmail(inUseEmail);
        u.setPassword(BCrypt.hashpw(form.getPassword(), BCrypt.gensalt()));
        u.setPhone(form.getPhone());
        u.setAccountNonExpired(true);
        u.setAccountNonLocked(true);
        u.setCredentialsNonExpired(true);
        u.setEnabled(true);// enable
        u.setActivated(true);// active

        // created date and by
        Date currentDate = Calendar.getInstance().getTime();
        u.setCreatedDate(currentDate);
        u.setCreatedBy(u.getEmail());

        try {

            u = this.userService.save(u);

            // inser default money level
            UserMoneyLevel uml = new UserMoneyLevel();
            uml.setUser(u);
            uml.setMoneyLevel(this.mlService.findByIsDefault());
            uml.setModifiedDate(currentDate);
            uml.setModifiedBy(LiXiConstants.SYSTEM_AUTO);

            this.umlService.save(uml);

        } catch (ConstraintViolationException e) {

            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user2/signUpWithOutEmail");

        }

        // delete secret code
        this.uscService.deleteByCode((String) request.getSession().getAttribute(LiXiConstants.LIXI_IN_USE_EMAIL_SECRET_CODE));

        // remove session
        request.getSession().removeAttribute(LiXiConstants.LIXI_IN_USE_EMAIL);
        request.getSession().removeAttribute(LiXiConstants.LIXI_IN_USE_EMAIL_SECRET_CODE);

        //
        return new ModelAndView("user2/signUpWithOutEmailComplete", model);
    }

}
