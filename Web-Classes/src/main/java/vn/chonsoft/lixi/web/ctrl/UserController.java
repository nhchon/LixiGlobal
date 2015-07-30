/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.UserSignInForm;
import vn.chonsoft.lixi.model.form.UserSignUpForm;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("user")
public class UserController {
    
    @Autowired
    JavaMailSender mailSender;
    
    @Autowired
    VelocityEngine velocityEngine;
    
    @Inject
    UserService userService;
    
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
        // set active_code
        u.setEnabled(false);
        String activeCode = UUID.randomUUID().toString();
        u.setActiveCode(activeCode);
        //
        u.setCreatedDate(Calendar.getInstance().getTime());
        u.setCreatedBy(u.getEmail());
        
        try {
            // check unique email
            // exceptions will be thrown if the email is not unique
            User temp = this.userService.checkUniqueEmail(u.getEmail());
            if(temp == null){
                this.userService.save(u);
            }
        } catch (ConstraintViolationException e) {
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user/signUp");
        }
        
        // SignUp process complete. Check email for verification
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
            
            @SuppressWarnings({ "rawtypes", "unchecked" })
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                
                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(form.getEmail());
                message.setBcc("yhannart@gmail.com");
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global - Confirm your registration");
                message.setSentDate(Calendar.getInstance().getTime());
                
                Map model = new HashMap();	             
                model.put("user", u);
                // built the path
                String regisConfirmPath = ServletUriComponentsBuilder.fromContextPath(request).path("/user/registrationConfirm?code="+activeCode).build().toUriString();
                model.put("regisConfirmPath", regisConfirmPath);
                
                String text = VelocityEngineUtils.mergeTemplateIntoString(
                   velocityEngine, "emails/registration-confirmation.vm", "UTF-8", model);
                message.setText(text, true);
                
              }
            
           };        
        
        // send email
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
    @RequestMapping(value = "registrationConfirm", method = RequestMethod.GET)
    public ModelAndView registrationConfirm(@RequestParam String code){
        
        Map<String, Object> model = new HashMap<>();
        
        User u = this.userService.findByActiveCode(code);
            
        model.put("activeResult", (u == null ? false:true));
        
        // active success
        if(u != null){
            
            // enable
            this.userService.updateEnaled(Boolean.TRUE, u.getId());
            // set null active code
            this.userService.updateActiveCode(null, u.getId());
            
        }
        
        return new ModelAndView("user/regisConfirm", model);
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
            
            // update new active code
            String activeCode = UUID.randomUUID().toString();
            this.userService.updateActiveCode(activeCode, u.getId());
            
            // re-send active code
            MimeMessagePreparator preparator = new MimeMessagePreparator() {

                @SuppressWarnings({ "rawtypes", "unchecked" })
                @Override
                public void prepare(MimeMessage mimeMessage) throws Exception {

                    MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                    message.setTo(u.getEmail());
                    message.setCc("yhannart@gmail.com");
                    message.setFrom("support@lixi.global");
                    message.setSubject("LiXi.Global - Resend activation code");
                    message.setSentDate(Calendar.getInstance().getTime());

                    Map model = new HashMap();	             
                    model.put("user", u);
                    // built the path
                    String regisConfirmPath = ServletUriComponentsBuilder.fromContextPath(request).path("/user/registrationConfirm?code="+activeCode).build().toUriString();
                    model.put("regisConfirmPath", regisConfirmPath);

                    String text = VelocityEngineUtils.mergeTemplateIntoString(
                       velocityEngine, "emails/resend-active-code.vm", "UTF-8", model);
                    message.setText(text, true);

                  }

               };        

            // send email
            ExecutorService executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> mailSender.send(preparator));
            
            // return page
            model.put("email", u.getEmail());
            return new ModelAndView("user/signUpComplete", model);
            
        } catch (Exception e) {
            
            // no email
            model.put("activeResult", false);
            
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
        
        String captcha = request.getParameter("captcha");
        // captcha is correct
        if(captcha != null && captcha.equals(request.getSession().getAttribute("captcha"))){
           
            String email = request.getParameter("email");
            try {
                
                User u = this.userService.findByEmail(email);
                // u is not null. Send email
                
            } catch (Exception e) {
            }
        }
        
        return new ModelAndView("user/passwordAssistance");
        
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
            // exceptions will be thrown if there is no account
            User u = this.userService.findByEmail(form.getEmail());
            if(BCrypt.checkpw(form.getPassword(), u.getPassword())){
                
                HttpSession session = request.getSession();
                session.setAttribute("LOGIN_EMAIL", u.getEmail());
                // change session id
                request.changeSessionId();
            }
        } catch (ConstraintViolationException e) {
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("user/signIn");
        }
        
        return new ModelAndView(new RedirectView("/", true, true));
    }
    
    @RequestMapping(value = "signOut", method = RequestMethod.GET)
    public ModelAndView signOut(HttpSession session) {

        session.invalidate();
        //
        return new ModelAndView(new RedirectView("/", true, true));
    }
    
}
