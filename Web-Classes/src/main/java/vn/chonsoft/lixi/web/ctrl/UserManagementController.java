/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.UserEditEmailForm;
import vn.chonsoft.lixi.model.form.UserEditNameForm;
import vn.chonsoft.lixi.model.form.UserEditPasswordForm;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CheckLoginedUserAspectJ;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("user")
public class UserManagementController {
    
    private static final Logger log = LogManager.getLogger(UserManagementController.class);
    
    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private VelocityEngine velocityEngine;
    
    @Inject
    private UserService userService;
    
    @Inject
    private ThreadPoolTaskScheduler taskScheduler;
    
    @Autowired
    private CheckLoginedUserAspectJ checkLoginedUser;
    
    /**
     * 
     * @param model
     * @param request 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "yourAccount", method = RequestMethod.GET)
    public ModelAndView yourAccount(Map<String, Object> model, HttpServletRequest request) {

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
    @UserSecurityAnnotation
    @RequestMapping(value = "editName", method = RequestMethod.GET)
    public ModelAndView editName(Map<String, Object> model, HttpServletRequest request) {
        
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
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
    @UserSecurityAnnotation
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
    @UserSecurityAnnotation
    @RequestMapping(value = "editPassword", method = RequestMethod.GET)
    public ModelAndView editPassword(Map<String, Object> model, HttpServletRequest request) {
        
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
    @UserSecurityAnnotation
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
    @UserSecurityAnnotation
    @RequestMapping(value = "editEmail", method = RequestMethod.GET)
    public ModelAndView editEmail(Map<String, Object> model, HttpServletRequest request) {

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
    @UserSecurityAnnotation
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
                    taskScheduler.execute(() -> mailSender.send(preparator));
                    
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
    @UserSecurityAnnotation
    @RequestMapping(value = "editPhoneNumber", method = RequestMethod.GET)
    public ModelAndView editPhoneNumber(Map<String, Object> model, HttpServletRequest request) {
        
        String email = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
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
    @UserSecurityAnnotation
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
