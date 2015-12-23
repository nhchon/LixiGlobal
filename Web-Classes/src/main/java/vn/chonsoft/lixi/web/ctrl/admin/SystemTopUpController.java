/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemTopUp")
public class SystemTopUpController {
    
    @Autowired
    private TopUpMobilePhoneService topUpService;
    
    @Autowired
    private LixiAsyncMethods lxAsyncMethods;
    
    
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView notYetSubmitted(Map<String, Object> model){
    
        List<TopUpMobilePhone> topUps = this.topUpService.findByIsSubmitted(Arrays.asList(-1, 0));
        
        model.put("topUps", topUps);
        
        return new ModelAndView("Administration/orders/listTopUp");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "send2VTC/{id}", method = RequestMethod.GET)
    public ModelAndView submit2VTC(Map<String, Object> model, @PathVariable Long id){
        
        TopUpMobilePhone topUp = this.topUpService.findById(id);
        if(topUp != null){
            
            lxAsyncMethods.processTopUpItem(topUp);
        }
        
        RedirectView r = new RedirectView("/Administration/SystemTopUp/list", true, true);
        r.setExposeModelAttributes(false);
        return new ModelAndView(r);
    }
}
