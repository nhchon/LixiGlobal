/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.repositories.service.PaymentService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
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
    
        List<TopUpMobilePhone> topUps = this.topUpService.findByStatus(EnumLixiOrderStatus.TopUpStatus.UN_SUBMITTED.getValue());
        
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
        
        t.setStatus(EnumLixiOrderStatus.CANCELED.getValue()); // cancel by admin
        this.topUpService.save(t);
        
        model.put("status", invoice.getTranslatedStatus());
        model.put("statusDate", Calendar.getInstance().getTime());
        model.put("orderId", invoice.getInvoiceCode());
        
        return new ModelAndView("Administration/ajax/topup-message");
    }
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model){
    
        return new ModelAndView("Administration/reports/topUpReport");
    }
    
    /**
     * 
     * @param model
     * @param page
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.POST)
    public ModelAndView report(Map<String, Object> model, @PageableDefault(value = 50, sort = "id", direction = Sort.Direction.DESC) Pageable page, HttpServletRequest request){
    
        String statusStr = request.getParameter("status");
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        
        Integer status = 0;
        Date fromDate = null;
        Date toDate = null;
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try {
            status = Integer.valueOf(statusStr);
            
            if(!StringUtils.isEmpty(fromDateStr)){
                fromDate = df.parse(fromDateStr);
            }
            
            if(!StringUtils.isEmpty(toDateStr)){
                toDate = df.parse(toDateStr);
            }
        } catch (Exception e) {
        }
        
        Page<TopUpMobilePhone> ps = null;
        if(fromDate == null && toDate == null){
            // TODO
        }
        else{
            if(fromDate == null){
                ps = this.topUpService.findByStatusAndEndDate(statusStr, toDate, page);
            }
            else{
                if(toDate == null){
                    ps = this.topUpService.findByStatusAndFromDate(statusStr, fromDate, page);
                }
                else{
                    ps = this.topUpService.findByStatusAndModifiedDate(statusStr, fromDate, toDate, page);
                }
            }
        }
        
        model.put("VCB", LiXiGlobalUtils.getVCBExchangeRates());
        model.put("topUps", ps);
        model.put("status", statusStr);
        model.put("fromDate", fromDateStr);
        model.put("toDate", toDateStr);
        model.put("pagingPage", request.getParameter("paging.page"));
        model.put("pagingSize", request.getParameter("paging.size"));

        return new ModelAndView("Administration/reports/topUpReport");
    }
}
