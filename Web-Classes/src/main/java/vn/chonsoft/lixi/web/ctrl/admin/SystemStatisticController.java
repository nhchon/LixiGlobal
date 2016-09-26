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
        
        // candies
        int canId = categories.getCandies().getVatgiaId().getId();
        List<VatgiaProduct> candies = this.vgpService.findByCategoryIdAndAlive(canId, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        
        if(candies != null && !candies.isEmpty()){
            
            model.put("LOWEST_CANDY", candies.get(0));
            model.put("HIGHEST_CANDY", candies.get(candies.size()-1));
            
            double sumPrice = this.scaService.sumProductPrice(canId, 1);
            
            double avgPrice = LiXiGlobalUtils.truncD(sumPrice/candies.size());
            
            model.put("SIZE_CANDY", candies.size());
            model.put("AVG_CANDY",avgPrice);
        }
        
        // JEWELRIES
        int jewId = categories.getJewelries().getVatgiaId().getId();
        List<VatgiaProduct> jews = this.vgpService.findByCategoryIdAndAlive(jewId, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        if(jews != null && !jews.isEmpty()){
            
            model.put("LOWEST_JEW", jews.get(0));
            model.put("HIGHEST_JEW", jews.get(jews.size()-1));
            
            double sumPrice = this.scaService.sumProductPrice(jewId, 1);
            
            double avgPrice = LiXiGlobalUtils.truncD(sumPrice/jews.size());
            
            model.put("SIZE_JEW", jews.size());
            model.put("AVG_JEW",avgPrice);
        }
        
        // PERFUME
        int perId = categories.getPerfume().getVatgiaId().getId();
        List<VatgiaProduct> pers = this.vgpService.findByCategoryIdAndAlive(perId, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        if(pers != null && !pers.isEmpty()){
            
            model.put("LOWEST_PER", pers.get(0));
            model.put("HIGHEST_PER", pers.get(pers.size()-1));
            
            double sumPrice = this.scaService.sumProductPrice(perId, 1);
            
            double avgPrice = LiXiGlobalUtils.truncD(sumPrice/pers.size());
            
            model.put("SIZE_PER", pers.size());
            model.put("AVG_PER",avgPrice);
        }
        
        // COSMETICS
        int cosId = categories.getCosmetics().getVatgiaId().getId();
        List<VatgiaProduct> coss = this.vgpService.findByCategoryIdAndAlive(cosId, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        if(coss != null && !coss.isEmpty()){
            
            model.put("LOWEST_COS", coss.get(0));
            model.put("HIGHEST_COS", coss.get(coss.size()-1));
            
            double sumPrice = this.scaService.sumProductPrice(cosId, 1);
            
            double avgPrice = LiXiGlobalUtils.truncD(sumPrice/coss.size());
            
            model.put("SIZE_COS", coss.size());
            model.put("AVG_COS",avgPrice);
        }
        
        // CHILDREN TOYS
        int toyId = categories.getChildrentoy().getVatgiaId().getId();
        List<VatgiaProduct> toys = this.vgpService.findByCategoryIdAndAlive(toyId, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        if(toys != null && !toys.isEmpty()){
            
            model.put("LOWEST_TOY", toys.get(0));
            model.put("HIGHEST_TOY", toys.get(toys.size()-1));
            
            double sumPrice = this.scaService.sumProductPrice(toyId, 1);
            
            double avgPrice = LiXiGlobalUtils.truncD(sumPrice/toys.size());
            
            model.put("SIZE_TOY", toys.size());
            model.put("AVG_TOY",avgPrice);
        }
        
        // FLOWER
        int floId = categories.getFlowers().getVatgiaId().getId();
        List<VatgiaProduct> flowers = this.vgpService.findByCategoryIdAndAlive(floId, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        if(flowers != null && !flowers.isEmpty()){
            
            model.put("LOWEST_FLO", flowers.get(0));
            model.put("HIGHEST_FLO", flowers.get(flowers.size()-1));
            
            double sumPrice = this.scaService.sumProductPrice(floId, 1);
            
            double avgPrice = LiXiGlobalUtils.truncD(sumPrice/flowers.size());
            
            model.put("SIZE_FLO", flowers.size());
            model.put("AVG_FLO",avgPrice);
        }
        
        return new ModelAndView("Administration/reports/productStatistic");
    }
    
}
