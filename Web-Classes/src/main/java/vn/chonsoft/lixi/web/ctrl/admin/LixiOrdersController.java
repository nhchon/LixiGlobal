/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.EnumTransactionResponseCode;
import vn.chonsoft.lixi.EnumTransactionStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiBatch;
import vn.chonsoft.lixi.model.LixiBatchOrder;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.ShippingCharged;
import vn.chonsoft.lixi.model.form.LixiOrderSearchForm;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.pojo.BankExchangeRate;
import vn.chonsoft.lixi.pojo.Exrate;
import vn.chonsoft.lixi.repositories.search.Criterion;
import vn.chonsoft.lixi.repositories.search.SearchCriteria;
import vn.chonsoft.lixi.repositories.service.LixiBatchOrderService;
import vn.chonsoft.lixi.repositories.service.LixiBatchService;
import vn.chonsoft.lixi.repositories.service.LixiConfigService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiInvoiceService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderSearchService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.PaymentService;
import vn.chonsoft.lixi.repositories.service.ShippingChargedService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
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
    private LixiAsyncMethods lxAsyncMethods;

    @Autowired
    private LixiBatchService batchService;

    @Autowired
    private LixiBatchOrderService batchOrderService;

    @Autowired
    private LixiConfigService configService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private LixiInvoiceService invoiceService;

    @Autowired
    private LixiExchangeRateService lxexrateService;

    @Autowired
    private ShippingChargedService shipService;
    
    /**
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "reSendOrder/{id}", method = RequestMethod.GET)
    public ModelAndView reSendOrder(Map<String, Object> model, @PathVariable Long id) {

        model.put("error", "0");

        LixiOrder order = this.lxOrderService.findById(id);

        boolean rs = true;
        if (order != null) {
            rs = lxAsyncMethods.reSubmitOrdersToBaoKimNoAsync(order);
        }

        model.put("error", rs ? "0" : "1");

        return new ModelAndView("Administration/ajax/simple-message");
    }

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "checkBaoKimStatus", method = RequestMethod.GET)
    public ModelAndView checkBaoKimStatus(Map<String, Object> model) {

        model.put("error", "1");
        if (lxAsyncMethods.checkBaoKimSystem()) {
            model.put("error", "0");
        }

        return new ModelAndView("Administration/ajax/simple-message");
    }

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "report", method = RequestMethod.GET)
    public ModelAndView report(Map<String, Object> model) {

        //model.put("mOs", null);
        //LixiOrderSearchForm searchForm = new LixiOrderSearchForm();
        /* default value for search form */
        //searchForm.setStatus("All");
        Date currDate = DateUtils.addDays(Calendar.getInstance().getTime(), 1);
        Date fromDate = DateUtils.addDays(currDate, -2);

        //searchForm.setFromDate(formatter.format(fromDate));
        //searchForm.setToDate(formatter.format(currDate));
        //model.put("searchForm", searchForm);
        //model.put("results", null);
        String url = "search=true&paging.page=1&paging.size=50&status=All&fromDate=" + formatter.format(fromDate) + "&toDate=" + formatter.format(currDate);
        return new ModelAndView(new RedirectView("/Administration/Orders/report?" + url, true, true));
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
            method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView report(Map<String, Object> model, LixiOrderSearchForm form, Pageable pageable) throws ParseException {
        Page<LixiOrder> pOrder = null;

        if (form.getOrderId() != null) {

            pOrder = this.lxOrderService.findById(form.getOrderId(), pageable);
        } else {

            SearchCriteria criteria = SearchCriteria.Builder.create();

            /* do not get orders that in creation */
            criteria.add(new Criterion("lixiStatus", Criterion.Operator.NEQ, EnumLixiOrderStatus.UN_FINISHED.getValue()));

            /* check status */
            if (!LiXiGlobalConstants.TRANS_REPORT_STATUS_ALL.equals(form.getStatus())) {

                log.info("LixiOrdersController.report(): " + form.getStatus());

                criteria.add(new Criterion("lixiStatus", Criterion.Operator.EQ, form.getStatus()));
            }

            /* created Date */
            if (StringUtils.isNotEmpty(form.getFromDate())) {
                criteria.add(new Criterion("createdDate", Criterion.Operator.GTE, new Date(
                        this.formatter.parse(form.getFromDate()).getTime()
                )));
            }

            if (StringUtils.isNotEmpty(form.getToDate())) {
                criteria.add(new Criterion("createdDate", Criterion.Operator.LTE, new Date(
                        DateUtils.addDays(this.formatter.parse(form.getToDate()), 1).getTime()
                )));
            }

            //if(!StringUtils.isEmpty(form.getFirstName())){
            //criteria.add(new Criterion("sender.firstName", Criterion.Operator.LIKE, form.getFirstName()));
            //}
            pOrder = this.lxOrderSearchService.search(criteria, pageable);
        }
        model.put("searchForm", form);
        model.put("results", pOrder);

        List<LixiOrder> orders = null;
        if (pOrder.getContent() != null) {
            // new list
            orders = new ArrayList<>(pOrder.getContent());

            Iterator<LixiOrder> iterator = orders.iterator();

            while (iterator.hasNext()) {
                LixiOrder o = iterator.next();
                if (o.getGifts() == null || o.getGifts().isEmpty()) {
                    /* remove the order has no gift. We don't need sent to baokim */
                    iterator.remove();
                }
            }
        }

        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        List<ShippingCharged> charged = this.shipService.findAll();
        
        if (orders != null) {
            orders.forEach(o -> {
                
                List<RecipientInOrder> recInOrder = LiXiUtils.genMapRecGifts(o);
                recInOrder.forEach(r -> {r.setCharged(charged);});
                
                mOs.put(o, recInOrder);
            });
        }

        model.put("mOs", mOs);
        //model.put("pOrder", pOrder);

        return new ModelAndView("Administration/reports/transactions");
    }

    /**
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model, @PathVariable Long id) {

        LixiOrder order = this.lxOrderService.findById(id);
        /* back to list */
        if (order == null) {
            return new ModelAndView(new RedirectView("/Administration/Orders/newOrders/" + EnumLixiOrderStatus.PROCESSED.getValue(), true, true));
        }

        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
        List<ShippingCharged> charged = this.shipService.findAll();
        
        recGifts.forEach(r -> {
            r.setCharged(charged);
        });
        
        model.put("order", order);
        model.put("recGifts", recGifts);

        return new ModelAndView("Administration/orders/orderDetail");
    }

    /**
     *
     * @param model
     * @param oStatus
     * @param page
     * @return
     */
    @RequestMapping(value = "newOrders", method = RequestMethod.GET)
    public ModelAndView listNewOrders(Map<String, Object> model, @RequestParam String oStatus, @PageableDefault(value = 50, sort = {"lixiStatus", "id"}, direction = Sort.Direction.DESC) Pageable page) {

        Page<LixiOrder> pOrder = this.lxOrderService.findByLixiStatus(EnumLixiOrderStatus.PROCESSED.getValue(), oStatus, page);

        List<LixiOrder> orders = null;
        if (pOrder.getContent() != null) {
            // new list
            orders = new ArrayList<>(pOrder.getContent());

            Iterator<LixiOrder> iterator = orders.iterator();

            while (iterator.hasNext()) {
                LixiOrder o = iterator.next();
                if (o.getGifts() == null || o.getGifts().isEmpty()) {
                    /* remove the order has no gift. We don't need sent to baokim */
                    iterator.remove();
                }
            }
        }

        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        List<ShippingCharged> charged = this.shipService.findAll();
        
        if (orders != null) {

            orders.forEach(o -> {
                
                List<RecipientInOrder> recInOrder = LiXiUtils.genMapRecGifts(o);
                recInOrder.forEach(r -> {r.setCharged(charged);});
                
                mOs.put(o, recInOrder);
            });
        }

        model.put("oStatus", oStatus);
        model.put("mOs", mOs);
        model.put("pOrder", pOrder);

        return new ModelAndView("Administration/orders/newOrderInfo");
    }

    /**
     *
     * @param model
     * @param oStatus
     * @return
     */
    @RequestMapping(value = "newOrders/ajax/{oStatus}", method = RequestMethod.GET)
    public ModelAndView getListNewOrders_beremoved(Map<String, Object> model, @PathVariable String oStatus) {

        List<LixiOrder> orders = this.lxOrderService.findByLixiStatus(EnumLixiOrderStatus.PROCESSED.getValue(), oStatus);

        if (orders != null) {
            Iterator<LixiOrder> iterator = orders.iterator();

            while (iterator.hasNext()) {
                LixiOrder o = iterator.next();
                if (o.getGifts() == null || o.getGifts().isEmpty()) {
                    /* remove the order has no gift. We don't need sent to baokim */
                    iterator.remove();
                }
            }
        }

        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();

        if (orders != null) {

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
    @PreAuthorize("hasAuthority('NEW_ORDER_INFO/SEND_MONEY')")
    @RequestMapping(value = "sendMoneyInfo", method = RequestMethod.GET)
    public ModelAndView sendMoneyInfo(Map<String, Object> model) {

        List<LixiOrder> orders = this.lxOrderService.findByLixiStatus(EnumLixiOrderStatus.PROCESSED.getValue(), EnumLixiOrderStatus.GiftStatus.SENT_INFO.getValue());

        if (orders != null) {
            Iterator<LixiOrder> iterator = orders.iterator();

            while (iterator.hasNext()) {
                LixiOrder o = iterator.next();
                if (o.getGifts() == null || o.getGifts().isEmpty()) {
                    /* remove the order has no gift. We don't need sent to baokim */
                    iterator.remove();
                }
            }
        }

        Map<LixiOrder, List<RecipientInOrder>> mOs = new LinkedHashMap<>();
        List<ShippingCharged> charged = this.shipService.findAll();
        double baoKimTransferPercent = LiXiUtils.getBaoKimPercent(this.configService.findByName("LIXI_BAOKIM_TRANFER_PERCENT").getValue());
        if (orders != null) {

            orders.forEach(o -> {
                
                List<RecipientInOrder> recInOrder = LiXiUtils.genMapRecGifts(o, baoKimTransferPercent);
                recInOrder.forEach(r -> {r.setCharged(charged);});
                
                mOs.put(o, recInOrder);
            });
        }

        model.put("mOs", mOs);

        return new ModelAndView("Administration/orders/sendMoneyInfo");
    }

    /**
     * 
     * @return 
     */
    private LixiBatch createBatch(int numOfOrder) {
        
        // get current VCB exchange rate
        double vcbCurrentBuyUsd = 0;
        SimpleDateFormat aFormatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String vcbTime = "";
        BankExchangeRate vcbEx = LiXiGlobalUtils.getVCBExchangeRates();
        Exrate usdEx = null;
        if(vcbEx != null){
            // get usd
            if(vcbEx.getExrates() != null && !vcbEx.getExrates().isEmpty()){
            
                for(Exrate ex : vcbEx.getExrates()){
                    if(LiXiGlobalConstants.USD.equalsIgnoreCase(ex.getCode())){
                        usdEx = ex;
                        break;
                    }
                }
            }
        }
        /**/
        if(usdEx != null){
            vcbCurrentBuyUsd = usdEx.getBuy();
            vcbTime = vcbEx.getTime();
        }
        else{
            LixiExchangeRate lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            vcbCurrentBuyUsd = lxExch.getBuy();
            vcbTime = aFormatter.format(lxExch.getCreatedDate());
        }
        
        // current date
        Date currDate = Calendar.getInstance().getTime();
        SimpleDateFormat format = new SimpleDateFormat("MMddyyyy HH:mm a");

        LixiBatch batch = new LixiBatch();
        batch.setName(format.format(currDate));
        batch.setNumOfOrder(numOfOrder);
        batch.setCreatedDate(currDate);
        batch.setVcbBuyUsd(vcbCurrentBuyUsd);
        batch.setVcbTime(vcbTime);
        batch.setCreatedBy(SecurityContextHolder.getContext().getAuthentication().getName());

        batch = this.batchService.save(batch);

        log.info("batch id: " + batch.getId());

        return batch;
    }

    /**
     *
     * @return
     */
    private double getBaoKimPercent() {

        double percent = LiXiGlobalConstants.LIXI_BAOKIM_DEFAULT_PERCENT;
        try {
            percent = Double.parseDouble(this.configService.findByName("LIXI_BAOKIM_TRANFER_PERCENT").getValue());
        } catch (Exception e) {
        }

        return percent;
    }

    /**
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "sendMoneyInfo/{id}", method = RequestMethod.GET)
    public ModelAndView sendMoneyInfo(Map<String, Object> model, @PathVariable Long id) {

        return sendMoneyInfos(model, new Long[]{id});
    }

    /**
     *
     * @param model
     * @param orderIds
     * @return
     */
    @RequestMapping(value = "sendMoneyInfo", method = RequestMethod.POST)
    public ModelAndView sendMoneyInfos(Map<String, Object> model, @RequestParam(value = "oIds") Long[] orderIds) {

        if (orderIds != null && orderIds.length > 0) {

            List<LixiOrder> orders = this.lxOrderService.findAll(Arrays.asList(orderIds));
            LixiBatch batch = createBatch(orders.size());

            double percent = getBaoKimPercent();
            double batchMargin = 0;
            double batchVndShip = 0;
            double batchUsdShip = 0;
            double senderPaid = 0;
            double costOfGood = 0;
            
            for (LixiOrder order : orders) {
                // send to bao kim
                boolean rs = lxAsyncMethods.sendPaymentInfoToBaoKim(order);
                if (rs) {
                    /* lưu id */
                    LixiBatchOrder bo = new LixiBatchOrder();
                    bo.setBatch(batch);
                    bo.setOrderId(order.getId());

                    SumVndUsd sum = order.getSentToBaoKim(percent);
                    
                    batchMargin += order.getGiftMargin(percent);
                    
                    LixiInvoice inv = order.getInvoice();
                    batchVndShip += inv.getVndShip(); // USD
                    batchUsdShip += inv.getUsdShip(); // USD
                    senderPaid += inv.getTotalAmount(); // USD
                    costOfGood += inv.getGiftPrice();
                    
                    bo.setVndOnlyGift(sum.getVnd());
                    bo.setUsdOnlyGift(sum.getUsd());

                    this.batchOrderService.save(bo);
                }
            }
            
            /* update batch */
            batch.setVndMargin(batchMargin);
            batch.setVndShip(batchVndShip);
            batch.setUsdShip(batchUsdShip);
            batch.setSenderPaid(senderPaid);
            batch.setCostOfGood(costOfGood);
            
            this.batchService.save(batch);
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
    public ModelAndView submitOrdersToBaoKim(Map<String, Object> model, @PathVariable Long id) {

        LixiOrder order = this.lxOrderService.findById(id);

        if (order != null) {
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
    public ModelAndView cancelOrdersOnBaoKim(Map<String, Object> model, @PathVariable Long id, @PathVariable String back) {

        LixiOrder order = this.lxOrderService.findById(id);

        if (order != null) {
            boolean c = lxAsyncMethods.cancelOrdersOnBaoKimNoAsync(order);
            if (c) {
                LixiInvoice invoice = order.getInvoice();

                log.info("status before update: " + invoice.getNetTransStatus() + " - " + invoice.getTranslatedStatus());

                this.paymentService.updateInvoiceStatus(invoice);

                log.info("status after update: " + invoice.getNetTransStatus() + " - " + invoice.getTranslatedStatus());

                if (LiXiGlobalConstants.TRANS_STATUS_IN_PROGRESS.equals(invoice.getTranslatedStatus())) {

                    String rs = this.paymentService.voidTransaction(invoice);
                    if (EnumTransactionResponseCode.APPROVED.getValue().equals(rs)) {

                        /* update order status */
                        order.setLixiStatus(EnumLixiOrderStatus.CANCELED.getValue());
                        order.setLixiMessage("Cancelled by Admin");
                        this.lxOrderService.save(order);

                        /* invoice status */
                        invoice.setNetTransStatus(EnumTransactionStatus.voidedByUser.getValue());
                        this.invoiceService.save(invoice);
                    }
                }
            }
        }

        switch (back) {
            case "info":
                return new ModelAndView(new RedirectView("/Administration/Orders/newOrders?oStatus=" + EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue(), true, true));
            case "report":
                return new ModelAndView(new RedirectView("/Administration/Orders/report", true, true));
            case "monitor":
                return new ModelAndView(new RedirectView("/Administration/TransactionMonitor/report", true, true));
            default:
                return new ModelAndView(new RedirectView("/Administration/Orders/sendMoneyInfo", true, true));
        }
    }

}
