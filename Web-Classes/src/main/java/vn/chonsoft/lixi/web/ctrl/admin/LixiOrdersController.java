/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/Orders")
@PreAuthorize("hasAuthority('SYSTEM_ORDERS_CONTROLLER')")
public class LixiOrdersController {
    
    @Inject
    private LixiOrderService lxOrderService;
    
    @Inject
    private LixiOrderGiftService lxogiftService;
    /**
     * 
     * @param model
     * @param page
     * @return 
     */
    @RequestMapping(value = "newOrders", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model, @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC, size = 50) Pageable page){
        
        Page<LixiOrder> orders = this.lxOrderService.findByLixiStatus(LiXiConstants.LIXI_ORDER_NOT_YET_SUBMITTED, page);
        
        model.put(LiXiConstants.LIXI_ORDERS, orders);
        
        return new ModelAndView("Administration/orders/notCompletedOrders");
    }
    
    /**
     * 
     * @param model
     * @param orderIds
     * @return 
     */
    @RequestMapping(value = "sendToBaoKim", method = RequestMethod.POST)
    public ModelAndView submitOrdersToBaoKim(Map<String, Object> model, @RequestParam(value="orderId") Long[] orderIds){
        
        if(orderIds != null && orderIds.length > 0){
            
            List<LixiOrder> orders = this.lxOrderService.findAll(Arrays.asList(orderIds));
            for(LixiOrder order : orders){
                // send to bao kim
                LiXiVatGiaUtils.getInstance().submitOrdersToBaoKim(order, lxOrderService, lxogiftService);
            }
        }
        //
        return new ModelAndView(new RedirectView("/Administration/Orders/newOrders", true, true));
    }
}
