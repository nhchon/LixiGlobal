/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.ArrayList;
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
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.ScalarFunctionService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemSender")
public class SystemSenderController {
    
    private static final Logger log = LogManager.getLogger(SystemSenderController.class);
    
    @Autowired
    private LixiOrderService lxOrderService;
    
    @Autowired
    private UserService uService;
    
    @Autowired
    private ScalarFunctionService sfService;
    
    /**
     * 
     * (Ajax call)
     * 
     * @param model
     * @param id
     * @param oStatus
     * @return 
     */
    @RequestMapping(value = "action/{id}/{oStatus}", method = RequestMethod.GET)
    public ModelAndView action(Map<String, Object> model, @PathVariable long id, @PathVariable String oStatus){
        
        /* failed is default */
        model.put("error", 1);
        
        /* get user */
        User u = this.uService.findById(id);
        if(u == null){
            // NOTHING TO-DO
        }
        else{
            
            if(LiXiGlobalConstants.OFF.equals(oStatus)){
                
                u.setActivated(false);
            }
            else if(LiXiGlobalConstants.ON.equals(oStatus)){
                
                u.setActivated(true);
            }
            
            /* update user */
            this.uService.save(u);
            
            model.put("error", 0);
        }
        
        /* */
        return new ModelAndView("Administration/ajax/simple-message");
    }
    
    /**
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "view/{id}", method = RequestMethod.GET)
    public ModelAndView viewSender(Map<String, Object> model, @PathVariable Long id) {

        /* get recipient */
        User sender = this.uService.findById(id);

        model.put("sender", sender);

        return new ModelAndView("Administration/orders/viewSenderModal");
    }
    
    /**
     *
     * @param model
     * @param id
     * @param page
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public ModelAndView detailSender(Map<String, Object> model, @PathVariable Long id, @PageableDefault(value = 50, sort = {"lixiStatus", "id"}, direction = Sort.Direction.DESC) Pageable page) {

        /* get recipient */
        User sender = this.uService.findById(id);
        
        sender.setSumInvoice(
                sfService.sumInvoiceByOrderStatus(EnumLixiOrderStatus.PROCESSED.getValue(), sender.getId()) 
                +
                sfService.sumInvoiceByOrderStatus(EnumLixiOrderStatus.COMPLETED.getValue(), sender.getId()));
        
        sender.setSumInvoiceVnd(
                sfService.sumInvoiceVndByOrderStatus(EnumLixiOrderStatus.PROCESSED.getValue(), sender.getId()) 
                +
                sfService.sumInvoiceVndByOrderStatus(EnumLixiOrderStatus.COMPLETED.getValue(), sender.getId()));
        
        sender.setGraders(sfService.countOrdersOfSender(EnumLixiOrderStatus.COMPLETED.getValue(), sender.getId()));
        
        /* List order by recipient */
        /*
        if(!CollectionUtils.isEmpty(sender.getRecipients())){
            
            sender.getRecipients().forEach(r -> {
                
                List<Long> processedOrderIds = this.sfService.getOrdersOfRecipient(EnumLixiOrderStatus.PROCESSED.getValue(), r.getId());
                
                r.setProcessedOrders(this.lxOrderService.findAll(processedOrderIds));
            });
        }
        */
        
        model.put("sender", sender);

        Page<LixiOrder> pOrders = this.lxOrderService.findBySender(sender, page);

        List<LixiOrder> orders = pOrders.getContent();
        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        
        if(!CollectionUtils.isEmpty(orders)){
            
            orders.forEach(o -> {
                mOs.put(o, LiXiUtils.genMapRecGifts(o));
            });
        }
        
        model.put("mOs", mOs);
        
        model.put("pOrders", pOrders);
                
        return new ModelAndView("Administration/orders/senderDetail");
    }
    
    /**
     * 
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(){
        
        return new ModelAndView(new RedirectView("/Administration/SystemSender/report/1/0", true, true));
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
                
                if(EnumLixiOrderStatus.PROCESSED.getValue().equals(oStatus) || 
                   EnumLixiOrderStatus.COMPLETED.getValue().equals(oStatus) || 
                   EnumLixiOrderStatus.CANCELED.getValue().equals(oStatus)){
                    
                    s.setSumInvoice(sfService.sumInvoiceByOrderStatus(oStatus, s.getId()));
                    s.setGraders(sfService.countOrdersOfSender(oStatus, s.getId()));
                }
                else{
                    s.setSumInvoice(sfService.sumInvoiceOfSender(oStatus, s.getId()));
                    s.setGraders(sfService.countInvoiceOfSender(oStatus, s.getId()));
                }
            });
            
            rS = new ArrayList<>(ps.getContent());
            
            rS.sort((User s1, User s2)->{return s2.getSumInvoice().compareTo(s1.getSumInvoice());});
        }
        
        model.put("status", status);
        model.put("rS", rS);
        model.put("pRs", ps);
        model.put("VCB", LiXiGlobalUtils.getVCBExchangeRates());
        
        return new ModelAndView("Administration/reports/senders");
    }
    
}
