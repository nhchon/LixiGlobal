/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;
import vn.chonsoft.lixi.web.util.LiXiVatGiaUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("gifts")
public class GiftsController {

    private static final Logger log = LogManager.getLogger(GiftsController.class);

    @Inject
    UserService userService;

    @Inject
    RecipientService reciService;

    @Inject
    CurrencyTypeService currencyService;

    @Inject
    LixiExchangeRateService lxexrateService;

    @Inject
    LixiCategoryService lxcService;

    @Inject
    LixiOrderService lxorderService;

    @Inject
    LixiOrderGiftService lxogiftService;

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "recipient", method = RequestMethod.GET)
    public ModelAndView recipient(HttpServletRequest request) {

        Map<String, Object> model = new HashMap<>();

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);

        }

        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);

        // select recipients of user
        User u = this.userService.findByEmail(email);
        if (u != null) {

            model.put("RECIPIENTS", u.getRecipients());
        }

        model.put("chooseRecipientForm", new ChooseRecipientForm());

        return new ModelAndView("giftprocess/recipient", model);

    }

    /**
     *
     * @param model
     * @param email
     */
    private void setRecipients(Map<String, Object> model, String email) {

        User u = this.userService.findByEmail(email);
        if (u != null) {

            model.put("RECIPIENTS", u.getRecipients());
        }

    }

    /**
     *
     * @param model
     * @param u
     */
    private void setRecipients(Map<String, Object> model, User u) {

        if (u != null) {

            model.put("RECIPIENTS", u.getRecipients());
        }

    }

    /**
     *
     * @param recId
     * @param request
     * @return
     */
    @RequestMapping(value = "chooseRecipient/{recId}", method = RequestMethod.GET)
    public ModelAndView chooseRecipient(@PathVariable Long recId, HttpServletRequest request) {

        Map<String, Object> model = new HashMap<>();

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);

        }

        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);

        // select recipients of user
        setRecipients(model, email);

        Recipient reci = this.reciService.findById(recId);
        if (reci == null) {
            // wrong recId
            model.put("chooseRecipientForm", new ChooseRecipientForm());
        } else {

            ChooseRecipientForm form = new ChooseRecipientForm();
            form.setRecId(recId);
            form.setFirstName(reci.getFirstName());
            form.setMiddleName(reci.getMiddleName());
            form.setLastName(reci.getLastName());
            form.setEmail(reci.getEmail());
            form.setPhone(reci.getPhone());
            form.setNote(reci.getNote());

            model.put("chooseRecipientForm", form);
        }
        //
        return new ModelAndView("giftprocess/recipient", model);
    }

    /**
     *
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return
     */
    @RequestMapping(value = {"recipient", "chooseRecipient/{recId}"}, method = RequestMethod.POST)
    public ModelAndView chooseRecipient(Map<String, Object> model,
            @Valid ChooseRecipientForm form, Errors errors, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            model.put("signInFailed", 1);
            return new ModelAndView(new RedirectView("/user/signIn", true, true), model);

        }
        //
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        // select recipients of user
        setRecipients(model, u);

        if (errors.hasErrors()) {

            return new ModelAndView("giftprocess/recipient");
        }

        try {

            // save new recipient
            Recipient rec = new Recipient();
            rec.setId(form.getRecId());
            rec.setSender(u);
            rec.setFirstName(LiXiUtils.fixEncode(form.getFirstName()));
            rec.setMiddleName(LiXiUtils.fixEncode(form.getMiddleName()));
            rec.setLastName(LiXiUtils.fixEncode(form.getLastName()));
            rec.setEmail(form.getEmail());
            rec.setPhone(form.getPhone());
            rec.setNote(LiXiUtils.fixEncode(form.getNote()));// note
            rec.setModifiedDate(Calendar.getInstance().getTime());

            rec = this.reciService.save(rec);

            // store selected recipient into session
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_ID, rec.getId());
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_NAME, form.getFirstName() + " " + StringUtils.defaultIfEmpty(form.getMiddleName(), "") + " " + form.getLastName());

            // jump to page Value Of Gift
            return new ModelAndView(new RedirectView("/gifts/value", true, true));

        } catch (ConstraintViolationException e) {

            log.info(e.getMessage(), e);

            model.put("validationErrors", e.getConstraintViolations());

            return new ModelAndView("giftprocess/recipient", model);

        }

    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "value", method = RequestMethod.GET)
    public ModelAndView value(HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        //
        if (request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID) == null) {

            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        } else {

            Map<String, Object> model = new HashMap<>();

            // currencies
            model.put(LiXiConstants.CURRENCIES, this.currencyService.findAll());

            // lastest exchange rates
            LixiExchangeRate lxexrate = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxexrate);

            // store lixi exhange rate id into session
            request.getSession().setAttribute(LiXiConstants.LIXI_EXCHANGE_RATE, lxexrate.getId());

            // jump
            return new ModelAndView("giftprocess/value-of-gift", model);
        }
    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "value", method = RequestMethod.POST)
    public ModelAndView saveValue(HttpServletRequest request) {

        String amountCurrencyCode = request.getParameter("amountCurrency");
        String amount = request.getParameter("amount");
        String exchangeRate = request.getParameter("exchangeRate");
        String giftInCurrencyCode = request.getParameter("giftInCurrencyValue");
        String giftInValue = request.getParameter("giftInValue");

        try {
            // store amount and curreny into session for back button
            request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT, amount);
            request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_CURRENCY, amountCurrencyCode);
            // store amount in vnd
            request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND, LiXiUtils.getNumberFormat().parse(LiXiUtils.getAmountInVnd(amountCurrencyCode, amount, giftInValue)).floatValue());
        } catch (Exception e) {

            log.info("parse amount is error:", e);
        }
        // jump to type of gift
        return new ModelAndView(new RedirectView("/gifts/type", true, true));

    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "type", method = RequestMethod.GET)
    public ModelAndView typeOfGift(HttpServletRequest request) {

        //log.info(LocaleContextHolder.getLocale());
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        List<LixiCategory> categories = this.lxcService.findByLocaleCode(LocaleContextHolder.getLocale().toString());

        log.info(categories.size());

        Map<String, Object> model = new HashMap<>();

        model.put(LiXiConstants.LIXI_CATEGORIES, categories);

        return new ModelAndView("giftprocess/type-of-gift", model);

    }

    /**
     *
     * Not In Use currently
     *
     * @param category
     * @param request
     * @return
     */
    @RequestMapping(value = "type", method = RequestMethod.POST)
    public ModelAndView typeOfGift(@RequestParam("type-of-gift") int category, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        LixiCategory lxcategory = this.lxcService.findById(category);

        if (lxcategory == null) {

            return new ModelAndView(new RedirectView("/gifts/type?wrong=1", true, true));

        }
        // get current order gift id
        Long orderGiftId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_GIFT_ID);
        log.info("orderGiftId at type POST: " + orderGiftId);
        LixiOrderGift lxogift = this.lxogiftService.findById(orderGiftId);
        lxogift.setCategory(lxcategory);
        // save category
        this.lxogiftService.save(lxogift);

        // store lixi category id into session for next and back action
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY, lxcategory.getId());

        // jump
        return new ModelAndView(new RedirectView("/gifts/choose", true, true));

    }

    /**
     *
     * @param model
     * @param category
     * @param request
     * @return
     */
    @RequestMapping(value = "choose/{category}", method = RequestMethod.GET)
    public ModelAndView chooseGift(@PathVariable Integer category, Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        // prepare for Choose the gift page
        LixiCategory lxcategory = this.lxcService.findById(category);
        // store category into session
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY, category);

        // get price, amount in VND - 100k
        float price = LiXiUtils.getBeginPrice((float) request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND));
        ListVatGiaProduct products = LiXiVatGiaUtils.getInstance().getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);

        log.info("products: " + (products == null));
        //log.info(products.getData().size());

        // get order
        LixiOrder order = null;
        LixiExchangeRate lxExch = null;
        // order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {
            
            order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
            // get exchange rate of the order;
            lxExch = order.getLxExchangeRate();
        }
        else{
            
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        }

        //Map<String, Object> model = new HashMap<>();
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.CURRENT_PAYMENT, LiXiUtils.calculateCurrentPayment(order));

        return new ModelAndView("giftprocess/choose-the-gift", model);

    }

    /**
     *
     * Save the gift is choosed
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "choose", method = RequestMethod.POST)
    public ModelAndView saveTheGift(HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        //
        Map<String, Object> model = new HashMap<>();

        String giftIdStr = request.getParameter("gift");
        String priceStr = request.getParameter("price-" + giftIdStr);
        String name = request.getParameter("name-" + giftIdStr);
        String image = request.getParameter("image-" + giftIdStr);
        String quantityStr = request.getParameter("quantity-" + giftIdStr);

        log.info(giftIdStr + " - " + priceStr);
        // parse
        int giftId = 0;
        try {
            // error number
            giftId = Integer.parseInt(giftIdStr);

        } catch (Exception e) {}

        if (giftId == 0) {

            // wrong gift id
            model.put("wrong", 1);

            return new ModelAndView("giftprocess/choose-the-gift", model);
        }

        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        // no need to check
        float price = Float.parseFloat(priceStr);
        int quantity = Integer.parseInt(quantityStr);
        LixiCategory lxCategory = this.lxcService.findById((Integer) request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY));

        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        // check current payment <==> maximum payment
        LixiExchangeRate lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        double buy = lxExch.getBuy();
        if(order != null){
            
            // get buy from order
            buy = order.getLxExchangeRate().getBuy();
            
        }
        
        float currentPayment = LiXiUtils.calculateCurrentPayment(order);
        currentPayment += ((price * quantity) / buy);

        if (currentPayment > u.getUserMoneyLevel().getMoneyLevel().getAmount()) {

            // maximum payment is over
            model.put("exceed", 1);
            model.put(LiXiConstants.LIXI_ORDER_GIFT_PRODUCT_ID, giftId);
            model.put(LiXiConstants.LIXI_ORDER_GIFT_PRODUCT_QUANTITY, quantity);
            
            float exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            float exceededPaymentVND = exceededPaymentUSD * (float)buy;
            
            log.info(exceededPaymentVND + " - " + exceededPaymentUSD);
            
            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));
            
            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));
            
            return chooseGift(lxCategory.getId(), model, request);
                //return new ModelAndView("giftprocess/choose-the-gift", model);
            //return new ModelAndView(new RedirectView("/gifts/choose?exceed=1", true, true));

        }

        // create order
        if (order == null) {
            
            order = new LixiOrder();
            order.setSender(u);
            order.setLxExchangeRate(lxExch);
            order.setLixiStatus(0);
            order.setLixiMessage(null);
            order.setModifiedDate(Calendar.getInstance().getTime());

            // save order
            order = this.lxorderService.save(order);

            // store ID into session
            request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
        }
        
        // Recipient
        Recipient rec = this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
        
        // check the gift already bought
        LixiOrderGift alreadyGift = this.lxogiftService.findByOrderAndRecipientAndProductId(order, rec, giftId);
        if(alreadyGift == null){
            // create lixi order gift
            LixiOrderGift lxogift = new LixiOrderGift();
            lxogift.setRecipient(rec);
            lxogift.setOrder(order);
            lxogift.setCategory(lxCategory);
            lxogift.setProductId(giftId);
            lxogift.setProductPrice(price);
            lxogift.setProductName(name);
            lxogift.setProductImage(image);
            lxogift.setProductQuantity(quantity);
            lxogift.setModifiedDate(Calendar.getInstance().getTime());

            this.lxogiftService.save(lxogift);

        }
        else{
            
            // update quantity
            alreadyGift.setProductQuantity(alreadyGift.getProductQuantity() + quantity);
            
            this.lxogiftService.save(alreadyGift);
        }
        // jump to more-recipient
        return new ModelAndView(new RedirectView("/gifts/more-recipient", true, true));
    }

    /**
     *
     * @param model 
     * @param request
     * @return
     */
    @RequestMapping(value = "more-recipient", method = RequestMethod.GET)
    public ModelAndView moreRecipient(Map<String, Object> model, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        // check order created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(orderId == null){
            
            // to do
            
        }
        
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        Map<Recipient, List<LixiOrderGift>> recGifts = LiXiUtils.genMapRecGifts(order);

        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.REC_GIFTS, recGifts);

        return new ModelAndView("giftprocess/more-recipient", model);
    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public ModelAndView delete(HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        // get lixi order gift id
        String giftStr = request.getParameter("gift");
        log.info("delete gift id: " + giftStr);
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        LixiOrderGift lxogift = this.lxogiftService.findByIdAndOrder(Long.parseLong(giftStr), order);

        if (lxogift != null) {

            this.lxogiftService.delete(lxogift.getId());

        } else {

            log.info("Lixi order gift is null: " + giftStr);
        }

        // jump 
        return new ModelAndView(new RedirectView("/gifts/more-recipient", true, true));
    }

    /**
     *
     * update quantity of the gift
     *
     * @param orderGiftId
     * @param quantity 
     * @param request
     * @return
     */
    @RequestMapping(value = "update/{orderGiftId}/{quantity}", method = RequestMethod.GET)
    public ModelAndView update(@PathVariable Long orderGiftId, @PathVariable Integer quantity, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) == null) {

            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));

        }

        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        LixiOrderGift lxogift = this.lxogiftService.findByIdAndOrder(orderGiftId, order);

        // if gift is null
        if (lxogift == null) {

            return new ModelAndView(new RedirectView("/gifts/more-recipient?wrong=1", true, true));
        }
        // else
        float currentPayment = LiXiUtils.calculateCurrentPayment(order);
        currentPayment += ((lxogift.getProductPrice() * (quantity - lxogift.getProductQuantity())) / order.getLxExchangeRate().getBuy());

        // maximum payment is over
        if (currentPayment > u.getUserMoneyLevel().getMoneyLevel().getAmount()) {

            Map<String, Object> model = new HashMap<>();
            
            // maximum payment is over
            model.put("exceed", 1);
            
            float exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            float exceededPaymentVND = exceededPaymentUSD * (float)order.getLxExchangeRate().getBuy();
            
            log.info(exceededPaymentVND + " - " + exceededPaymentUSD);
            
            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));
            
            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));
            
            return moreRecipient(model, request);

        }
        else{
            
            // update quantity
            lxogift.setProductQuantity(quantity);
            this.lxogiftService.save(lxogift);
        }

        // jump to choose the gift page
        return new ModelAndView(new RedirectView("/gifts/more-recipient", true, true));
    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "review", method = RequestMethod.GET)
    public ModelAndView review(HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        Map<String, Object> model = new HashMap<>();

        // lastest exchange rates: USD <-> VND
        LixiExchangeRate lxexrate = this.lxexrateService.findLastRecord(LiXiConstants.USD);

        // update latest exchange rate
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        order.setLxExchangeRate(lxexrate);
        order = this.lxorderService.save(order);

        Map<Recipient, List<LixiOrderGift>> recGifts = LiXiUtils.genMapRecGifts(order);

        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.REC_GIFTS, recGifts);

        return new ModelAndView("giftprocess/review-the-order", model);
    }

    /**
     *
     * add more gift to selected recipient
     *
     * @param recId
     * @param request
     * @return
     */
    @RequestMapping(value = "add-more/{recId}", method = RequestMethod.GET)
    public ModelAndView addMore(@PathVariable Long recId, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        // check the recipient belong to current order
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        Recipient rec = this.reciService.findById(recId);

        List<LixiOrderGift> lxogifts = this.lxogiftService.findByOrderAndRecipient(order, rec);
        if (lxogifts == null || lxogifts.isEmpty()) {

            // error
            return new ModelAndView(new RedirectView("/gifts/more-recipient?wrong=1", true, true));
        }

        // store selected recipient into session
        request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_ID, rec.getId());
        request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_NAME, rec.getFirstName() + " " + StringUtils.defaultIfEmpty(rec.getMiddleName(), "") + " " + rec.getLastName());

        // jump to page Value Of Gift
        return new ModelAndView(new RedirectView("/gifts/type", true, true));
    }

    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "editNote", method = RequestMethod.POST)
    public ModelAndView editNote(HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        String recIdStr = request.getParameter("recId");
        // check the recipient belong to current order
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        Recipient rec = this.reciService.findById(Long.parseLong(recIdStr));

        List<LixiOrderGift> lxogifts = this.lxogiftService.findByOrderAndRecipient(order, rec);
        if (lxogifts == null || lxogifts.isEmpty()) {

            // error
            return new ModelAndView(new RedirectView("/gifts/review?wrong=1", true, true));

        }

        String note = LiXiUtils.fixEncode(request.getParameter("note"));
        rec.setNote(note);

        // save note
        this.reciService.save(rec);

        // return review page
        return new ModelAndView(new RedirectView("/gifts/review", true, true));
    }
    
}
