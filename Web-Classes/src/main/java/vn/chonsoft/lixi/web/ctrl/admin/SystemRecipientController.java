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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.ScalarFunctionService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemRecipient")
public class SystemRecipientController {
    
    @Autowired
    private RecipientService recService;
    
    @Autowired
    private ScalarFunctionService sfService;
    
    /**
     * 
     * @param model
     * @param page
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model, @PageableDefault(value = 50, sort = "id", direction = Sort.Direction.DESC) Pageable page){
        
        Page<Recipient> ps = this.recService.findAll(page);
        
        List<Recipient> rS = new ArrayList<>();
        
        if(ps != null && !ps.getContent().isEmpty()){
            
            ps.getContent().forEach(r -> {
                r.setSumGift(sfService.sumGiftOfRecipient(r.getId()));
                r.setSumTopUp(sfService.sumTopUpOfRecipient(r.getId()));
            });
            
            rS = new ArrayList<>(ps.getContent());
            
            rS.sort((Recipient r1, Recipient r2)->{return r2.getSumAll().compareTo(r1.getSumAll());});
        }
        
        model.put("rS", rS);
        model.put("pRs", ps);
        model.put("VCB", LiXiUtils.getVCBExchangeRates());
        
        return new ModelAndView("Administration/reports/receivers");
    }
}
