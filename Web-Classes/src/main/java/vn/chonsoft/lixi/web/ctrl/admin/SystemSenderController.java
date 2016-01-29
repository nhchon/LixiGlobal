/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.repositories.service.ScalarFunctionService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemSender")
public class SystemSenderController {
    
    @Autowired
    private UserService uService;
    
    @Autowired
    private ScalarFunctionService sfService;
    
    /**
     * 
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(){
        
        return new ModelAndView(new RedirectView("/Administration/SystemSender/report/1/Processed", true, true));
    }
    
    /**
     * 
     * @param model
     * @param status
     * @param oStatus
     * @param page
     * @return 
     */
    @RequestMapping(value = "report/{status}/{oStatus}", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model, @PathVariable int status, @PathVariable String oStatus, @PageableDefault(value = 50, sort = "id", direction = Sort.Direction.DESC) Pageable page){
        
        boolean activated = true;
        if(status == 0) activated = false;
        
        /* */
        Page<User> ps = this.uService.findByActivated(activated, page);
        
        List<User> rS = new ArrayList<>();
        
        if(ps != null && !ps.getContent().isEmpty()){
            
            ps.getContent().forEach(s -> {
                s.setSumInvoice(sfService.sumInvoiceOfSender(oStatus, s.getId()));
            });
            
            rS = new ArrayList<>(ps.getContent());
            
            rS.sort((User s1, User s2)->{return s2.getSumInvoice().compareTo(s1.getSumInvoice());});
        }
        
        model.put("status", status);
        model.put("rS", rS);
        model.put("pRs", ps);
        model.put("VCB", LiXiUtils.getVCBExchangeRates());
        
        return new ModelAndView("Administration/reports/senders");
    }
    
}
