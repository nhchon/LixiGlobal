/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.security.crypto.bcrypt.BCrypt;
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
    
    @Inject UserService userService;
    
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
     * @return 
     */
    @RequestMapping(value = "signUp", method = RequestMethod.POST)
    public ModelAndView signUp(Map<String, Object> model,
            @Valid UserSignUpForm form, Errors errors) {
        
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
        u.setEnabled(true);
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
        
        return new ModelAndView(new RedirectView("/", true, true));
    }
    
    @RequestMapping(value = "signIn", method = RequestMethod.GET)
    public String signIn(Map<String, Object> model) {

        model.put("userSignInForm", new UserSignInForm());
        return "user/signIn";
    }

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
