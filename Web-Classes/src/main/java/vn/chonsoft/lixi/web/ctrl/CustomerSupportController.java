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
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.model.form.support.CustomerProblemForm;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.model.support.CustomerSubject;
import vn.chonsoft.lixi.repositories.service.CustomerProblemService;
import vn.chonsoft.lixi.repositories.service.CustomerSubjectService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("support")
public class CustomerSupportController {
    
    @Inject
    private CustomerSubjectService subjectService;
    
    @Inject
    private CustomerProblemService probService;
    
    /**
     * 
     * @return 
     */
    @RequestMapping(value = "post", method = RequestMethod.GET)
    public ModelAndView post(){
        
        Map<String, Object> model = new HashMap<>();
        
        /* */
        model.put("customerProblemForm", new CustomerProblemForm());
        
        /* */
        model.put("subjects", subjectService.findAll());
        
        /* */
        return new ModelAndView("customer/post", model);
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "post", method = RequestMethod.POST)
    public ModelAndView post(Map<String, Object> model,
            @Valid CustomerProblemForm form, Errors errors, HttpServletRequest request){
        
        if (errors.hasErrors()) {
            return new ModelAndView("customer/post");
        }
        
        try {
            /* Login user */
            String loginedEmail = (String)request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            
            CustomerSubject cus;
            if(form.getSubject() == -1){
                /* new subject */
                cus = this.subjectService.save(new CustomerSubject(form.getOtherSubject(), Calendar.getInstance().getTime()));
            }
            else{
                /* load from DB */
                cus = this.subjectService.findOne(form.getSubject());
            }
            
            /* create customer problem */
            CustomerProblem prob = new CustomerProblem();
            prob.setSubject(cus);
            /* order id*/
            prob.setOrderId(form.getOrderId());
            prob.setContent(form.getContent());
            prob.setContactMethod(form.getContactMethod());
            prob.setContactData(form.getContactData());
            /* created date */
            prob.setCreatedDate(Calendar.getInstance().getTime());
            /* created by*/
            prob.setCreatedBy(loginedEmail);
            
            /* save*/
            this.probService.save(prob);
            
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            
            return new ModelAndView("customer/post");
        }
        
        /* Thank you for your information */
        return new ModelAndView("customer/thank-you");
    }
}
