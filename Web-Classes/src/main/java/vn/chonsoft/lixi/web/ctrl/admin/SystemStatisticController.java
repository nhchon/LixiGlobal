/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.repositories.service.ScalarFunctionService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CategoriesBean;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping(value = "/Administration/SystemStatistic")
@PreAuthorize("hasAuthority('SYSTEM_CONFIG_CONTROLLER')")
public class SystemStatisticController {
    
    private static final Logger log = LogManager.getLogger(SystemStatisticController.class);
    
    @Autowired
    private CategoriesBean categories;
    
    @Autowired
    VatgiaProductService vgpService;
    
    @Autowired
    ScalarFunctionService scaService;
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "product", method = RequestMethod.GET)
    public ModelAndView configs(Map<String, Object> model){
        
        int canId = categories.getCandies().getVatgiaId().getId();
        List<VatgiaProduct> vgps = this.vgpService.findByCategoryIdAndAlive(canId, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        
        if(vgps != null && !vgps.isEmpty()){
            
            model.put("LOWEST_CANDY", vgps.get(0));
            model.put("HIGHEST_CANDY", vgps.get(vgps.size()-1));
            
            double sumPrice = this.scaService.sumProductPrice(canId, 1);
            
            double avgPrice = LiXiGlobalUtils.truncD(sumPrice/vgps.size());
            
            model.put("AVG_CANDY",avgPrice);
        }
        
        return new ModelAndView("Administration/reports/productStatistic");
    }
}
