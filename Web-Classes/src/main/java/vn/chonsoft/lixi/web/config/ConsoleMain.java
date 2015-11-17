/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.config;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

/**
 *
 * @author chonnh
 */
public class ConsoleMain {
    
    public static void main(String[] args) {
        
        AnnotationConfigApplicationContext appContext = new AnnotationConfigApplicationContext(ConsoleContextConfiguration.class);
        
        System.out.println("Hello");
    }
}
