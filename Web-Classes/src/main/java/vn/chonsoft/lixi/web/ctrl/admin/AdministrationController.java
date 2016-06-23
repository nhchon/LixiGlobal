/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Calendar;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.model.AdminUserPasswordHistory;
import vn.chonsoft.lixi.model.form.AdminUserChangePasswordForm;
import vn.chonsoft.lixi.model.form.AdminUserLoginForm;
import vn.chonsoft.lixi.repositories.service.AdminUserPasswordHistoryService;
import vn.chonsoft.lixi.repositories.service.AdminUserService;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration")
public class AdministrationController {
    
    private static final Logger log = LogManager.getLogger();
    
    @Inject AdminUserService auService;
    
    @Inject AdminUserPasswordHistoryService auphService;
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = {"", "/"}, method = RequestMethod.GET)
    public ModelAndView index(Map<String, Object> model){

        if(SecurityContextHolder.getContext().getAuthentication() != null)
            return new ModelAndView(new RedirectView("/Administration/Dashboard", true, true));
        //
        model.put("adminUserLoginForm", new AdminUserLoginForm());
        return new ModelAndView("Administration/login");
    }

    /**
     * 
     * show change password page
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "checkForceChangePassword", method = RequestMethod.GET)
    public ModelAndView checkForceChangePassword(Map<String, Object> model){

        if(SecurityContextHolder.getContext().getAuthentication() == null)
            return new ModelAndView(new RedirectView("/Administration/login", true, true));
        
        // check change password request
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        AdminUser au = this.auService.find(email);
        
        if(au.isPasswordNextTime()){
        
            model.put("adminUserChangePasswordForm", new AdminUserChangePasswordForm());
            return new ModelAndView("Administration/user/changePassword");
            
        }
        else{
            
            return new ModelAndView(new RedirectView("/Administration/TransactionMonitor/report", true, true));
            
        }
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @return 
     */
    @RequestMapping(value = "checkForceChangePassword", method = RequestMethod.POST)
    public ModelAndView changePassword(Map<String, Object> model,
            @Valid AdminUserChangePasswordForm form, Errors errors) {
        
        if (errors.hasErrors()) {
            
            return new ModelAndView("Administration/user/changePassword");
        }
        
        try {
            
            String email = SecurityContextHolder.getContext().getAuthentication().getName();
            AdminUser au = this.auService.find(email);
            
            // reset change password next time
            au.setPasswordNextTime(false);
            // set new password
            String encoded = (new BCryptPasswordEncoder()).encode(form.getPassword());
            au.setPassword(encoded);
            
            // save
            this.auService.save(au);
            
            // save password history
            AdminUserPasswordHistory auph = new AdminUserPasswordHistory();
            auph.setAdminUserId(au);
            auph.setPassword(encoded);
            auph.setModifiedDate(Calendar.getInstance().getTime());
            
            this.auphService.save(auph);
            
        } catch (ConstraintViolationException e) {
            
            //
            log.info(e.getMessage(), e);
            //
            model.put("validationErrors", e.getConstraintViolations());
            
            return new ModelAndView("Administration/user/changePassword");
        }
        
        // go to dashboard
        return new ModelAndView(new RedirectView("/Administration/Dashboard", true, true));
    }
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Map<String, Object> model){

        model.put("adminUserLoginForm", new AdminUserLoginForm());
        return "Administration/login"; 
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "/logout", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView logout(HttpServletRequest request){
        
        try {
            request.logout();
            //request.getSession().invalidate();
        } catch (Exception e) {
            log.info(e);
        }
        return new ModelAndView(new RedirectView("/Administration/login", true, true)); 
    }
}
