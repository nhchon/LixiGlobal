/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
public class IndexController {
    
    @RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
    public String index(){
       return "index"; 
    }
    
    /**
     * 
     * for common header content
     * 
     * @return 
     */
    @RequestMapping(value = "/top", method = {RequestMethod.GET, RequestMethod.POST})
    public String top(){
       return "top"; 
    }
    
    /**
     * 
     * for static footer content
     * 
     * @return 
     */
    @RequestMapping(value = "/bottom", method = {RequestMethod.GET, RequestMethod.POST})
    public String bottom(){
       return "bottom"; 
    }
}
