/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("gifts")
public class GiftsController {
    
    private static final Logger log = LogManager.getLogger(GiftsController.class);
    
    @Inject
    UserService userService;
    
    @Inject
    RecipientService reciService;
    
    @Inject
    CurrencyTypeService currencyService;
    
    /**
     * 
     * @param request 
     * @return 
     */
    @RequestMapping(value = "recipient", method = RequestMethod.GET)
    public ModelAndView recipient(HttpServletRequest request){

        Map<String, Object> model = new HashMap<>();
        
        // check login
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("LOGIN_EMAIL");
        if(email == null){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        // select recipients of user
        User u = this.userService.findByEmail(email);
        if(u != null){
            
            model.put("RECIPIENTS", u.getRecipients());
        }
        
        model.put("chooseRecipientForm", new ChooseRecipientForm());
        
        return new ModelAndView("giftprocess/recipient", model);
        
    }
    
    private void setRecipients(Map<String, Object> model, String email){
        
        User u = this.userService.findByEmail(email);
        if(u != null){

            model.put("RECIPIENTS", u.getRecipients());
        }
        
    }
    
    /**
     * 
     * @param model
     * @param u 
     */
    private void setRecipients(Map<String, Object> model, User u){
        
        if(u != null){

            model.put("RECIPIENTS", u.getRecipients());
        }
        
    }
    /**
     * 
     * @param recId
     * @param request
     * @return 
     */
    @RequestMapping(value = "chooseRecipient/{recId}", method = RequestMethod.GET)
    public ModelAndView chooseRecipient(@PathVariable Long recId, HttpServletRequest request){
        
        Map<String, Object> model = new HashMap<>();
        
        // check login
        HttpSession session = request.getSession();
        String email = (String)session.getAttribute("LOGIN_EMAIL");
        if(email == null){
            
            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);
            
        }
        // select recipients of user
        setRecipients(model, email);
        
        Recipient reci = this.reciService.findById(recId);
        if(reci == null){
            // wrong recId
            model.put("chooseRecipientForm", new ChooseRecipientForm());
        }
        else{
            
            ChooseRecipientForm form = new ChooseRecipientForm();
            form.setRecId(recId);
            form.setFirstName(reci.getFirstName());
            form.setMiddleName(reci.getMiddleName());
            form.setLastName(reci.getLastName());
            form.setEmail(reci.getEmail());
            form.setPhone(reci.getPhone());
            form.setNote(reci.getNote());

            model.put("chooseRecipientForm", form);
        }
        //
        return new ModelAndView("giftprocess/recipient", model);
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = {"recipient", "chooseRecipient/{recId}"}, method = RequestMethod.POST)
    public ModelAndView chooseRecipient(Map<String, Object> model,
            @Valid ChooseRecipientForm form, Errors errors, HttpServletRequest request) {
        
        String email = (String)request.getSession().getAttribute(LiXiConstants.LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        if (errors.hasErrors()) {

            // select recipients of user
            setRecipients(model, u);
            //
            return new ModelAndView("giftprocess/recipient");
        }
        
        try {
            
            //
            Recipient rec = new Recipient();
            rec.setId(form.getRecId());
            rec.setSender(u);
            rec.setFirstName(form.getFirstName());
            rec.setLastName(form.getLastName());
            rec.setEmail(form.getEmail());
            rec.setPhone(form.getPhone());
            rec.setNote(form.getNote());
            rec.setModifiedDate(Calendar.getInstance().getTime());
            
            this.reciService.save(rec);
            
            // store selected recipient into session
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT, rec.getId());
            
            // jump to page Value Of Gift
            return new ModelAndView(new RedirectView("/gifts/value", true, true));
            
        } catch (ConstraintViolationException e) {
            
            log.info(e.getMessage(), e);
            
            setRecipients(model, u);
            
            model.put("validationErrors", e.getConstraintViolations());
            
            return new ModelAndView("giftprocess/recipient");
            
        }
        
    }
    
    @RequestMapping(value = "value", method = RequestMethod.GET)
    public ModelAndView value(HttpServletRequest request){
        
        if(request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT) == null){
            
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }
        else{
            
            Map<String, Object> model = new HashMap<>();
            
            model.put(LiXiConstants.CURRENCIES, this.currencyService.findAll());
            
            return new ModelAndView("giftprocess/value-of-gift", model);
        }
    }
}
