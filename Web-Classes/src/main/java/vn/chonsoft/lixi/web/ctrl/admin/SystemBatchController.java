/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping(value = "/Administration/SystemBatch")
public class SystemBatchController {
    
    private static final Logger log = LogManager.getLogger(SystemBatchController.class);
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model){
        
        return new ModelAndView("Administration/reports/batches");
        
    }
}
