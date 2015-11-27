/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.web.LiXiConstants;

/**
 *
 * @author chonnh
 */
@Aspect
public class CheckLoginedUserAspectJ {
    
    private static final Logger log = LogManager.getLogger(CheckLoginedUserAspectJ.class);
    
    @Autowired
    private LoginedUser loginedUser;
    
    //@Pointcut("execution(public * vn.chonsoft.lixi.web.ctrl.*.*(..))")
    //public void anyPublicMethod() {}
    
    @Pointcut("@annotation(vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation)")
    public void annotatedUserSecurityAnnotation(){}
    
    @Around(value = "annotatedUserSecurityAnnotation()")
    public Object doCheckLoginedUser(ProceedingJoinPoint jp){
        
        //log.info("Execute: " + jp.getSignature().toShortString());
        
        try {
            
            /*
            Object[] args = jp.getArgs();
            
            if(args != null){
            
                if(args[args.length - 1] instanceof HttpServletRequest){
                    
                    HttpServletRequest request = (HttpServletRequest)args[args.length - 1];
                    
                    if(request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL) != null){
                        
                        return jp.proceed();
                    }
                    else{
                        return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
                    }
                }
            }
            // we don't have HttpServletRequest in param list
            // Let execute function
            return jp.proceed();
            */
            
            if("".equals(loginedUser.getEmail()) || loginedUser.getEmail() == null){
                
                return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
                
            }
            else{
                
                return jp.proceed();
                
            }
            
        } catch (Throwable e) {
            
            log.info(e.getMessage(), e);
            
        }
        
        //
        return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
    }
}
