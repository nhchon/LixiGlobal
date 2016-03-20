/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.time.DateUtils;
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
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiBatch;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.form.BatchSearchForm;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.repositories.service.LixiBatchService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.ScalarFunctionService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping(value = "/Administration/SystemBatch")
public class SystemBatchController {
    
    private static final Logger log = LogManager.getLogger(SystemBatchController.class);
    
    private final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    
    private static final String BATCH_LATEST_STATUS = "Latest";
    private static final String BATCH_WEEKLY_STATUS = "Weekly";
    private static final String BATCH_MONTHLY_STATUS = "Monthly";
    private static final String BATCH_OTHER_STATUS = "Other";
    
    @Autowired
    private LixiBatchService batchService;
    
    @Autowired
    private LixiOrderService lxOrderService;
    
    @Autowired
    private ScalarFunctionService scalaService;
    
    /**
     * 
     * @param model
     * @param id
     * @return 
     */
    @RequestMapping(value = "view/{id}", method = RequestMethod.GET)
    public ModelAndView view(Map<String, Object> model, @PathVariable long id){
        
        LixiBatch batch = this.batchService.findById(id);
        
        batch.setSumVnd(this.scalaService.sumVndOfBatch(id));
        batch.setSumUsd(this.scalaService.sumUsdOfBatch(id));
        
        List<Long> ids  = new ArrayList<>();
        batch.getOrders().forEach(o -> {
            ids.add(o.getOrderId());
        });
        
        List<LixiOrder> orders = this.lxOrderService.findAll(ids);
        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        
        if(orders != null){
            
            orders.forEach(o -> {
                mOs.put(o, LiXiUtils.genMapRecGifts(o));
            });
        }
        
        model.put("mOs", mOs);
        
        model.put("batch", batch);
        
        return new ModelAndView("Administration/reports/batchDetail");
    }
    /**
     * 
     * @param model
     * @return 
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model){
        
        /* default value for search form */
        String status = BATCH_LATEST_STATUS;
        Date currDate = DateUtils.addDays(Calendar.getInstance().getTime(), 1);
        /* get Sunday */
        Calendar cal=Calendar.getInstance();
        cal.add( Calendar.DAY_OF_WEEK, -(cal.get(Calendar.DAY_OF_WEEK)-1)); 
        Date fromDate = cal.getTime();
       
        String url = "search=true&paging.page=1&paging.size=50&status="+status+"&fromDate=" + formatter.format(fromDate)+ "&toDate="+formatter.format(currDate);
        return new ModelAndView(new RedirectView("/Administration/SystemBatch/report?" + url, true, true));
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param pageable
     * @throws ParseException
     * @return 
     */
    @RequestMapping(value = "report", params = "search=true",
            method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView report(Map<String, Object> model, BatchSearchForm form, @PageableDefault(value = 50, sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) throws ParseException{
        
        Date fromDate = null;
        Date toDate = null;
        Calendar cal= null;
        
        switch(form.getStatus()){
            case BATCH_LATEST_STATUS:
                toDate = DateUtils.addDays(Calendar.getInstance().getTime(), 1);
                /* get Sunday */
                cal=Calendar.getInstance();
                cal.add( Calendar.DAY_OF_WEEK, -(cal.get(Calendar.DAY_OF_WEEK)-1)); 
                fromDate = cal.getTime();
                break;
                
            case BATCH_WEEKLY_STATUS:
                cal = Calendar.getInstance();
                cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                // previous sunday
                cal.add(Calendar.DATE, -7);
                fromDate = cal.getTime();
                // to saturday
                cal.add(Calendar.DATE, 6);
                toDate = cal.getTime();
                break;
                
            case BATCH_MONTHLY_STATUS:
                cal = Calendar.getInstance();   // this takes current date
                //toDate
                toDate = cal.getTime();
                //first day of month
                cal.set(Calendar.DAY_OF_MONTH, 1);
                fromDate = cal.getTime();
                break;
            case BATCH_OTHER_STATUS:
                fromDate = formatter.parse(form.getFromDate());
                toDate = formatter.parse(form.getToDate());
        }
        
        Page<LixiBatch> pBs = this.batchService.findByCreatedDate(fromDate, toDate, pageable);
        
        pBs.getContent().forEach(b ->{
            b.setSumVnd(this.scalaService.sumVndOfBatch(b.getId()));
            b.setSumUsd(this.scalaService.sumUsdOfBatch(b.getId()));
        });
        
        model.put("searchForm", form);
        model.put("results", pBs);
        
        return new ModelAndView("Administration/reports/batches");
    }
}
