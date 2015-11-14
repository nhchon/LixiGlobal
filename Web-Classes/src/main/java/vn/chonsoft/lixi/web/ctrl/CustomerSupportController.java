/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("support")
public class CustomerSupportController {
    
    /**
     * 
     * @return 
     */
    @RequestMapping(value = "show", method = RequestMethod.GET)
    public ModelAndView show(){
        
        return new ModelAndView("customer/post");
    }
}
