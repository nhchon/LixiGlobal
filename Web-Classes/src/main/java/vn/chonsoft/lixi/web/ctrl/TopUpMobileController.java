/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.repositories.service.BuyCardService;
import vn.chonsoft.lixi.repositories.service.CountryService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiGlobalFeeService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.TopUpMobilePhoneService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VtcServiceCodeService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("topUp")
public class TopUpMobileController {

    private static final Logger log = LogManager.getLogger(TopUpMobileController.class);

    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Inject
    private UserService userService;

    @Inject
    private RecipientService reciService;

    @Inject
    private LixiOrderService lxorderService;

    @Inject
    private LixiExchangeRateService lxexrateService;

    @Inject
    private LixiCategoryService lxcService;

    @Inject
    private VtcServiceCodeService vtcServiceCodeService;

    @Inject
    private TopUpMobilePhoneService topUpService;

    @Inject
    private BuyCardService buyPhoneCardService;

    @Autowired
    private LixiGlobalFeeService feeService;

    @Autowired
    private CountryService countryService;
    
    /**
     *
     * @param model
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView show(Map<String, Object> model, HttpServletRequest request) {

        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        if(u!=null && u.getRecipients() != null){
            //remove inactive
            u.getRecipients().removeIf(r -> r.isActivated()==false);
            //sort by name
            Collections.sort(u.getRecipients(), new Comparator<Recipient>() {
		@Override
		public int compare(Recipient r1, Recipient r2) {
			return r1.getFullName().compareTo(r2.getFullName());
		}
            });
            //
            model.put(LiXiConstants.RECIPIENTS, u.getRecipients());
        }
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }

        LixiExchangeRate lxExch = null;
        //double buy = lxExch.getBuy();
        if (order != null) {
            // get buy from order
            lxExch = order.getLxExchangeRate();
        } else {
            // get latest from database
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        }
        /* 0 for selected top up category */
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, 0);
        
        /* get recipient */
        //Recipient rec = this.reciService.findById(recId);
        //model.put(LiXiConstants.SELECTED_RECIPIENT, this.reciService.findById(recId));
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        //model.put(LiXiConstants.PHONE_COMPANIES, this.vtcServiceCodeService.findAll());
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        //
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());

        return new ModelAndView("topup2/topup", model);
    }

    /**
     *
     * @param model
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "topUpMobilePhone", method = RequestMethod.POST)
    public ModelAndView topUpMobilePhone(Map<String, Object> model, HttpServletRequest request) {

        String amountTopUpStr = request.getParameter("amountTopUp");
        String topUpAction = request.getParameter("topUpAction");
        String topUpIdStr = request.getParameter("topUpId");
        
        Integer amountTopUp = 0;
        Long topUpId = 0L;
        try {
            amountTopUp = Integer.parseInt(amountTopUpStr);
            if(!StringUtils.isEmpty(topUpIdStr)){
                topUpId = Long.parseLong(topUpIdStr);
            }
        } catch (Exception ex) {
        };

        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        double userMoneyLevelAmount = u.getUserMoneyLevel().getMoneyLevel().getAmount();

        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }

        LixiExchangeRate lxExch = null;
        double buy = 0;
        if (order != null) {
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        } else {
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }
        
        double amountUsd = LiXiUtils.toUsdPrice(amountTopUp, buy);

        boolean exceed = checkExceed(model, order, userMoneyLevelAmount, amountUsd, buy, topUpId);
        // order is exceed
        if (exceed) {

            model.put("topUpExceed", 1);
            model.put(LiXiConstants.TOP_UP_AMOUNT, amountTopUp);

            return show(model, request);
        } else {

            if (order == null) {

                order = createOrder(u, lxExch);
                //
                request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
            }
            /* get recipient */
            Recipient rec = this.reciService.findById(Long.parseLong(request.getParameter("recId")));
            String recPhone = rec.getPhone();
            if(!recPhone.startsWith("0")){
                recPhone = ("0" + recPhone);
            }
            TopUpMobilePhone topUp = new TopUpMobilePhone();
            topUp.setId(topUpId);
            topUp.setAmount(amountTopUp);
            topUp.setAmountUsd(amountUsd);
            topUp.setPhone(recPhone);
            topUp.setStatus(EnumLixiOrderStatus.UN_FINISHED.getValue());// not yet submit
            topUp.setOrder(order);
            topUp.setRecipient(rec);
            //
            Date currentDate = Calendar.getInstance().getTime();
            topUp.setCreatedDate(currentDate);
            topUp.setModifiedDate(currentDate);

            // save
            this.topUpService.save(topUp);
        }

        if (LiXiConstants.BUY_NOW_ACTION.equals(topUpAction)) {
            // reivew order
            return new ModelAndView(new RedirectView("/gifts/order-summary", true, true));
        } else {
            // keep shopping
            model.put("addSuccess", 1);
            return show(model, request);
        }
    }

    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "change/{id}", method = RequestMethod.GET)
    public ModelAndView change(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request){
        
        TopUpMobilePhone topUp = this.topUpService.findById(id);
        
        /* set recipient */
        request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_ID, topUp.getRecipient().getId());
        
        model.put("topUpId", id);
        model.put("amountTopUp", topUp.getAmount());
        
        return show(model, request);
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param amount
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = {"update/{id}/{amount}", "ajax/update/{id}/{amount}"}, method = RequestMethod.GET)
    public ModelAndView update(Map<String, Object> model, @PathVariable Long id, @PathVariable Integer amount, HttpServletRequest request){
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());

        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        LixiOrder order = null;
        // check order already created
        if (orderId != null) {

            order = this.lxorderService.findById(orderId);

        }
        
        TopUpMobilePhone t = this.topUpService.findById(id);
        Long recId = t.getRecipient().getId();
        
        // check current payment <==> maximum payment
        double buy = 0;
        if (order != null) {
            // get buy from order
            buy = order.getLxExchangeRate().getBuy();
        } else {
            // get current exchange rate
            buy = this.lxexrateService.findLastRecord(LiXiConstants.USD).getBuy();
        }

        double amountUsd = LiXiUtils.toUsdPrice(amount, buy);// amount is in VND
        
        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order, id, LiXiConstants.LIXI_TOP_UP_TYPE); // [VND, USD]
        double currentPayment = currentPayments[0].getUsd();//USD
        double currPaymentVnd = currentPayments[0].getVnd();
        currentPayment += amountUsd;

        if (currentPayment > (u.getUserMoneyLevel().getMoneyLevel().getAmount())) {

            // maximum payment is over
            model.put("exceed", 1);

            double exceededPaymentVND = (currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount()) * buy;
            double exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();

            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));

            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));

        } else {
            // the order is not exceeded
            model.put("exceed", 0);
            
            // update topup
            t.setAmount(amount);
            t.setAmountUsd(amountUsd);
            
            this.topUpService.save(t);
            
        }
        
        model.put(LiXiConstants.SELECTED_RECIPIENT_ID, recId);
        
        /* re-calculate recipient's total */
        RecipientInOrder recInOrder = LiXiUtils.getRecipientInOrder(LiXiUtils.genMapRecGifts(this.lxorderService.findById(orderId)), recId);
            
        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currPaymentVnd);
        
        if(recInOrder != null){
            model.put("RECIPIENT_PAYMENT_USD", recInOrder.getAllTotal().getUsd());
            model.put("RECIPIENT_PAYMENT_VND", recInOrder.getAllTotal().getVnd());
        }
        
        // forward topup amount
        model.put(LiXiConstants.TOP_UP_AMOUNT, LiXiUtils.toUsdPrice(amount, buy));

        // topup in VND
        model.put(LiXiConstants.TOP_UP_IN_VND, amount);

        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, LiXiUtils.getNumberFormat().format(currentPayment));
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, LiXiUtils.getNumberFormat().format(currentPayment * buy));
        
        // calculate fee
        String countryCode = null;
        if(LiXiUtils.getBillingAddress(order) != null){
            countryCode = LiXiUtils.getBillingAddress(order).getCountry();
        }
        LiXiUtils.calculateFee(model, this.lxorderService.findById(orderId), this.feeService.findByCountry(
                this.countryService.findByCode(countryCode)));


        return new ModelAndView("topup2/exceedTopUp", model);
    }
    
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public ModelAndView delete(Map<String, Object> model, @PathVariable Long id, HttpServletRequest request){
        
        TopUpMobilePhone topUp = this.topUpService.findById(id);
        
        // cehck order id
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(topUp.getOrder().getId().longValue() == orderId){
            this.topUpService.deleteById(id);
        }
        
        return new ModelAndView(new RedirectView("/gifts/order-summary", true, true));
    }
    
    
    /**
     *
     * @param u
     * @param lxExch
     * @return
     */
    private LixiOrder createOrder(User u, LixiExchangeRate lxExch) {

        // create order
        LixiOrder order = new LixiOrder();
        order.setSender(u);
        order.setLxExchangeRate(lxExch);
        order.setLixiStatus(EnumLixiOrderStatus.UN_FINISHED.getValue()); // unfinished
        order.setLixiMessage(null);
        // default is allow refund
        order.setSetting(EnumLixiOrderSetting.ALLOW_REFUND.getValue());
        /* current date */
        Date currDate = Calendar.getInstance().getTime();
        order.setCreatedDate(currDate);
        order.setModifiedDate(currDate);

        // set card and billing address from last order
        LixiOrder lastOrder = this.lxorderService.findLastOrder(u);
        // last user's order
        if (lastOrder != null) {
            // use the last payment method
            order.setCard(lastOrder.getCard());
            order.setBankAccount(lastOrder.getBankAccount());
        }

        // save order
        return this.lxorderService.save(order);

        // store ID into session
        //request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
    }

    /**
     *
     * check exceed
     *
     * @param model
     * @param order
     * @param userMoneyLevel
     * @param addedAmount
     * @return
     */
    private boolean checkExceed(Map<String, Object> model, LixiOrder order, double userMoneyLevel, double addedAmount, double buy, Long topUpId) {

        // check current payment <==> maximum payment
        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order, topUpId, LiXiConstants.LIXI_TOP_UP_TYPE);
        double currentPayment = currentPayments[0].getUsd();//USD
        currentPayment += addedAmount;// in USD

        if (currentPayment > userMoneyLevel) {

            // maximum payment is over
            model.put("exceed", 1);

            double exceededPaymentVND = (currentPayment - userMoneyLevel) * buy;
            double exceededPaymentUSD = currentPayment - userMoneyLevel;

            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));

            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));

            return true;
        } else {
            // the order is not exceeded
            model.put("exceed", 0);
            return false;
        }
    }

    /**
     *
     * Check topup exceed
     *
     * @param id
     * @param model
     * @param amount
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "checkTopUpExceed/{id}/{amount}", method = RequestMethod.GET)
    public ModelAndView checkTopUpExceed(Map<String, Object> model, @PathVariable Long id, @PathVariable Integer amount, HttpServletRequest request) {

        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());

        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }

        // check current payment <==> maximum payment
        LixiExchangeRate lxExch = null;
        double buy = 0;
        if (order != null) {
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        } else {
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }

        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order, id, LiXiConstants.LIXI_TOP_UP_TYPE); // [VND, USD]
        double currentPayment = currentPayments[0].getUsd();//USD
        currentPayment += LiXiUtils.toUsdPrice(amount, buy);// amount is in USD

        if (currentPayment > (u.getUserMoneyLevel().getMoneyLevel().getAmount())) {

            // maximum payment is over
            model.put("exceed", 1);

            double exceededPaymentVND = (currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount()) * buy;
            double exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();

            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));

            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));

        } else {
            // the order is not exceeded
            model.put("exceed", 0);
        }
        // forward topup amount
        model.put(LiXiConstants.TOP_UP_AMOUNT, LiXiUtils.toUsdPrice(amount, buy));

        // topup in VND
        model.put(LiXiConstants.TOP_UP_IN_VND, amount);

        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, LiXiUtils.getNumberFormat().format(currentPayment));
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, LiXiUtils.getNumberFormat().format(currentPayment * buy));

        return new ModelAndView("topup2/exceedTopUp", model);
    }

    /**
     * 
     * @param model
     * @param numOfCard
     * @param valueOfCard
     * @param request
     * @return 
     */
    /*
    @UserSecurityAnnotation
    @RequestMapping(value = "checkBuyPhoneCardExceed/{numOfCard}/{valueOfCard}", method = RequestMethod.GET)
    public ModelAndView checkBuyPhoneCardExceed(Map<String, Object> model, @PathVariable Integer numOfCard, @PathVariable Integer valueOfCard, HttpServletRequest request) {

        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }

        // check current payment <==> maximum payment
        LixiExchangeRate lxExch = null;
        double buy = 0;
        if (order != null) {
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        } else {
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }

        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order); // [VND, USD]
        double currentPayment = currentPayments[0].getUsd();//USD
        currentPayment += (LiXiUtils.toUsdPrice(valueOfCard, buy) * numOfCard);// in USD

        if (currentPayment > (u.getUserMoneyLevel().getMoneyLevel().getAmount())) {

            // maximum payment is over
            model.put("exceed", 1);

            double exceededPaymentVND = (currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount()) * buy;
            double exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();

            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));

            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));

        } else {
            // the order is not exceeded
            model.put("exceed", 0);
        }
        // forward 
        model.put(LiXiConstants.NUM_OF_CARD, numOfCard);
        model.put(LiXiConstants.VALUE_OF_CARD, valueOfCard);

        // topup in VND
        model.put(LiXiConstants.BUY_PHONE_CARD_IN_USD, LiXiUtils.getNumberFormat().format((LiXiUtils.toUsdPrice(valueOfCard, buy) * numOfCard)));

        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, LiXiUtils.getNumberFormat().format(currentPayment));
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, LiXiUtils.getNumberFormat().format(currentPayment * buy));

        return new ModelAndView("topup2/exceedPhoneCard", model);
    }
    */
    /**
     *
     * @param model
     * @param request
     * @return
     */
    /*
    @UserSecurityAnnotation
    @RequestMapping(value = "buyPhoneCard", method = RequestMethod.POST)
    public ModelAndView buyPhoneCard(Map<String, Object> model, HttpServletRequest request) {

        String phoneCompany = request.getParameter("phoneCompany");
        String numOfCardStr = request.getParameter("numOfCard");
        String valueOfCardStr = request.getParameter("valueOfCard");
        String phoneCardAction = request.getParameter("phoneCardAction");
        Integer valueOfCard = 0;
        Integer numOfCard = 0;
        try {
            valueOfCard = Integer.parseInt(valueOfCardStr);
            numOfCard = Integer.parseInt(numOfCardStr);
        } catch (Exception e) {
        }

        //
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        double userMoneyLevelAmount = u.getUserMoneyLevel().getMoneyLevel().getAmount();

        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }

        LixiExchangeRate lxExch = null;
        double buy = 0;
        if (order != null) {
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        } else {
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }

        boolean exceed = checkExceed(model, order, userMoneyLevelAmount, (LiXiUtils.toUsdPrice(valueOfCard, buy) * numOfCard), buy, 0L);
        // order is exceed
        if (exceed) {

            model.put("phoneCardExceed", 1);

            //
            model.put("TOPUP_ACTION", "PHONE_CARD");
            return show(model, request);
        } else {

            if (order == null) {

                order = createOrder(u, lxExch);
                //
                request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
            }
            //

            BuyCard phoneCard = new BuyCard();
            phoneCard.setNumOfCard(numOfCard);
            phoneCard.setValueOfCard(valueOfCard);
            phoneCard.setVtcCode(this.vtcServiceCodeService.findByCode(phoneCompany));
            phoneCard.setOrder(order);
            phoneCard.setRecipient(this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID)));
            phoneCard.setModifiedDate(Calendar.getInstance().getTime());

            // save
            this.buyPhoneCardService.save(phoneCard);

            if (LiXiConstants.BUY_NOW_ACTION.equals(phoneCardAction)) {

                // reivew order
                return new ModelAndView(new RedirectView("/gifts/more-recipient", true, true));
            } else {
                // keep shopping
                model.put("buySuccess", 1);
                model.put("TOPUP_ACTION", "PHONE_CARD");
                return show(model, request);
            }

        }
    }
    */
}
