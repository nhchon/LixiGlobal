/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import javax.servlet.http.HttpServletRequest;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.web.LiXiConstants;

/**
 *
 * @author chonnh
 */
@Aspect
public class CheckLoginedUserAspectJ {
    
    @Pointcut("execution(public * vn.chonsoft.lixi.web.ctrl.UserManagementController.*(..))")
    public void loginedUser(){}
    
    @Around("loginedUser()")
    public Object doCheckLoginedUser(ProceedingJoinPoint jp){
        
        System.out.println("Start check login user ===========================");
        
        try {
            
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
            else{
                return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
            }
            
        } catch (Throwable e) {
            e.printStackTrace();
        }
        //
        return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));
    }
}
