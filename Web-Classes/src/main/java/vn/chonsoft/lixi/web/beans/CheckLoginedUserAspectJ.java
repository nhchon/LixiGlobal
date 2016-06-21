/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import java.text.SimpleDateFormat;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.UserSession;
import vn.chonsoft.lixi.repositories.service.UserSessionService;

/**
 *
 * @author chonnh
 */
@Aspect
public class CheckLoginedUserAspectJ {
    
    private static final Logger log = LogManager.getLogger(CheckLoginedUserAspectJ.class);
    
    @Autowired
    private LoginedUser loginedUser;
    
    @Pointcut("@annotation(vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation)")
    public void annotatedUserSecurityAnnotation(){}
    
    @Around(value = "annotatedUserSecurityAnnotation()")
    public Object doCheckLoginedUser(ProceedingJoinPoint jp) throws Throwable {
        
        //try {
            
            if(StringUtils.isEmpty(loginedUser.getEmail())){
                
                if(loginedUser.getLoginedDate()!=null){
                    return new ModelAndView(new RedirectView("/user/signIn?signInFailed=2", true, true));
                }
                else{
                    return new ModelAndView(new RedirectView("/user/signIn?signInFailed=3", true, true));
                }
                
            }
            
            /* continue to process */
            return jp.proceed();
            
        //} catch (Throwable e) {
            /**/
        //    log.info(e.getMessage(), e);
            /**/
        //    e.printStackTrace();
        //}
        
        //return null; // keeps in the same page
    }
}
