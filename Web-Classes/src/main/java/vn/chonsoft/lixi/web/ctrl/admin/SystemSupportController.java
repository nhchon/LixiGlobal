/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Calendar;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.pojo.EnumCustomerProblemStatus;
import vn.chonsoft.lixi.model.support.CustomerComment;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.model.support.CustomerProblemManagement;
import vn.chonsoft.lixi.repositories.service.CustomerCommentService;
import vn.chonsoft.lixi.repositories.service.CustomerProblemManagementService;
import vn.chonsoft.lixi.repositories.service.CustomerProblemService;
import vn.chonsoft.lixi.repositories.service.CustomerProblemStatusService;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemSupport")
public class SystemSupportController {
    
    @Autowired
    private CustomerProblemService probService;
    
    @Autowired
    private CustomerCommentService commentService;
    
    @Autowired
    private CustomerProblemStatusService statusService;
    
    @Autowired
    private CustomerProblemManagementService managementService;
    
    /**
     * 
     * @param model
     * @param rl
     * @param id
     * @return 
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(Map<String, Object> model, @RequestParam String rl, @PathVariable Long id){
        
        /* list status of problem */
        model.put("statuses", this.statusService.findAll());
        
        /* return list page*/
        model.put("rl", rl);
        
        CustomerProblem prob = this.probService.findOne(id);
        model.put("issue", prob);
        model.put("management", this.managementService.findByProblem(prob));
        
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
        
        /* */
        Pageable page = new PageRequest(0, 50, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        /* */
        return listIssue(model, EnumCustomerProblemStatus.OPEN.getValue(), page);
        
    }
    
    /**
     * 
     * @param model
     * @param status
     * @param page 
     * @return 
     */
    @RequestMapping(value = "list/{status}", method = RequestMethod.GET)
    public ModelAndView listIssue(Map<String, Object> model, @PathVariable Integer status, @PageableDefault(sort = {"id"}, value = 50, direction = Sort.Direction.DESC) Pageable page){
        
        /* list status of problem */
        model.put("statuses", this.statusService.findAll());
        
        model.put("status", status);
        
        /* */
        model.put("issues", this.probService.findByStatus(this.statusService.findByCode(status), page));
        
        return new ModelAndView("Administration/support/list");
        
    }
    
    /**
     * 
     * @param model
     * @param action
     * @param page
     * @return 
     */
    @RequestMapping(value = "management/{action}", method = RequestMethod.GET)
    public ModelAndView management(Map<String, Object> model, @PathVariable String action, @PageableDefault(sort = {"id"}, value = 50, direction = Sort.Direction.ASC) Pageable page){
        
        /* logined user */
        String loginedUser = SecurityContextHolder.getContext().getAuthentication().getName();
        
        // pass forward action
        model.put("action", action);
        
        /* */
        switch (action) {
            
            case "self":
                model.put("issues", this.managementService.findByHandler(loginedUser, page));
                break;
                
            case "all":
                model.put("issues", this.managementService.findByStatusAndHandler(this.statusService.findByCode(EnumCustomerProblemStatus.RE_ASSIGNED.getValue()), null, page));
                break;
            
            case "resolved":
                model.put("issues", this.managementService.findByStatusAndHandler(this.statusService.findByCode(EnumCustomerProblemStatus.RESOLVED.getValue()), loginedUser, page));
                break;
                
            default:
                model.put("issues", this.managementService.findByHandler(loginedUser, page));
        }
        
        return new ModelAndView("Administration/support/management");
        
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "management/handle/{id}", method = RequestMethod.GET)
    public ModelAndView management(Map<String, Object> model, @PathVariable Long id){
        
        /* logined user */
        String loginedUser = SecurityContextHolder.getContext().getAuthentication().getName();
        
        CustomerProblemManagement cpm = this.managementService.find(id);
        cpm.setHandledBy(loginedUser);
        cpm.setHandledDate(Calendar.getInstance().getTime());
        
        /**/
        this.managementService.save(cpm);
        
        /**/
        return new ModelAndView(new RedirectView("/Administration/SystemSupport/management/self", true, true));
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
        /* */
        prob.setStatus(this.statusService.findByCode(1)); // in process
        /* who handle this issue*/
        prob.setHandledBy(loginedUser);
        prob.setHandledDate(Calendar.getInstance().getTime());
        
        /* save*/
        this.probService.save(prob);
        
        /* turn back list page */
        return listIssue(model);
    }
    
    /**
     * 
     * @param model
     * @param probId
     * @param status
     * @return 
     */
    @RequestMapping(value = "changeStatus", method = RequestMethod.POST)
    public ModelAndView changeStatus(Map<String, Object> model, @RequestParam Long probId, @RequestParam Integer status){
        
        /* load problem */
        CustomerProblem prob = this.probService.findOne(probId);

        if(prob.getStatus().getCode() != status){
            /* update status*/
            prob.setStatus(this.statusService.findByCode(status));
            prob.setStatusDate(Calendar.getInstance().getTime());
            
            this.probService.save(prob);
        }
        
        /* Assign to management */
        if(status == EnumCustomerProblemStatus.RE_ASSIGNED.getValue()){
            
            CustomerProblemManagement cpm = new CustomerProblemManagement();
            cpm.setProblem(prob);

            this.managementService.save(cpm);
        }
        
        return new ModelAndView(new RedirectView("/Administration/SystemSupport/detail/"+probId, true, true));
    }
    /**
     * 
     * @param model
     * @param probId 
     * @param comment
     * @param rl
     * @return 
     */
    @RequestMapping(value = "addAComment", method = RequestMethod.POST)
    public ModelAndView addComment(Map<String, Object> model, @RequestParam Long probId, @RequestParam String comment, @RequestParam String rl){
        
        String loginedUser = SecurityContextHolder.getContext().getAuthentication().getName();
        /* load problem */
        CustomerProblem prob = this.probService.findOne(probId);
        
        CustomerComment c = new CustomerComment();
        c.setContent(comment);
        c.setProblem(prob);
        c.setCreatedBy(loginedUser);
        c.setCreatedDate(Calendar.getInstance().getTime());
        
        this.commentService.save(c);
        
        return new ModelAndView(new RedirectView("/Administration/SystemSupport/detail/"+probId+"?rl="+rl, true, true));
    }
}
