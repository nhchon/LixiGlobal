/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Arrays;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.LixiMonitor;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.ShippingCharged;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.service.LixiConfigService;
import vn.chonsoft.lixi.repositories.service.LixiMonitorService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.ShippingChargedService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping(value = "/Administration/TransactionMonitor")
public class TransactionMonitorController {
    
    private static final Logger log = LogManager.getLogger(TransactionMonitorController.class);
    
    @Autowired
    private LixiMonitorService lixiMonitorService;
    
    @Autowired
    private LixiOrderService orderService;
    
    @Autowired
    private LixiConfigService configService;
    
    @Autowired
    private ShippingChargedService shipService;
    /**
     * 
     * @param model
     * @param pageable
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model, @PageableDefault(value = 50, sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable){
        
        //double baoKimTransferPercent = LiXiUtils.getBaoKimPercent(this.configService.findByName("LIXI_BAOKIM_TRANFER_PERCENT").getValue());
        
        // don't list complete, cancel order
        List<String> statuses = Arrays.asList(EnumLixiOrderStatus.UN_PROCESSED.getValue(), EnumLixiOrderStatus.PROCESSED.getValue(),
                EnumLixiOrderStatus.UNDELIVERABLE.getValue(), EnumLixiOrderStatus.REFUNDED.getValue(),
                EnumLixiOrderStatus.PURCHASED.getValue(), EnumLixiOrderStatus.DELIVERED.getValue());
        Page<LixiOrder> pOrders = this.orderService.findByLixiStatusIn(statuses, pageable);
        
        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        List<ShippingCharged> charged = this.shipService.findAll();
        
        if(pOrders != null){
            
            pOrders.getContent().forEach(o -> {
                if(o.getGifts()!=null && !o.getGifts().isEmpty())
                {
                    List<RecipientInOrder> recInOrder = LiXiUtils.genMapRecGifts(o);
                    recInOrder.forEach(r -> {r.setCharged(charged);});
                
                    mOs.put(o, recInOrder);
                }
            });
            
        }
        
        model.put("mOs", mOs);
        model.put("pOrders", pOrders);
        
        return new ModelAndView("Administration/reports/monitor");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "process/{id}", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model, @PathVariable Long id){
        
        /* error for default */
        model.put("error", 1);
        
        LixiMonitor m = this.lixiMonitorService.find(id);
        if(m != null){
            
            /* processed */
            m.setProcessed(1);
            m.setModifiedDate(Calendar.getInstance().getTime());
            
            this.lixiMonitorService.save(m);
            
            model.put("error", 0);
        }
        
        return new ModelAndView("Administration/ajax/simple-message");
    }
}
