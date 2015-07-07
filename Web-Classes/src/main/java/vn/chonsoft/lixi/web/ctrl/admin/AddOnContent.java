/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Map;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/AddOn")
public class AddOnContent {

    @RequestMapping(value = "/topbar", method = {RequestMethod.GET, RequestMethod.POST})
    public String topbar(Map<String, Object> model){

        return "Administration/add-on/topbar"; 
    }
    
    @RequestMapping(value = "/navigation", method = {RequestMethod.GET, RequestMethod.POST})
    public String navigation(Map<String, Object> model){

        return "Administration/add-on/navigation"; 
    }

    @RequestMapping(value = "/sidebar", method = {RequestMethod.GET, RequestMethod.POST})
    public String sidebar(Map<String, Object> model){

        return "Administration/add-on/sidebar"; 
    }
}
