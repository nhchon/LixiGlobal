/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping("Search")
public class SearchController {
    
    private static final Logger log = LogManager.getLogger(SearchController.class);
    
    @Autowired
    private VatgiaProductService vgpService;
    
    @Autowired
    private LixiExchangeRateService lxexrateService;

    @Autowired
    private LixiOrderService lxorderService;

    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "search", method = RequestMethod.GET)
    public ModelAndView search(Map<String, Object> model, HttpServletRequest request) {
        
        return new ModelAndView("search/search");
        
    }
    
    /**
     * 
     * @param model
     * @param keyword
     * @param page
     * @param request
     * @return 
     */
    @RequestMapping(value = "search", params = "search=true", method = RequestMethod.GET)
    public ModelAndView search(Map<String, Object> model, @RequestParam String keyword, @PageableDefault(value = 10, sort = "price", direction = Sort.Direction.ASC) Pageable page, HttpServletRequest request) {
        
        // get order
        LixiOrder order = null;
        LixiExchangeRate lxExch = null;
        // order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {
            
            order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
            // get exchange rate of the order;
            lxExch = order.getLxExchangeRate();
        }
        else{
            
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        }
        
        /* list product */
        List<VatgiaProduct> products = null;

        Page<VatgiaProduct> vgps = this.vgpService.findByName("%"+keyword+"%", page);
        
        if(vgps.hasContent()){
            products = vgps.getContent();
        }
        
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.KEYWORD, keyword);
        
        return new ModelAndView("search/search");
        
    }
}
