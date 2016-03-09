/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.form.LixiOrderSearchForm;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.search.Criterion;
import vn.chonsoft.lixi.repositories.search.SearchCriteria;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderSearchService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
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
    
    private static final Logger log = LogManager.getLogger(LixiOrdersController.class);
    
    private final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    
    @Autowired
    private LixiOrderService lxOrderService;
    
    @Autowired
    private LixiOrderSearchService lxOrderSearchService;
    
    @Autowired
    private LixiOrderGiftService lxogiftService;
    
    @Autowired
    private LixiAsyncMethods lxAsyncMethods;
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model){

        model.put("mOs", null);
        
        model.put("searchForm", new LixiOrderSearchForm());
        model.put("results", null);
        
        return new ModelAndView("Administration/reports/transactions");
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param pageable
     * @return 
     */
    @RequestMapping(value = "report", params = "search=true",
            method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView report(Map<String, Object> model, LixiOrderSearchForm form, Pageable pageable) throws ParseException
    {
        SearchCriteria criteria = SearchCriteria.Builder.create();
        
        /* convert status */
        String status = "";
        if(StringUtils.isNotEmpty(form.getStatus())){
            
            /* send money*/
            if(LiXiGlobalConstants.TRANS_REPORT_STATUS_PROCESSED.equals(form.getStatus())){
                status = EnumLixiOrderStatus.PROCESSED.getValue();
            }
            else
                if(LiXiGlobalConstants.TRANS_REPORT_STATUS_COMPLETED.equals(form.getStatus())){
                    status = EnumLixiOrderStatus.COMPLETED.getValue();
                }
                else
                if(LiXiGlobalConstants.TRANS_REPORT_STATUS_CANCELLED.equals(form.getStatus())){
                    status = EnumLixiOrderStatus.CANCELED.getValue();
                }
        }
        
        /* do not get orders that in creation */
        criteria.add(new Criterion("lixiStatus", Criterion.Operator.NEQ, EnumLixiOrderStatus.UN_FINISHED.getValue()));
        
        /* check status */
        if(StringUtils.isNotEmpty(status)){
            
            log.info("vn.chonsoft.lixi.web.ctrl.admin.LixiOrdersController.report(): " + status);
            
            criteria.add(new Criterion("lixiStatus", Criterion.Operator.EQ, status));
        }
        
        /* created Date */
        if(StringUtils.isNotEmpty(form.getFromDate())){
            criteria.add(new Criterion("createdDate", Criterion.Operator.GTE, new Date(
                    this.formatter.parse(form.getFromDate()).getTime()
            )));
        }
        
        
        if(StringUtils.isNotEmpty(form.getToDate())){
            criteria.add(new Criterion("createdDate", Criterion.Operator.LTE, new Date(
                    DateUtils.addDays(this.formatter.parse(form.getToDate()), 1).getTime()
            )));
        }
        
        //if(!StringUtils.isEmpty(form.getFirstName())){
            //criteria.add(new Criterion("sender.firstName", Criterion.Operator.LIKE, form.getFirstName()));
        //}
        
        Page<LixiOrder> pOrder = this.lxOrderSearchService.search(criteria, pageable);
        
        model.put("searchForm", form);
        model.put("results", pOrder);
        
        List<LixiOrder> orders = pOrder.getContent();
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
        
        return new ModelAndView("Administration/reports/transactions");
    }    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model, @PathVariable Long id){
        
        LixiOrder order = this.lxOrderService.findById(id);
        /* back to list */
        if(order == null){
            return new ModelAndView(new RedirectView("/Administration/Orders/newOrders/" + EnumLixiOrderStatus.PROCESSED.getValue(), true, true));
        }
        
        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
        
        model.put("order", order);
        model.put("recGifts", recGifts);
        
        return new ModelAndView("Administration/orders/orderDetail");
    }
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "newOrders", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model){
        
        return new ModelAndView(new RedirectView("/Administration/Orders/newOrders/" + EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue(), true, true));
    }
    
    /**
     * 
     * @param model
     * @param oStatus
     * @return 
     */
    @RequestMapping(value = "newOrders/{oStatus}", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model, @PathVariable String oStatus){
        
        /*
        List<LixiOrder> orders = this.lxOrderService.findByLixiStatus(oStatus);
        
        if(orders != null){
            Iterator<LixiOrder> iterator = orders.iterator();
            
            while(iterator.hasNext()){
                LixiOrder o = iterator.next();
                if(o.getGifts() == null || o.getGifts().isEmpty()){
                    //remove the order has no gift. We don't need sent to baokim
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
        */
        return new ModelAndView("Administration/orders/newOrderInfo");
    }
    
    /**
     * 
     * @param model
     * @param oStatus
     * @return 
     */
    @RequestMapping(value = "newOrders/ajax/{oStatus}", method = RequestMethod.GET)
    public ModelAndView getListNewOrders(Map<String, Object> model, @PathVariable String oStatus){
        
        List<LixiOrder> orders = this.lxOrderService.findByLixiStatus(EnumLixiOrderStatus.PROCESSED.getValue(), oStatus);
        
        if(orders != null){
            Iterator<LixiOrder> iterator = orders.iterator();
            
            while(iterator.hasNext()){
                LixiOrder o = iterator.next();
                if( o.getGifts() == null || o.getGifts().isEmpty()){
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
        
        return new ModelAndView("Administration/orders/newOrderInfoAjax");
    }
    
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "sendMoneyInfo", method = RequestMethod.GET)
    public ModelAndView sendMoneyInfo(Map<String, Object> model){
        
        List<LixiOrder> orders = this.lxOrderService.findByLixiSubStatus(EnumLixiOrderStatus.GiftStatus.SENT_INFO.getValue());
        
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
        
        return new ModelAndView("Administration/orders/sendMoneyInfo");
    }
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "sendMoneyInfo/{id}", method = RequestMethod.GET)
    public ModelAndView sendMoneyInfo(Map<String, Object> model, @PathVariable Long id){
        
        LixiOrder order = this.lxOrderService.findById(id);
        
        if(order != null){
            lxAsyncMethods.sendPaymentInfoToBaoKim(order);
        }
        
        return new ModelAndView(new RedirectView("/Administration/Orders/sendMoneyInfo", true, true));
    }
    
    /**
     * 
     * @param model
     * @param orderIds
     * @return 
     */
    @RequestMapping(value = "sendMoneyInfo", method = RequestMethod.POST)
    public ModelAndView sendMoneyInfos(Map<String, Object> model, @RequestParam(value="oIds") Long[] orderIds){
        
        if(orderIds != null && orderIds.length > 0){
            
            List<LixiOrder> orders = this.lxOrderService.findAll(Arrays.asList(orderIds));
            for(LixiOrder order : orders){
                // send to bao kim
                lxAsyncMethods.sendPaymentInfoToBaoKim(order);
            }
        }
        //
        return new ModelAndView(new RedirectView("/Administration/Orders/sendMoneyInfo", true, true));
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
     * @param id
     * @param back
     * @return 
     */
    @RequestMapping(value = "cancel/{id}/{back}", method = RequestMethod.GET)
    public ModelAndView cancelOrdersOnBaoKim(Map<String, Object> model, @PathVariable Long id, @PathVariable String back){
        
        LixiOrder order = this.lxOrderService.findById(id);
        
        if(order != null){
            lxAsyncMethods.cancelOrdersOnBaoKimNoAsync(order);
        }
        
        switch(back){
            case "info":
                return new ModelAndView(new RedirectView("/Administration/Orders/newOrders/" + EnumLixiOrderStatus.PROCESSED.getValue(), true, true));
            case "report":
                return new ModelAndView(new RedirectView("/Administration/Orders/report", true, true));
            default:
                return new ModelAndView(new RedirectView("/Administration/Orders/sendMoneyInfo", true, true));
        }
    }
    
    
}
