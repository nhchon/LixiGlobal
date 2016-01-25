/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.pojo.EnumTopUpStatus;
import vn.chonsoft.lixi.repositories.service.PaymentService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemTopUp")
public class SystemTopUpController {
    
    @Autowired
    private TopUpMobilePhoneService topUpService;
    
    @Autowired
    private PaymentService paymentService;
    
    @Autowired
    private LixiAsyncMethods lxAsyncMethods;
    
    
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView notYetSubmitted(Map<String, Object> model){
    
        List<TopUpMobilePhone> topUps = this.topUpService.findByIsSubmitted(Arrays.asList(-1, 0));
        
        model.put("topUps", topUps);
        
        return new ModelAndView("Administration/orders/listTopUp");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "send", method = RequestMethod.POST)
    public ModelAndView send(Map<String, Object> model, @RequestParam Long id){
        
        model.put("error", "1");
        
        TopUpMobilePhone t = this.topUpService.findById(id);
        
        LixiInvoice invoice = t.getOrder().getInvoice();
        
        /* update status */
        this.paymentService.updateInvoiceStatus(invoice);
        
        if(LiXiGlobalConstants.TRANS_STATUS_IN_PROGRESS.equals(invoice.getTranslatedStatus()) ||
           LiXiGlobalConstants.TRANS_STATUS_PROCESSED.equals(invoice.getTranslatedStatus())){
            
            String rs = lxAsyncMethods.processTopUpItemNoAsync(t);
            
            if(LiXiConstants.VTC_OK.equals(rs)){
                /* override error attr*/
                model.put("error", "0");
            }
        }
        model.put("status", invoice.getTranslatedStatus());
        model.put("statusDate", Calendar.getInstance().getTime());
        model.put("orderId", invoice.getInvoiceCode());
        model.put("vtcMessage", t.getResponseMessage());
        
        return new ModelAndView("Administration/ajax/topup-message");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "check", method = RequestMethod.POST)
    public ModelAndView check(Map<String, Object> model, @RequestParam Long id){
        
        model.put("error", "0");
        
        TopUpMobilePhone t = this.topUpService.findById(id);
        
        LixiInvoice invoice = t.getOrder().getInvoice();
        
        /* update status */
        this.paymentService.updateInvoiceStatus(invoice);
        
        model.put("status", invoice.getTranslatedStatus());
        model.put("statusDate", Calendar.getInstance().getTime());
        model.put("orderId", invoice.getInvoiceCode());
        
        return new ModelAndView("Administration/ajax/topup-message");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "cancel", method = RequestMethod.POST)
    public ModelAndView cancel(Map<String, Object> model, @RequestParam Long id){
        
        model.put("error", "0");
        
        TopUpMobilePhone t = this.topUpService.findById(id);
        
        LixiInvoice invoice = t.getOrder().getInvoice();
        
        t.setIsSubmitted(EnumTopUpStatus.CANCEL_BY_ADMIN.getValue()); // cancel by admin
        this.topUpService.save(t);
        
        model.put("status", invoice.getTranslatedStatus());
        model.put("statusDate", Calendar.getInstance().getTime());
        model.put("orderId", invoice.getInvoiceCode());
        
        return new ModelAndView("Administration/ajax/topup-message");
    }
    
    
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "send2VTC/{id}", method = RequestMethod.GET)
    public ModelAndView submit2VTC(Map<String, Object> model, @PathVariable Long id){
        
        TopUpMobilePhone topUp = this.topUpService.findById(id);
        
        if(topUp != null){
            
            lxAsyncMethods.processTopUpItem(topUp);
        }
        
        RedirectView r = new RedirectView("/Administration/SystemTopUp/list", true, true);
        r.setExposeModelAttributes(false);
        return new ModelAndView(r);
    }
}
