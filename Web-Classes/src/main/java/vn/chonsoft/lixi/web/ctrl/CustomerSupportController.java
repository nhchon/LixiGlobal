/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.model.form.support.CustomerProblemForm;
import vn.chonsoft.lixi.EnumCustomerProblemStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiContact;
import vn.chonsoft.lixi.model.form.LixiContactForm;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.model.support.CustomerSubject;
import vn.chonsoft.lixi.repositories.service.CustomerProblemService;
import vn.chonsoft.lixi.repositories.service.CustomerProblemStatusService;
import vn.chonsoft.lixi.repositories.service.CustomerSubjectService;
import vn.chonsoft.lixi.repositories.service.LixiContactService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LoginedUser;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("support")
public class CustomerSupportController {

    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private CustomerSubjectService subjectService;

    @Autowired
    private CustomerProblemService probService;

    @Autowired
    private CustomerProblemStatusService statusService;

    @Autowired
    private LixiContactService lcService;
    
    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;
    
    @Autowired
    private VelocityEngine velocityEngine;
    
    @Autowired
    private JavaMailSender mailSender;
    
    /**
     *
     * @param model
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "post", method = RequestMethod.GET)
    public ModelAndView post(Map<String, Object> model, HttpServletRequest request) {

        /* */
        model.put("customerProblemForm", new CustomerProblemForm());

        model.put("method", request.getParameter("method"));
        /* */
        model.put("subjects", subjectService.findAll());

        /* */
        return new ModelAndView("customer/post");
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
    @RequestMapping(value = "post", method = RequestMethod.POST)
    public ModelAndView post(Map<String, Object> model,
            @Valid CustomerProblemForm form, Errors errors, HttpServletRequest request) {

        if (errors.hasErrors()) {
            return new ModelAndView("customer/post");
        }

        try {
            /* Login user */
            String loginedEmail = loginedUser.getEmail();//(String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);

            CustomerSubject cus;
            if (form.getSubject() == -1) {
                /* new subject */
                cus = this.subjectService.save(new CustomerSubject(form.getOtherSubject(), Calendar.getInstance().getTime()));
            } else {
                /* load from DB */
                cus = this.subjectService.findOne(form.getSubject());
            }

            /* create customer problem */
            Date curDate = Calendar.getInstance().getTime();
            CustomerProblem prob = new CustomerProblem();
            prob.setSubject(cus);
            /* order id*/
            String orderIdStr = form.getOrderId();
            long orderId = 0;
            if(orderIdStr != null){
                orderIdStr = orderIdStr.replace("-", "").replace(" ", "");
                try {
                    orderId = Long.parseLong(orderIdStr);
                } catch (Exception e) {
                }
            }
            
            prob.setOrderId(orderId);
            prob.setContent(form.getContent());
            prob.setContactMethod(form.getContactMethod());
            prob.setContactData(form.getContactData());
            /* status */
            prob.setStatus(this.statusService.findByCode(EnumCustomerProblemStatus.OPEN.getValue()));//Open
            prob.setStatusDate(curDate);
            /* created date */
            prob.setCreatedDate(curDate);
            /* created by*/
            prob.setCreatedBy(loginedEmail);

            /* save*/
            //for(int i=0; i<1030; i++){
            //prob.setId(null);
            this.probService.save(prob);
            //}

        } catch (ConstraintViolationException e) {

            model.put("validationErrors", e.getConstraintViolations());

            return new ModelAndView("customer/post");
        }

        /* Thank you for your information */
        return new ModelAndView("customer/thank-you");
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "refundPolicy", method = RequestMethod.GET)
    public ModelAndView refundPolicy() {

        return new ModelAndView("customer/refund");
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "terms", method = RequestMethod.GET)
    public ModelAndView termOfUse() {

        return new ModelAndView("customer/terms");
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "privacy", method = RequestMethod.GET)
    public ModelAndView privacy() {

        return new ModelAndView("customer/privacy");
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "contact", method = RequestMethod.GET)
    public ModelAndView contact(Map<String, Object> model) {

        model.put("lixiContactForm", new LixiContactForm());

        return new ModelAndView("customer/contact");
    }

    /**
     *
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return
     */
    @RequestMapping(value = "contact", method = RequestMethod.POST)
    public ModelAndView contact(Map<String, Object> model,
            @Valid LixiContactForm form, Errors errors, HttpServletRequest request) {
        if (errors.hasErrors()) {
            return new ModelAndView("customer/contact");
        }

        try {
            
            LixiContact c = new LixiContact();
            c.setName(form.getName());
            c.setPhone(form.getPhone());
            c.setEmail(form.getEmail());
            c.setMessage(form.getMessage());
            c.setCreatedDate(Calendar.getInstance().getTime());
            
            this.lcService.save(c);
            
            // send mail
            sendEmail(c);
            
        } catch (ConstraintViolationException e) {

            model.put("validationErrors", e.getConstraintViolations());

            return new ModelAndView("customer/contact");
        }

        /* Thank you for your information */
        return new ModelAndView("customer/thank-you");
    }
    
    private void sendEmail(LixiContact c){
        // send Email
        MimeMessagePreparator preparator = new MimeMessagePreparator() {

            @SuppressWarnings({ "rawtypes", "unchecked" })
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {

                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(LiXiGlobalConstants.YHANNART_GMAIL);
                message.setCc(LiXiGlobalConstants.CHONNH_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global - Customer Contact Alert");
                message.setSentDate(Calendar.getInstance().getTime());

                Map model = new HashMap();	             
                model.put("c", c);

                String text = VelocityEngineUtils.mergeTemplateIntoString(
                   velocityEngine, "emails/cus-contact-alert.vm", "UTF-8", model);
                message.setText(text, true);
              }
        };        

        // send oldEmail
        taskScheduler.execute(() -> mailSender.send(preparator));
        
    }
}
