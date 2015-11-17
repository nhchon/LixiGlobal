/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Calendar;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.repositories.service.CustomerProblemService;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemSupport")
public class SystemSupportController {
    
    @Inject
    private CustomerProblemService probService;
    
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(Map<String, Object> model, @PathVariable Long id){
        
        model.put("issue", this.probService.findOne(id));
        
        return new ModelAndView("Administration/support/detail");
        
    }
    /**
     * 
     * 
     * @param model 
     * @return 
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView listIssue(Map<String, Object> model){
        
        model.put("issues", this.probService.findAll());
        
        return new ModelAndView("Administration/support/list");
        
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "handle/{id}", method = RequestMethod.GET)
    public ModelAndView handleIssue(Map<String, Object> model, @PathVariable Long id){
        
        String loginedUser = SecurityContextHolder.getContext().getAuthentication().getName();
        
        CustomerProblem prob = this.probService.findOne(id);
        /* who handle this issue*/
        prob.setHandledBy(loginedUser);
        prob.setHandledDate(Calendar.getInstance().getTime());
        
        /* save*/
        this.probService.save(prob);
        
        /* turn back list page */
        return listIssue(model);
    }
    
}
