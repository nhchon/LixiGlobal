/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import javax.servlet.http.HttpServletRequest;
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
    public void annotatedUserSecurityAnnotation() {
    }

    @Around(value = "annotatedUserSecurityAnnotation()")
    public Object doCheckLoginedUser(ProceedingJoinPoint jp) throws Throwable {

        // session expired
        if (StringUtils.isEmpty(loginedUser.getEmail())) {
            
            HttpServletRequest req = null;
                    
            Object[] args = jp.getArgs();
            if (args != null) {
                for(int i=0; i< args.length; i++){
                    if(args[i] instanceof HttpServletRequest){
                        req = (HttpServletRequest) args[i];
                        break;
                    }
                }
            }
            String nextUrl = "";
            if (req != null) {
                if(req.getRequestURI().contains("/ajax/")){
                    return new ModelAndView(new RedirectView("/sessionExpired", true, true));
                }
                else{
                    nextUrl = "&nextUrl=" + req.getRequestURI().substring(req.getContextPath().length());
                }
            }
            // login page
            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=3"+nextUrl, true, true));
        }

        /* continue to process */
        return jp.proceed();
    }
}
