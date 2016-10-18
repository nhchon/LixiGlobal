/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Map;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping(value = "/Administration/Products")
public class ProductsController {
    
    @RequestMapping(value = "input", method = RequestMethod.GET)
    public ModelAndView view(Map<String, Object> model){
        
        return new ModelAndView("Administration/products/inputProduct");
        
    }
}
