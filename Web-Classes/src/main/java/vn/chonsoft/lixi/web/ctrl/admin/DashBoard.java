/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/Dashboard")
public class DashBoard {
    
    @RequestMapping(value = {"", "/"}, method = RequestMethod.GET)
    public String index(){
       return "Administration/dashboard"; 
    }
}
