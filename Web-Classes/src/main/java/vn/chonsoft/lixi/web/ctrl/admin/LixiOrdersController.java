/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/Orders")
@PreAuthorize("hasAuthority('SYSTEM_ORDERS_CONTROLLER')")
public class LixiOrdersController {
    
    @Autowired
    private LixiOrderService lxOrderService;
    
    @Autowired
    private LixiOrderGiftService lxogiftService;
    
    @Autowired
    private LixiAsyncMethods lxAsyncMethods;
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "newOrders", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model){
        
        return new ModelAndView(new RedirectView("/Administration/Orders/newOrders/" + EnumLixiOrderStatus.NOT_YET_SUBMITTED.getValue(), true, true));
    }
    
    @RequestMapping(value = "newOrders/{oStatus}", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model, @PathVariable String oStatus){
        
        //Page<LixiOrder> orders = this.lxOrderService.findByLixiStatus(LiXiConstants.LIXI_ORDER_NOT_YET_SUBMITTED, page);
        
        //model.put(LiXiConstants.LIXI_ORDERS, orders);
        List<LixiOrder> orders = this.lxOrderService.findByLixiStatus(oStatus);
        
        if(orders != null){
            Iterator<LixiOrder> iterator = orders.iterator();
            
            while(iterator.hasNext()){
                LixiOrder o = iterator.next();
                if(o.getGifts() == null || o.getGifts().isEmpty()){
                    /* remove the order has no gift. We don't need sent to baokim */
                    iterator.remove();
                }
            }
        }
        
        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        
        if(orders != null){
            
            orders.forEach(o -> {
                mOs.put(o, LiXiUtils.genMapRecGifts(o));
            });
        }
        
        model.put("mOs", mOs);
        
        return new ModelAndView("Administration/orders/newOrderInfo");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "submit2BK/{id}", method = RequestMethod.GET)
    public ModelAndView submitOrdersToBaoKim(Map<String, Object> model, @PathVariable Long id){
        
        LixiOrder order = this.lxOrderService.findById(id);
        
        if(order != null){
            lxAsyncMethods.submitOrdersToBaoKimNoAsync(order);
        }
        
        /* re-select */
        order = this.lxOrderService.findById(id);
        
        List<RecipientInOrder> rio = LiXiUtils.genMapRecGifts(order);
        
        model.put("rios", rio);
        
        return new ModelAndView("Administration/orders/bkSubmitMessage");
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
