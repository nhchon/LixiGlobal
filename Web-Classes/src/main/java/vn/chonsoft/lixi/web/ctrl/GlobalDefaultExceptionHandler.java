/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
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
    private String[] checkAndAssignDefaultEmail() {
        LixiConfig c = configService.findByName(LiXiGlobalConstants.LIXI_ADMINISTRATOR_EMAIL);
        if (c == null || StringUtils.isBlank(c.getValue())) {
            return new String[]{LiXiGlobalConstants.YHANNART_GMAIL};
        } else {
            return c.getValue().split(";");
        }
    }

    /**
     *
     * @param error
     */
    private void emailLixiGlobalError(HttpServletRequest req, String url, String errMessage, String errDetails) {

        /*
        call req.getRequestURL().toString() in this function, it returns http://www.lixi.global:8080/WEB-INF/jsp/view/error.jsp , 
        but not http://www.lixi.global:8080/user/passwordAssistance 
        So test pass url param
         */
        String[] administratorEmails = checkAndAssignDefaultEmail();

        // send Email
        MimeMessagePreparator preparator = new MimeMessagePreparator() {

            @SuppressWarnings({"rawtypes", "unchecked"})
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {

                SimpleDateFormat sdfr = new SimpleDateFormat("MMM/dd/yyyy KK:mm:ss a");
                String errorDate = sdfr.format(Calendar.getInstance().getTime());

                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setTo(administratorEmails);
                message.setCc(LiXiGlobalConstants.YHANNART_GMAIL);
                message.addCc(LiXiGlobalConstants.CHONNH_GMAIL);
                message.setFrom("support@lixi.global");
                message.setSubject("Lixi.Global Error - " + errorDate + ": " + StringUtils.defaultIfBlank(errMessage, ""));
                message.setSentDate(Calendar.getInstance().getTime());

                Map model = new HashMap();
                String ipAddress = LiXiGlobalUtils.getClientIp(req);
                InetAddress address = InetAddress.getByName(ipAddress);
                String hostName = address.getHostName();
                
                model.put("url", LiXiUtils.replaceHttp8080(url));
                model.put("ipAddress", ipAddress);
                model.put("hostName", hostName);
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
     * @param  req 
     * @param e
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

        /* get all header values */
        Enumeration eHs = req.getHeaderNames();
        StringBuilder b = new StringBuilder("<p>");
        b.append("<TABLE ALIGN=CENTER BORDER=1>");
        b.append("<tr><th> Header </th><th> Value </th>");

        while (eHs.hasMoreElements()) {
            String headers = (String) eHs.nextElement();
            if (headers != null) {
                b.append("<tr><td align=center><b>" + headers + "</td>");
                b.append("<td align=center>" + req.getHeader(headers)
                        + "</td></tr>");
            }
        }
        b.append("</TABLE><BR>");
        b.append("</p>");
        
        b.append("<p>");
        b.append(ExceptionUtils.getStackTrace(e).replaceAll("(\r\n|\n)", "<br />"));
        b.append("</p>");
        
        /* email to admin */
        //emailLixiGlobalError(req, req.getRequestURL().toString(), e.getMessage(), b.toString());

        // Otherwise setup and send the user to a default error-view.
        ModelAndView mav = new ModelAndView();
        mav.addObject("exception", e);
        mav.addObject("url", req.getRequestURL());
        mav.setViewName(DEFAULT_ERROR_VIEW);
        return mav;
    }
}
