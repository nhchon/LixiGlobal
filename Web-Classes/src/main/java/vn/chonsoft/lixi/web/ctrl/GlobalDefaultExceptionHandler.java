/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiConfig;
import vn.chonsoft.lixi.repositories.service.LixiConfigService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@ControllerAdvice
public class GlobalDefaultExceptionHandler {

    public static final String DEFAULT_ERROR_VIEW = "error";
    
    private static final Logger log = LogManager.getLogger(GlobalDefaultExceptionHandler.class);
    
    @Autowired
    private LixiConfigService configService;
    
    @Autowired
    private ThreadPoolTaskScheduler taskScheduler;
    
    @Autowired
    private VelocityEngine velocityEngine;
    
    @Autowired
    private JavaMailSender mailSender;
    
    /**
     * 
     * @return 
     */
    private String[] checkAndAssignDefaultEmail(){
        LixiConfig c = configService.findByName(LiXiGlobalConstants.LIXI_ADMINISTRATOR_EMAIL);
        if(c == null || StringUtils.isBlank(c.getValue())){
            return new String[] {LiXiGlobalConstants.YHANNART_GMAIL};
        }
        else{
            return c.getValue().split(";");
        }
    }
    
    /**
     * 
     * @param error 
     */
    private void emailLixiGlobalError(HttpServletRequest req, String url, String errMessage, String errDetails){
        
        /*
        call req.getRequestURL().toString() in this function, it returns http://www.lixi.global:8080/WEB-INF/jsp/view/error.jsp , 
        but not http://www.lixi.global:8080/user/passwordAssistance 
        So test pass url param
        */
        String[] administratorEmails = checkAndAssignDefaultEmail();
        
        // send Email
        MimeMessagePreparator preparator = new MimeMessagePreparator() {

            @SuppressWarnings({ "rawtypes", "unchecked" })
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                
                SimpleDateFormat sdfr = new SimpleDateFormat("MMM/dd/yyyy KK:mm:ss a");
                String errorDate = sdfr.format(Calendar.getInstance().getTime());
                    
                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(administratorEmails);
                message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                message.addCc(LiXiGlobalConstants.CHONNH_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("LiXi.Global Error - " + errorDate + ": " + StringUtils.defaultIfBlank(errMessage, ""));
                message.setSentDate(Calendar.getInstance().getTime());

                Map model = new HashMap();
                model.put("url", LiXiUtils.replaceHttp8080(url) + " - " +LiXiUtils.replaceHttp8080(req.getRequestURL().toString()));
                model.put("ipAddress", LiXiGlobalUtils.getClientIp(req));
                model.put("hostName", req.getRemoteHost());
                model.put("userAgent", req.getHeader("User-Agent"));
                model.put("errMessage", errMessage);
                model.put("errDetails", errDetails);

                String text = VelocityEngineUtils.mergeTemplateIntoString(
                   velocityEngine, "emails/lixi-error.vm", "UTF-8", model);
                message.setText(text, true);
              }
        };        

        // send oldEmail
        taskScheduler.execute(() -> mailSender.send(preparator));
        
    }
    
    /**
     * 
     * @return 
     */
    @RequestMapping("/error")
    @ExceptionHandler(value = Exception.class)
    public ModelAndView defaultErrorHandler(HttpServletRequest req, Exception e) throws Exception {
        // If the exception is annotated with @ResponseStatus rethrow it and let
        // the framework handle it - like the OrderNotFoundException example
        // at the start of this post.
        // AnnotationUtils is a Spring Framework utility class.
        //if (AnnotationUtils.findAnnotation(e.getClass(), ResponseStatus.class) != null) {
            //throw e;
        //}

        /* email to admin */
        emailLixiGlobalError(req, req.getRequestURL().toString(), e.getMessage(), ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
                
        // Otherwise setup and send the user to a default error-view.
        ModelAndView mav = new ModelAndView();
        mav.addObject("exception", e);
        mav.addObject("url", req.getRequestURL());
        mav.setViewName(DEFAULT_ERROR_VIEW);
        return mav;
    }
}
