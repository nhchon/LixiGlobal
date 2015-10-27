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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.form.ChooseRecipientForm;
import vn.chonsoft.lixi.model.pojo.EnumLixiOrderSetting;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.repositories.service.CurrencyTypeService;
import vn.chonsoft.lixi.repositories.service.LixiCardFeeService;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiFeeService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;
import vn.chonsoft.lixi.web.beans.LoginedUser;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("gifts")
public class GiftsController {

    private static final Logger log = LogManager.getLogger(GiftsController.class);

    //@Inject
    //private LoginedUser loginedUser;
    
    @Inject
    private UserService userService;

    @Inject
    private RecipientService reciService;

    @Inject
    private CurrencyTypeService currencyService;

    @Inject
    private LixiExchangeRateService lxexrateService;

    @Inject
    private LixiCategoryService lxcService;

    @Inject
    private LixiOrderService lxorderService;

    @Inject
    private LixiOrderGiftService lxogiftService;

    @Inject
    private VatgiaProductService vgpService;
    
    @Inject
    private LixiFeeService feeService;
    
    @Inject
    private LixiCardFeeService cardFeeService;
    /**
     *
     * select one of ready recipients or create a new recipients
     * 
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "recipient", method = RequestMethod.GET)
    public ModelAndView recipient(Map<String, Object> model, HttpServletRequest request) {

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

        // default value for message note
        ChooseRecipientForm form = new ChooseRecipientForm();
        form.setNote("Happy Birthday");
        
        model.put("chooseRecipientForm", form);

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
     * choose a ready recipient
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
            form.setDialCode(reci.getDialCode());
            form.setPhone(reci.getPhone());
            form.setNote(reci.getNote());

            model.put("chooseRecipientForm", form);
        }
        //
        return new ModelAndView("giftprocess/recipient", model);
    }

    /**
     *
     * A recipient is selected or created: check unique recipient, update him or created new
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
            Recipient rec = null;
            
            // correct name, fix encode, capitalize
            form.setFirstName(LiXiUtils.correctName(form.getFirstName()));
            form.setMiddleName(LiXiUtils.correctName(form.getMiddleName()));
            form.setLastName(LiXiUtils.correctName(form.getLastName()));
            
            // check unique recipient
            if((form.getRecId()== null) || form.getRecId() <= 0){
                rec = this.reciService.findByFirstNameAndMiddleNameAndLastNameAndPhone(form.getFirstName(), form.getMiddleName(), form.getLastName(), form.getPhone());
                if(rec != null){
                    // duplicate recipient
                    model.put("duplicate", 1);
                    model.put("recipientName", StringUtils.join(new String[]{form.getFirstName(),form.getMiddleName(), form.getLastName()}, " "));
                    model.put("recipientPhone", form.getPhone());

                    return new ModelAndView("giftprocess/recipient", model);
                }
                //
                rec = this.reciService.findByEmail(form.getEmail());
                if(rec != null){
                    // duplicate recipient
                    model.put("duplicateEmail", 1);
                    model.put("recipientEmail", form.getEmail());

                    return new ModelAndView("giftprocess/recipient", model);
                }
            }
            // save or update the recipient
            //log.info("request.getCharacterEncoding(): "+request.getCharacterEncoding());
            //log.info("guessEncoding: " + LiXiUtils.guessEncoding(form.getNote().getBytes()));
            //log.info(form.getNote());
            //log.info(LiXiUtils.fixEncode(form.getNote()));
            //
            rec = new Recipient();
            rec.setId(form.getRecId());
            rec.setSender(u);
            rec.setFirstName(form.getFirstName());
            rec.setMiddleName(form.getMiddleName());
            rec.setLastName(form.getLastName());
            rec.setEmail(form.getEmail());
            rec.setDialCode(form.getDialCode());
            rec.setPhone(form.getPhone());
            rec.setNote(form.getNote());// note
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
     * enter the amount want to give
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
            //request.getSession().setAttribute(LiXiConstants.LIXI_EXCHANGE_RATE_ID, lxexrate.getId());

            // jump
            return new ModelAndView("giftprocess/value-of-gift", model);
        }
    }

    /**
     *
     * submit the amount
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
            request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND, LiXiUtils.getNumberFormat().parse(LiXiUtils.getAmountInVnd(amountCurrencyCode, amount, giftInValue)).doubleValue());
        } catch (Exception e) {

            log.info("parse amount is error:", e);
        }
        // jump to type of gift
        return new ModelAndView(new RedirectView("/gifts/type", true, true));

    }

    /**
     * 
     * select default category
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "type", method = RequestMethod.GET)
    public ModelAndView typeOfGift(HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        //get from session
        Integer selectedCatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID);
        
        if(selectedCatId == null || selectedCatId <= 0){
            
            // selecte default category from database
            Sort sort = new Sort(new Sort.Order(Sort.Direction.DESC, "activated"), 
                                new Sort.Order(Sort.Direction.ASC, "sortOrder"));
            List<LixiCategory> categories = this.lxcService.findByLocaleCode(LocaleContextHolder.getLocale().toString(), sort);
            // use the first category
            selectedCatId = categories.get(0).getId();
        }
        
        // jump
        return new ModelAndView(new RedirectView("/gifts/type/" + selectedCatId, true, true));
    }
    
    /**
     * 
     * check if the product is already selected in current order
     * 
     * @param products
     * @param order 
     */
    private void checkSelected(List<VatgiaProduct> products, LixiOrder order, Recipient rec){
        
        if(rec == null) return;
        if(order == null) return;
        if(order.getGifts() == null || order.getGifts().isEmpty())
            return;
        
        //
        for(VatgiaProduct p : products){
            for(LixiOrderGift gift : order.getGifts()){
                if(gift.getRecipient().equals(rec) && p.getId().intValue() == gift.getProductId()){
                    p.setSelected(Boolean.TRUE);
                    p.setQuantity(gift.getProductQuantity());
                    break;
                }
            }
        }
    }
    /**
     *
     * choose the type of gift want to give
     * 
     * @param selectedCatId 
     * @param page 
     * @param request
     * @return
     */
    @RequestMapping(value = "type/{selectedCatId}", method = RequestMethod.GET)
    public ModelAndView typeOfGift(@PathVariable Integer selectedCatId, @PageableDefault(sort = {"price"}, value = 6) Pageable page,  HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        // sort categories
        Sort sort = new Sort(new Sort.Order(Sort.Direction.DESC, "activated"), 
                            new Sort.Order(Sort.Direction.ASC, "sortOrder"));
        List<LixiCategory> categories = this.lxcService.findByLocaleCode(LocaleContextHolder.getLocale().toString(), sort);

        Map<String, Object> model = new HashMap<>();

        model.put(LiXiConstants.LIXI_CATEGORIES, categories);

        // check current selected category
        log.info("selectedCatId: " + selectedCatId);
        
        // load list products
        LixiCategory lxcategory = this.lxcService.findById(selectedCatId);
        
        // store category into session
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, selectedCatId);
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_NAME, lxcategory.getName());

        // get price, default is 0? VND
        double price = 0;
        if(request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND) != null){
            price = (double)request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND);
        };
        
        List<VatgiaProduct> products = null;
        Page<VatgiaProduct> vgps = this.vgpService.findByCategoryIdAndAliveAndPrice(lxcategory.getVatgiaId().getId(), 1, price, page);
        if(vgps.hasContent()){
            products = vgps.getContent();
        }
        
        // still null ?
        if(products == null || products.isEmpty()){
            // call BaoKim Rest service
            log.info("No products in database. So call BaoKim Rest service");
            ListVatGiaProduct pjs = LiXiVatGiaUtils.getInstance().getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
            products = LiXiVatGiaUtils.getInstance().convertVatGiaProduct2Model(pjs);
        }
        
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
        
        // get current recipient
        Recipient rec = this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
        // check selected
        checkSelected(products, order, rec);
        
        //Map<String, Object> model = new HashMap<>();
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        //
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess/type-of-gift-2", model);

    }

    /**
     * 
     * Ajax call get products
     * 
     * @param selectedCatId
     * @param pageNum
     * @param request
     * @return 
     */
    @RequestMapping(value = "ajax/products/{selectedCatId}/{pageNum}", method = RequestMethod.GET)
    public ModelAndView getProducts(@PathVariable Integer selectedCatId, @PathVariable Integer pageNum,  HttpServletRequest request) {
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        // load list products
        LixiCategory lxcategory = this.lxcService.findById(selectedCatId);
        
        // store category into session
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, selectedCatId);
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_NAME, lxcategory.getName());

        // get price, default is 0? VND
        double price = 0;
        if(request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND) != null){
            price = (double)request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND);
        };
        
        List<VatgiaProduct> products = null;
        Pageable page = new PageRequest(pageNum, LiXiConstants.NUM_PRODUCTS_PER_PAGE, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        
        Page<VatgiaProduct> vgps = this.vgpService.findByCategoryIdAndAliveAndPrice(lxcategory.getVatgiaId().getId(), 1, price, page);
        if(vgps.hasContent()){
            products = vgps.getContent();
        }
        
        // still null ?
        if(products == null || products.isEmpty()){
            // call BaoKim Rest service
            log.info("No products in database. So call BaoKim Rest service");
            ListVatGiaProduct pjs = LiXiVatGiaUtils.getInstance().getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
            products = LiXiVatGiaUtils.getInstance().convertVatGiaProduct2Model(pjs);
        }
        
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

        Map<String, Object> model = new HashMap<>();
        
        // get current recipient
        Recipient rec = this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
        // check selected
        checkSelected(products, order, rec);
        
        // check selected
        checkSelected(products, order, rec);

        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess/type-of-gift-content", model);
        
    }
    /**
     * 
     * change the gift
     * 
     * @param model
     * @param lxOrderGift
     * @param productId
     * @param quantity
     * @param request
     * @return 
     */
    @RequestMapping(value = "change/{lxOrderGift}/{productId}/{quantity}", method = RequestMethod.GET)
    public ModelAndView changeTheGist(Map<String, Object> model, @PathVariable Long lxOrderGift, @PathVariable Integer productId, @PathVariable Integer quantity, HttpServletRequest request) {
        
        // log
        log.info("change id: " + productId + " quantity: " + quantity);
        LixiOrderGift orderGift = this.lxogiftService.findById(lxOrderGift);
        
        model.put(LiXiConstants.LIXI_ORDER_GIFT_ID, orderGift.getId());
        model.put(LiXiConstants.LIXI_ORDER_GIFT_PRODUCT_ID, productId);
        model.put(LiXiConstants.LIXI_ORDER_GIFT_PRODUCT_QUANTITY, quantity);
        
        return chooseGift(orderGift.getCategory().getId(), model, request);
    }
    /**
     *
     * @param model
     * @param category LixiCategory Id
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
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, category);
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_NAME, lxcategory.getName());

        // get price, default is ? VND
        double price = 0;
        if(request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND) != null){
            price = (double)request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND);
        };
        
        List<VatgiaProduct> products = this.vgpService.findByCategoryIdAndAliveAndPrice(lxcategory.getVatgiaId().getId(), 1, price);
        if(products == null || products.isEmpty()){
            
            // call BaoKim Rest service
            log.info("No products in database. So call BaoKim Rest service");
            ListVatGiaProduct pjs = LiXiVatGiaUtils.getInstance().getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
            products = LiXiVatGiaUtils.getInstance().convertVatGiaProduct2Model(pjs);
        }
        //log.info("products == null " + (products == null || products.isEmpty()));
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
        String orderGiftIdStr = request.getParameter("orderGiftId");
        
        log.info(giftIdStr + " - " + priceStr);
        // parse
        int giftId = 0;
        long orderGiftId = 0;
        //parse
        try { giftId = Integer.parseInt(giftIdStr);} catch (Exception e) {}
        try { orderGiftId = Long.parseLong(orderGiftIdStr);} catch (Exception e) {}
        
        if (giftId == 0) {

            // wrong gift id
            model.put("wrong", 1);

            return new ModelAndView("giftprocess/choose-the-gift", model);
        }

        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        // no need to check
        double price = Double.parseDouble(priceStr);
        int quantity = Integer.parseInt(quantityStr);
        LixiCategory lxCategory = this.lxcService.findById((Integer) request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID));

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
        
        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order, orderGiftId);
        double currentPayment = currentPayments[0].getUsd();//usd
        currentPayment += ((price * quantity) / buy);

        if (currentPayment > u.getUserMoneyLevel().getMoneyLevel().getAmount()) {

            // maximum payment is over
            model.put("exceed", 1);
            model.put(LiXiConstants.LIXI_ORDER_GIFT_PRODUCT_ID, giftId);
            model.put(LiXiConstants.LIXI_ORDER_GIFT_PRODUCT_QUANTITY, quantity);
            
            double exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            double exceededPaymentVND = exceededPaymentUSD * buy;
            
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
            order.setLixiStatus(LiXiConstants.LIXI_ORDER_UNFINISHED);
            order.setLixiMessage(null);
            // default is allow refund
            order.setSetting(EnumLixiOrderSetting.ALLOW_REFUND.getValue());
            order.setModifiedDate(Calendar.getInstance().getTime());

            // set card and billing address from last order
            LixiOrder lastOrder = this.lxorderService.findLastOrder(u);
            // last user's order
            if(lastOrder != null){
                // use the last payment method
                order.setCard(lastOrder.getCard());
                order.setBankAccount(lastOrder.getBankAccount());
            }
            
            // save order
            order = this.lxorderService.save(order);

            // store ID into session
            request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
        }
        
        // Recipient
        Recipient rec = null;
        
        LixiOrderGift alreadyGift = null;
        
        // change the gift
        if(orderGiftId > 0){
            
            alreadyGift = this.lxogiftService.findById(orderGiftId);
            if(alreadyGift != null){
                alreadyGift.setProductId(giftId);
                alreadyGift.setProductPrice(price);
                alreadyGift.setProductName(name);
                alreadyGift.setProductImage(image);
                alreadyGift.setProductQuantity(quantity);
                alreadyGift.setBkStatus(LiXiConstants.LIXI_ORDER_GIFT_NOT_SUBMITTED);// not yet submitted
                alreadyGift.setModifiedDate(Calendar.getInstance().getTime());

                this.lxogiftService.save(alreadyGift);
            }
        }
        else{
            // get recipient
            rec = this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
            
            // check the gifts already bought
            alreadyGift = this.lxogiftService.findByOrderAndRecipientAndProductId(order, rec, giftId);
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
                lxogift.setBkStatus(LiXiConstants.LIXI_ORDER_GIFT_NOT_SUBMITTED);// not yet submitted
                lxogift.setModifiedDate(Calendar.getInstance().getTime());

                this.lxogiftService.save(lxogift);

            }
            else{
                // update quantity
                alreadyGift.setProductQuantity(alreadyGift.getProductQuantity() + quantity);

                this.lxogiftService.save(alreadyGift);
            }
        }
        // jump to more-recipient
        return new ModelAndView(new RedirectView("/gifts/more-recipient", true, true));
    }
    
    /**
     * 
     * check order is exceeded
     * 
     * @param model
     * @param recId
     * @param productId
     * @param quantity
     * @param request
     * @return 
     */
    @RequestMapping(value = "checkExceed/{recId}/{productId}/{quantity}", method = RequestMethod.GET)
    public ModelAndView checkExceed(Map<String, Object> model, @PathVariable Long recId, @PathVariable Integer productId, @PathVariable Integer quantity, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        /* get recipient */
        Recipient rec = this.reciService.findById((Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID));
        LixiOrderGift alreadyGift = this.lxogiftService.findByOrderAndRecipientAndProductId(order, rec, productId);
        
        // get price
        VatgiaProduct vgp = this.vgpService.findById(productId);
        double price = vgp.getPrice();
        
        // check current payment <==> maximum payment
        LixiExchangeRate lxExch = null;
        double buy = 0;
        if(order != null){
            // get buy from order
            lxExch = order.getLxExchangeRate();
            buy = lxExch.getBuy();
        }
        else{
            // get current exchange rate
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
            buy = lxExch.getBuy();
        }
        
        SumVndUsd[] currentPayments;
        if(quantity > 0){
            currentPayments = LiXiUtils.calculateCurrentPayment(order, LiXiUtils.getOrderGiftId(alreadyGift)); // in USD
        }
        else{
            // remove the gift, count all and then minus out
            currentPayments = LiXiUtils.calculateCurrentPayment(order);
        }
        double currentPayment = currentPayments[0].getUsd();//USD
        currentPayment += LiXiUtils.roundPriceQuantity2USD(price, quantity, buy);// in USD
        if (currentPayment > (u.getUserMoneyLevel().getMoneyLevel().getAmount())) {

            // maximum payment is over
            model.put("exceed", 1);
            
            double exceededPaymentVND = (currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount()) * buy;
            double exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            
            model.put(LiXiConstants.EXCEEDED_VND, LiXiUtils.getNumberFormat().format(exceededPaymentVND));
            
            model.put(LiXiConstants.EXCEEDED_USD, LiXiUtils.getNumberFormat().format(exceededPaymentUSD));
         
            if(alreadyGift != null){
                // restore value for already selected gift
                model.put(LiXiConstants.SELECTED_PRODUCT_ID, alreadyGift.getProductId());
                model.put(LiXiConstants.SELECTED_PRODUCT_QUANTITY, alreadyGift.getProductQuantity());
            }
        }
        else{
            // the order is not exceeded
            model.put("exceed", 0);

            // store OR remove the gift
            /* get selected category*/
            LixiCategory lxCategory = this.lxcService.findById((Integer) request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID));
            
            // check the gifts already bought
            if(alreadyGift == null){
                
                // checkbox is checked
                if(quantity > 0){
                    
                    // create the order
                    if(order == null){
                        order = new LixiOrder();
                        order.setSender(u);
                        order.setLxExchangeRate(lxExch);
                        order.setLixiStatus(LiXiConstants.LIXI_ORDER_UNFINISHED);
                        order.setLixiMessage(null);
                        // default is allow refund
                        order.setSetting(EnumLixiOrderSetting.ALLOW_REFUND.getValue());
                        order.setModifiedDate(Calendar.getInstance().getTime());

                        // set card and billing address from last order
                        LixiOrder lastOrder = this.lxorderService.findLastOrder(u);
                        // last user's order
                        if(lastOrder != null){
                            // use the last payment method
                            order.setCard(lastOrder.getCard());
                            order.setBankAccount(lastOrder.getBankAccount());
                        }

                        // save order
                        order = this.lxorderService.save(order);

                        // store ID into session
                        request.getSession().setAttribute(LiXiConstants.LIXI_ORDER_ID, order.getId());
                    }
                    
                    // create lixi order gift
                    LixiOrderGift lxogift = new LixiOrderGift();
                    lxogift.setRecipient(rec);
                    lxogift.setOrder(order);
                    lxogift.setCategory(lxCategory);
                    lxogift.setProductId(productId);
                    lxogift.setProductPrice(price);
                    lxogift.setProductName(vgp.getName());
                    lxogift.setProductImage(vgp.getImageUrl());
                    lxogift.setProductQuantity(quantity);
                    lxogift.setBkStatus(LiXiConstants.LIXI_ORDER_GIFT_NOT_SUBMITTED);// not yet submitted
                    lxogift.setModifiedDate(Calendar.getInstance().getTime());

                    this.lxogiftService.save(lxogift);
                }
                else{
                    // uncheck
                    // NOTHING TO DO, just return;
                }
            }
            else{
                if(quantity > 0){
                    // update quantity
                    alreadyGift.setProductQuantity(quantity);

                    this.lxogiftService.save(alreadyGift);
                }
                else{
                    // remove the gift
                    this.lxogiftService.delete(alreadyGift.getId());
                }
            }
            
        }
        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, LiXiUtils.getNumberFormat().format(currentPayment));
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, LiXiUtils.getNumberFormat().format(currentPayment * buy));
        
        return new ModelAndView("giftprocess/exceed", model);
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
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }
        
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);

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
        // quantity = 0
        if(quantity ==0 ){
            
            // delete the order
        }
        // else
        double buy = order.getLxExchangeRate().getBuy();
        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order, lxogift.getId()); // in VND
        double currentPayment = currentPayments[0].getVnd();
        currentPayment += (lxogift.getProductPrice() * quantity);

        // maximum payment is over
        if (currentPayment > u.getUserMoneyLevel().getMoneyLevel().getAmount() * buy) {

            Map<String, Object> model = new HashMap<>();
            
            // maximum payment is over
            model.put("exceed", 1);
            
            double exceededPaymentVND = currentPayment - (u.getUserMoneyLevel().getMoneyLevel().getAmount() * buy);
            double exceededPaymentUSD = (currentPayment/buy) - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            
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

        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);

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

        rec.setNote(request.getParameter("note"));

        // save note
        this.reciService.save(rec);

        // return review page
        return new ModelAndView(new RedirectView("/gifts/review", true, true));
    }
    
}
