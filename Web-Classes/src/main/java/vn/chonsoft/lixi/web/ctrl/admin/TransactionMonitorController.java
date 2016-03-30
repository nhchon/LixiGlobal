/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.model.LixiMonitor;
import vn.chonsoft.lixi.repositories.service.LixiMonitorService;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping(value = "/Administration/TransactionMonitor")
public class TransactionMonitorController {
    
    private static final Logger log = LogManager.getLogger(TransactionMonitorController.class);
    
    @Autowired
    private LixiMonitorService lixiMonitorService;
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model){
        
        List<LixiMonitor> monitors = this.lixiMonitorService.findByProcessed(new Integer(0));
        model.put("monitors", monitors);
        
        return new ModelAndView("Administration/reports/monitor");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "process/{id}", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model, @PathVariable Long id){
        
        /* error for default */
        model.put("error", 1);
        
        LixiMonitor m = this.lixiMonitorService.find(id);
        if(m != null){
            
            /* processed */
            m.setProcessed(1);
            m.setModifiedDate(Calendar.getInstance().getTime());
            
            this.lixiMonitorService.save(m);
            
            model.put("error", 0);
        }
        
        return new ModelAndView("Administration/ajax/simple-message");
    }
}
