/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserMoneyLevel;
import vn.chonsoft.lixi.model.UserSecretCode;
import vn.chonsoft.lixi.model.form.UserEditEmailForm;
import vn.chonsoft.lixi.model.form.UserEditNameForm;
import vn.chonsoft.lixi.model.form.UserEditPasswordForm;
import vn.chonsoft.lixi.model.form.UserResetPasswordForm;
import vn.chonsoft.lixi.model.form.UserSignInForm;
import vn.chonsoft.lixi.model.form.UserSignUpForm;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.MoneyLevelService;
import vn.chonsoft.lixi.repositories.service.UserMoneyLevelService;
import vn.chonsoft.lixi.repositories.service.UserSecretCodeService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("user")
public class UserController {
    
    private static final Logger log = LogManager.getLogger(UserController.class);
    
    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private VelocityEngine velocityEngine;
    
    @Inject
    private UserService userService;
    
    @Inject
    private UserSecretCodeService uscService;
    
    @Inject
    private MoneyLevelService mlService;
    
    @Inject
    private UserMoneyLevelService umlService;
    
    @Inject
    private LixiOrderService lxorderService;
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "signUp", method = RequestMethod.GET)
    public String signUp(Map<String, Object> model) {

        model.put("userSignUpForm", new UserSignUpForm());
        return "user/signUp";
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
        
        if (errors.hasErrors()) {
            return new ModelAndView("user/signUp");
        }
        
        User u = new User();
        u.setFirstName(form.getFirstName());
        u.setMiddleName(form.getMiddleName());
        u.setLastName(form.getLastName());
        u.setEmail(form.getEmail());
        u.setPassword(BCrypt.hashpw(form.getPassword(), BCrypt.gensalt()));
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
            // check unique oldEmail
            // exceptions will be thrown if the oldEmail is not unique
            User temp = this.userService.checkUniqueEmail(u.getEmail());
            if(temp == null){
                
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
            return new ModelAndView("user/signUp");
            
        }
        
        // SignUp process complete. Check oldEmail for verification
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
            
            @SuppressWarnings({ "rawtypes", "unchecked" })
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                
                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(form.getEmail());
                message.setCc(LiXiConstants.YHANNART_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global - Confirm your registration");
                message.setSentDate(Calendar.getInstance().getTime());
                
                Map model = new HashMap();	             
                model.put("user", userService.findByEmail(form.getEmail()));
                // built the path
                String regisConfirmPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/registrationConfirm/"+activeCode).build().toUriString());
                model.put("regisConfirmPath", regisConfirmPath);
                
                String text = VelocityEngineUtils.mergeTemplateIntoString(
                   velocityEngine, "emails/registration-confirmation.vm", "UTF-8", model);
                message.setText(text, true);
                
              }
            
           };        
        
        // send oldEmail
        ExecutorService executor = Executors.newSingleThreadExecutor();
        executor.execute(() -> mailSender.send(preparator));
        
        model.put("email", form.getEmail());
        return new ModelAndView("user/signUpComplete", model);
    }
    
    
    /**
     * 
     * Registration confirmation
     * 
     * @param code
     * @return 
     */
    @RequestMapping(value = "registrationConfirm/{code}", method = RequestMethod.GET)
    public ModelAndView registrationConfirm(@PathVariable String code){

        Map<String, Object> model = new HashMap<>();
        
        // get user activation code
        UserSecretCode usc = this.uscService.findByCode(code);
        
        // code is wrong
        if(usc == null){
            
            model.put("codeWrong", 1);
            
            return new ModelAndView("user/regisConfirm", model);
        }
        else{
            
            // check expired
            Date currentDate = Calendar.getInstance().getTime();
            if(usc.getExpiredDate().before(currentDate)){

                // delete expired code
                this.uscService.delete(usc.getId());
                
                model.put("codeExpired", 1);

                return new ModelAndView("user/regisConfirm", model);
            }
            else{
                
                // activate
                this.userService.updateActivated(Boolean.TRUE, usc.getUserId().getId());
                
                // delete activated code
                this.uscService.delete(usc.getId());
                
                // return
                model.put("activeResult", 1);
                return new ModelAndView("user/regisConfirm", model);
            }
        }
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "sendActiveCode", method = RequestMethod.POST)
    public ModelAndView sendActiveCode(HttpServletRequest request){
        
        Map<String, Object> model = new HashMap<>();
        
        String email = request.getParameter("email");
        
        try {
            
            User u = this.userService.findByEmail(email);
            
            // if user already activated
            if(u.getActivated()){
                
                // return
                model.put("activeResult", 1);
                return new ModelAndView("user/regisConfirm", model);
            }
            else{
            
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

                    @SuppressWarnings({ "rawtypes", "unchecked" })
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {

                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                        message.setTo(u.getEmail());
                        message.setCc(LiXiConstants.YHANNART_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Resend activation code");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map model = new HashMap();	             
                        model.put("user", u);
                        // built the path
                        String regisConfirmPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/registrationConfirm/"+activeCode).build().toUriString());
                        model.put("regisConfirmPath", regisConfirmPath);

                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                           velocityEngine, "emails/resend-active-code.vm", "UTF-8", model);
                        message.setText(text, true);

                      }

                   };        

                // send oldEmail
                ExecutorService executor = Executors.newSingleThreadExecutor();
                executor.execute(() -> mailSender.send(preparator));

                // return page
                model.put("email", u.getEmail());
                return new ModelAndView("user/signUpComplete", model);
            }
        } catch (Exception e) {
            
            log.info(e.getMessage(), e);
            
            // There is something wrong
            model.put("codeWrong", 1);
            
            return new ModelAndView("user/regisConfirm", model);
        }
        
    }
    
    /**
     * 
     * User forgot password
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "passwordAssistance", method = RequestMethod.GET)
    public String passwordAssistance(Map<String, Object> model){
        
        return "user/passwordAssistance";
        
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "passwordAssistance", method = RequestMethod.POST)
    public ModelAndView sendPasswordAssistance(HttpServletRequest request){
        
        // model
        Map<String, Object> model = new HashMap<>();
        
        String captcha = request.getParameter("captcha");
        // captcha is correct
        log.info(captcha + " - " + request.getSession().getAttribute("captcha"));
        if(captcha != null && captcha.equals((String)request.getSession().getAttribute("captcha"))){
           
            String email = request.getParameter("email");
            try {
                
                User u = this.userService.findByEmail(email);
                
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

                    @SuppressWarnings({ "rawtypes", "unchecked" })
                    @Override
                    public void prepare(MimeMessage mimeMessage) throws Exception {

                        MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                        message.setTo(u.getEmail());
                        message.setCc(LiXiConstants.YHANNART_GMAIL);
                        message.setFrom("support@lixi.global");
                        message.setSubject("LiXi.Global - Reset Your Password");
                        message.setSentDate(Calendar.getInstance().getTime());

                        Map model = new HashMap();	             
                        model.put("user", u);
                        // built the path
                        String resetPasswordPath = LiXiUtils.remove8080(ServletUriComponentsBuilder.fromContextPath(request).path("/user/resetPassword/"+activeCode).build().toUriString());
                        model.put("resetPasswordPath", resetPasswordPath);

                        String text = VelocityEngineUtils.mergeTemplateIntoString(
                           velocityEngine, "emails/reset-password.vm", "UTF-8", model);
                        message.setText(text, true);

                      }

                   };        

                // send oldEmail
                ExecutorService executor = Executors.newSingleThreadExecutor();
                executor.execute(() -> mailSender.send(preparator));
                
                // complete
                model.put("email", email);
                
                return new ModelAndView("user/passwordAssistanceComplete", model);
                
            } catch (Exception e) {
                
                log.info(e.getMessage(), e);
                
            }
        }
        
        // show error message
        model.put("passwordAssistance", false);
        //
        return new ModelAndView("user/passwordAssistance", model);
        
    }
    
    /**
     * 
     * @param code
     * @return 
     */
    @RequestMapping(value = "resetPassword/{code}", method = RequestMethod.GET)
    public ModelAndView resetPassword(@PathVariable String code){
        
        Map<String, Object> model = new HashMap<>();
        Date currentDate = Calendar.getInstance().getTime();
        // get reset-password code
        UserSecretCode usc = this.uscService.findByCode(code);
        if(usc == null || usc.getExpiredDate().before(currentDate)){

            // show error message
            model.put("passwordAssistance", 1);

            return new ModelAndView("user/passwordAssistance");

        }
        else{

            UserResetPasswordForm form = new UserResetPasswordForm();
            form.setCode(code);

            model.put("userResetPasswordForm", form);

            return new ModelAndView("user/resetPassword", model);
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
            return new ModelAndView("user/resetPassword");
        }
        
        try{
            
            // check expired
            Date currentDate = Calendar.getInstance().getTime();
            // get reset-password code
            UserSecretCode usc = this.uscService.findByCode(form.getCode());
            if(usc == null || usc.getExpiredDate().before(currentDate)){
                
                // show error message
                model.put("passwordAssistance", 1);
                
                return new ModelAndView("user/passwordAssistance");
                
            }
            else{
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
            return new ModelAndView("user/resetPassword");
            
        }
        
        return new ModelAndView("user/resetPasswordComplete");
        
    }
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "signIn", method = RequestMethod.GET)
    public String signIn(Map<String, Object> model) {

        model.put("userSignInForm", new UserSignInForm());
        return "user/signIn";
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
        
        if (errors.hasErrors()) {
            return new ModelAndView("user/signIn");
        }
        
        try {
            // 
            User u = this.userService.findByEmail(form.getEmail());
            
            // email is not exist
            if(u == null){
                
                model.put("signInFailed", 1);
                return new ModelAndView("user/signIn");
                
            }
            
            // check activation
            if(!u.getActivated()){
                
                model.put("notActivated", 1);
                return new ModelAndView("user/signIn");
                
            }
            
            // check enabled
            if(!u.getEnabled()){
                
                model.put("notEnabled", 1);
                return new ModelAndView("user/signIn");
                
            }
            
            // check password
            if(BCrypt.checkpw(form.getPassword(), u.getPassword())){
                
                HttpSession session = request.getSession();
                session.setAttribute(LiXiConstants.USER_LOGIN_EMAIL, u.getEmail());
                session.setAttribute(LiXiConstants.USER_LOGIN_FIRST_NAME, u.getFirstName());
                
                // change session id
                request.changeSessionId();
                
                // check the order that unfinished
                LixiOrder order = this.lxorderService.findLastBySenderAndLixiStatus(u, LiXiConstants.LIXI_ORDER_UNFINISHED);
                if(order != null){
                    // continue to finish this order
                    request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
                }
            }
            else{
                
                model.put("signInFailed", 1);
                return new ModelAndView("user/signIn");
                
            }
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user/signIn");
            
        }
        
        return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
    }
    
    @RequestMapping(value = "signOut", method = RequestMethod.GET)
    public ModelAndView signOut(HttpSession session) {

        session.invalidate();
        //
        return new ModelAndView(new RedirectView("/", true, true));
    }
    
    /**
     * 
     * @param model
     * @param request 
     * @return 
     */
    @RequestMapping(value = "yourAccount", method = RequestMethod.GET)
    public ModelAndView yourAccount(Map<String, Object> model, HttpServletRequest request) {

        // check login
        HttpSession session = request.getSession();
        if(session.getAttribute(LiXiConstants.USER_LOGIN_EMAIL) == null){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true));
            
        }

        return new ModelAndView("user/yourAccount", model);
    }
    
    /**
     * 
     * user edit his name
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "editName", method = RequestMethod.GET)
    public ModelAndView editName(Map<String, Object> model, HttpServletRequest request) {
        
        // check login
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        if(email == null){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        
        // Already login
        User u = this.userService.findByEmail(email);
        
        UserEditNameForm form = new UserEditNameForm();
        
        form.setFirstName(u.getFirstName());
        form.setMiddleName(u.getMiddleName());
        form.setLastName(u.getLastName());
        
        model.put("userEditNameForm", form);
        return new ModelAndView("user/editName", model);
    }
 
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "editName", method = RequestMethod.POST)
    public ModelAndView editName(Map<String, Object> model,
            @Valid UserEditNameForm form, Errors errors, HttpServletRequest request) {
        
        if (errors.hasErrors()) {
            return new ModelAndView("user/editName");
        }
        
        try {
            // user oldEmail
            String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            
            // exceptions will be thrown if there is no account
            User u = this.userService.findByEmail(email);
            
            u.setFirstName(form.getFirstName());
            u.setMiddleName(form.getMiddleName());
            u.setLastName(form.getLastName());
            
            // save
            this.userService.save(u);
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user/editName");
            
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
    @RequestMapping(value = "editPassword", method = RequestMethod.GET)
    public ModelAndView editPassword(Map<String, Object> model, HttpServletRequest request) {
        
        // check login
        HttpSession session = request.getSession();
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        if(email == null){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        
        //
        model.put("userEditPasswordForm", new UserEditPasswordForm());
        return new ModelAndView("user/editPassword", model);
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "editPassword", method = RequestMethod.POST)
    public ModelAndView editPassword(Map<String, Object> model,
            @Valid UserEditPasswordForm form, Errors errors, HttpServletRequest request) {
        
        if (errors.hasErrors()) {
            return new ModelAndView("user/editPassword");
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
                
                // return your account page
                model.put("editSuccess", 1);
                return new ModelAndView(new RedirectView("/user/yourAccount", true, true), model);
                
            }
            else{
                //
                log.info("wrong password");
                // wrong password
                model.put("editSuccess", 0);
                return new ModelAndView("user/editPassword", model);
            }
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user/editPassword");
        }
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "editEmail", method = RequestMethod.GET)
    public ModelAndView editEmail(Map<String, Object> model, HttpServletRequest request) {
        
        // check login
        HttpSession session = request.getSession();
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        if(email == null){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        
        //
        model.put("userEditEmailForm", new UserEditEmailForm());
        return new ModelAndView("user/editEmail", model);
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "editEmail", method = RequestMethod.POST)
    public ModelAndView editEmail(Map<String, Object> model,
            @Valid UserEditEmailForm form, Errors errors, HttpServletRequest request) {
        
        if (errors.hasErrors()) {
            return new ModelAndView("user/editEmail");
        }
        
        try {
            
            // user oldEmail
            String oldEmail = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            
            // exceptions will be thrown if there is no account
            User u = this.userService.findByEmail(oldEmail);
            
            // check if new oldEmail
            if(oldEmail != null && oldEmail.equals(form.getEmail())){
                
                model.put("reUseEmail", 1);
                return new ModelAndView("user/editEmail", model);
                
            }
            // check password
            if(BCrypt.checkpw(form.getPassword(), u.getPassword())){
                
                // currentPassword is OK
                // check unique oldEmail
                // exceptions will be thrown if the oldEmail is not unique
                User temp = this.userService.checkUniqueEmail(form.getEmail());
                if(temp == null){
                    
                    // update oldEmail
                    this.userService.updateEmail(form.getEmail(), u.getId());
                    
                    // update user
                    u.setEmail(form.getEmail());
                    
                    //update session
                    request.getSession().setAttribute(LiXiConstants.USER_LOGIN_EMAIL, form.getEmail());
                    
                    // send Email
                    MimeMessagePreparator preparator = new MimeMessagePreparator() {

                        @SuppressWarnings({ "rawtypes", "unchecked" })
                        @Override
                        public void prepare(MimeMessage mimeMessage) throws Exception {

                            MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                            message.setTo(u.getEmail());
                            message.setCc(LiXiConstants.YHANNART_GMAIL);
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
                    ExecutorService executor = Executors.newSingleThreadExecutor();
                    executor.execute(() -> mailSender.send(preparator));
                    
                    // return your account page
                    model.put("editSuccess", 1);
                    return new ModelAndView(new RedirectView("/user/yourAccount", true, true), model);
                }
                
            }
            // wrong password
            model.put("editSuccess", 0);
            return new ModelAndView("user/editEmail", model);
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user/editEmail");
        }
    }
    
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "editPhoneNumber", method = RequestMethod.GET)
    public ModelAndView editPhoneNumber(Map<String, Object> model, HttpServletRequest request) {
        
        // check login
        HttpSession session = request.getSession();
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        if(email == null){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        
        // get user
        User u = this.userService.findByEmail(email);
        // get current phone number
        model.put("phone", u.getPhone());
        return new ModelAndView("user/editPhoneNumber", model);
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "editPhoneNumber", method = RequestMethod.POST)
    public ModelAndView editPhoneNumber(HttpServletRequest request) {
        
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        String phone = request.getParameter("phone");
        
        // update
        this.userService.updatePhoneNumber(phone, u.getId());
        
        // return your account page
        Map<String, Object> model = new HashMap<>();
        model.put("editSuccess", 1);
        return new ModelAndView(new RedirectView("/user/yourAccount", true, true), model);
        
    }
}
