/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CategoriesBean;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("gifts")
public class GiftsController2 {
    
    private static final Logger log = LogManager.getLogger(GiftsController2.class);

    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private CategoriesBean categories;
    
    @Autowired
    private UserService userService;

    @Autowired
    private RecipientService reciService;

    //@Autowired
    //private CurrencyTypeService currencyService;

    @Autowired
    private LixiExchangeRateService lxexrateService;

    //@Autowired
    //private LixiCategoryService lxcService;

    @Autowired
    private LixiOrderService lxorderService;

    @Autowired
    private LixiOrderGiftService lxogiftService;

    @Autowired
    private VatgiaProductService vgpService;
    
    /**
     *
     * @param model
     * @param email
     */
    private void setRecipients(Map<String, Object> model, String email) {

        User u = this.userService.findByEmail(email);
        if (u != null) {

            model.put(LiXiConstants.RECIPIENTS, u.getRecipients());
        }

    }

    /**
     *
     * @param model
     * @param u
     */
    private void setRecipients(Map<String, Object> model, User u) {

        if (u != null) {

            model.put(LiXiConstants.RECIPIENTS, u.getRecipients());
        }

    }

    /**
     * 
     * @param id
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "loadRec/{id}", method = RequestMethod.GET)
    public ModelAndView loadRecipient(Map<String, Object> model, @PathVariable Long id){
        
        Recipient rec = this.reciService.findById(id);
        
        model.put("rec", rec);
        
        return new ModelAndView("giftprocess2/recInfo");
    }
    /**
     *
     * select one of ready recipients or create a new recipients
     * 
     * @param model
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "recipient", method = RequestMethod.GET)
    public ModelAndView recipient(Map<String, Object> model, HttpServletRequest request) {
        
        // select recipients of user
        User u = this.userService.findByEmail(loginedUser.getEmail());
        if (u != null) {

            model.put(LiXiConstants.RECIPIENTS, u.getRecipients());
        }

        // default value for message note
        ChooseRecipientForm form = new ChooseRecipientForm();
        //form.setNextUrl(request.getParameter("nextUrl"));
        form.setNote("Happy Birthday");
        
        model.put("chooseRecipientForm", form);

        return new ModelAndView("giftprocess2/recipient");

    }
    
    /**
     *
     * choose a ready recipient
     * 
     * @param model
     * @param recId
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "chooseRecipient/{recId}", method = RequestMethod.GET)
    public ModelAndView chooseRecipient(Map<String, Object> model, @PathVariable Long recId) {

        // select recipients of user
        setRecipients(model, loginedUser.getEmail());

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
        return new ModelAndView("giftprocess2/recipient");
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
    @UserSecurityAnnotation
    @RequestMapping(value = {"recipient", "chooseRecipient/{recId}"}, method = RequestMethod.POST)
    public ModelAndView chooseRecipient(Map<String, Object> model,
            @Valid ChooseRecipientForm form, Errors errors, HttpServletRequest request) {

        User u = this.userService.findByEmail(loginedUser.getEmail());
        // select recipients of user
        setRecipients(model, u);

        if (errors.hasErrors()) {

            return new ModelAndView("giftprocess2/recipient");
        }

        try {
            Recipient rec = null;
            
            // check unique recipient
            if((form.getRecId()== null) || form.getRecId() <= 0){
                rec = this.reciService.findByNameAndPhone(u, form.getFirstName(), form.getMiddleName(), form.getLastName(), form.getPhone());
                if(rec != null){
                    // duplicate recipient
                    model.put("duplicate", 1);
                    model.put("recipientName", StringUtils.join(new String[]{form.getFirstName(),form.getMiddleName(), form.getLastName()}, " "));
                    model.put("recipientPhone", form.getPhone());

                    return new ModelAndView("giftprocess2/recipient", model);
                }
                //
                rec = this.reciService.findByEmail(u, form.getEmail());
                if(rec != null){
                    // duplicate recipient
                    model.put("duplicateEmail", 1);
                    model.put("recipientEmail", form.getEmail());

                    return new ModelAndView("giftprocess2/recipient", model);
                }
            }
            /* save or update the recipient */
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
            request.getSession().setAttribute(LiXiConstants.SELECTED_RECIPIENT_FIRST_NAME, form.getFirstName());

            /* next page */
            String nextUrl = "/gifts/type/" + rec.getId();
            if(!StringUtils.isEmpty(form.getNextUrl())){
                nextUrl = form.getNextUrl();
            }
            
            log.info("nextUrl : " + nextUrl);
            
            return new ModelAndView(new RedirectView(nextUrl, true, true));

        } catch (ConstraintViolationException e) {

            log.info(e.getMessage(), e);

            model.put("validationErrors", e.getConstraintViolations());

            return new ModelAndView("giftprocess2/recipient", model);

        }

    }

    /**
     * 
     * @param model
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "chooseCategory", method = RequestMethod.GET)
    public ModelAndView chooseCategory(Map<String, Object> model){
        
        /* no top categories */
        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        
        return new ModelAndView("giftprocess2/chooseCategory");
    }
    
    /**
     * 
     * @param model
     * @param selectedCatId 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "chooseCategory/{selectedCatId}", method = RequestMethod.GET)
    public ModelAndView chooseCategory(Map<String, Object> model, @PathVariable Integer selectedCatId, HttpServletRequest request){
        
        // remove
        request.getSession().removeAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND);
        
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, selectedCatId);   
        
        Long recId = (Long)request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID);
        
        if(recId != null){
            
            return new ModelAndView(new RedirectView("/gifts/type/" + recId.toString() + "/" + selectedCatId.toString(), true, true));
        }
        else{
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }
    }    
    
    /**
     * 
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "type", method = RequestMethod.GET)
    public ModelAndView typeOfGift(HttpServletRequest request){
        
        Long recId = (Long)request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID);
        Integer selectedCatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID);
        
        if(recId == null){
            
            return new ModelAndView(new RedirectView("/gifts/chooseCategory", true, true));
        }
        else{
            
            if(selectedCatId == null){
                
                return new ModelAndView(new RedirectView("/gifts/type/" + recId.toString(), true, true));
            }
            else{
                if(selectedCatId == 0){
                    return new ModelAndView(new RedirectView("/topUp", true, true));
                }
                else{
                    return new ModelAndView(new RedirectView("/gifts/type/" + recId.toString() + "/" + selectedCatId.toString(), true, true));
                }
            }
        }
    }
    /**
     * 
     * select default category
     * 
     * @param recId 
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "type/{recId}", method = RequestMethod.GET)
    public ModelAndView typeOfGift(@PathVariable Long recId, HttpServletRequest request){
        
        //get from session
        Integer selectedCatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID);
        
        if(selectedCatId == null || selectedCatId <= 0){
            selectedCatId = categories.getCandies().getId();
        }
        
        // jump
        return new ModelAndView(new RedirectView("/gifts/type/" + recId + "/" + selectedCatId, true, true));
    }
    
    /**
     *
     * choose the type of gift want to give
     * 
     * @param model
     * @param recId 
     * @param selectedCatId 
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "type/{recId}/{selectedCatId}", method = RequestMethod.GET)
    public ModelAndView typeOfGift(Map<String, Object> model, @PathVariable Long recId, @PathVariable Integer selectedCatId,  HttpServletRequest request) {
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        model.put(LiXiConstants.RECIPIENTS, u.getRecipients());
        
        // load list products
        LixiCategory lxcategory = categories.getById(selectedCatId);
        
        // check current selected category
        log.info("selectedCatId: " + selectedCatId + " VG's id : " + lxcategory.getVatgiaId().getId());
        
        // store category into session
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, selectedCatId);
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_NAME, lxcategory.getName());

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
        
        // get price, default is 0? VND
        double price = LiXiConstants.MINIMUM_PRICE_USD * lxExch.getBuy();
        if(request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND) != null){
            price = (double)request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND);
        };
        
        /* list product */
        List<VatgiaProduct> products = null;
        /* zero-based page index */
        Pageable page = new PageRequest(0, LiXiConstants.NUM_PRODUCTS_PER_PAGE, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));

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
        
        // get current recipient
        Recipient rec = this.reciService.findById(recId);//(Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID)
        /* check already selected product */
        LiXiUtils.checkSelected(products, order, rec);
        
        /* forward recipient's id */
        model.put(LiXiConstants.SELECTED_RECIPIENT_ID, recId);
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        //
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/select-gifts", model);

    }

    /**
     * 
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "choose", method = RequestMethod.GET)
    public ModelAndView chooseGift(Map<String, Object> model, HttpServletRequest request){
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        model.put(LiXiConstants.RECIPIENTS, u.getRecipients());
        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        
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
        
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        //
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/select-gifts");
    }
    
    
    /**
     * @param model
     * @param selectedCatId 
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "choose/{selectedCatId}", method = RequestMethod.GET)
    public ModelAndView chooseGift(Map<String, Object> model, @PathVariable Integer selectedCatId, HttpServletRequest request){
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        model.put(LiXiConstants.RECIPIENTS, u.getRecipients());
        
        // load list products
        LixiCategory lxcategory = categories.getById(selectedCatId);
        
        // check current selected category
        log.info("selectedCatId: " + selectedCatId + " VG's id : " + lxcategory.getVatgiaId().getId());
        
        // store category into session
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, selectedCatId);
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_NAME, lxcategory.getName());

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
        
        // get price, default is 0? VND
        double price = LiXiConstants.MINIMUM_PRICE_USD * lxExch.getBuy();
        if(request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND) != null){
            price = (double)request.getSession().getAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND);
        };
        
        /* list product */
        List<VatgiaProduct> products = null;
        /* zero-based page index */
        Pageable page = new PageRequest(0, LiXiConstants.NUM_PRODUCTS_PER_PAGE, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));

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
        
        // get current recipient
        //Recipient rec = this.reciService.findById(recId);//(Long) request.getSession().getAttribute(LiXiConstants.SELECTED_RECIPIENT_ID)
        /* check already selected product */
        //LiXiUtils.checkSelected(products, order, rec);
        
        /* forward recipient's id */
        //model.put(LiXiConstants.SELECTED_RECIPIENT_ID, recId);
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        //
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/select-gifts", model);

    }
    
    /**
     * @param model
     * @param selectedCatId
     * @param recId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "choose/{selectedCatId}/{recId}", method = RequestMethod.GET)
    public ModelAndView chooseGift(Map<String, Object> model, @PathVariable Integer selectedCatId, @PathVariable Long recId, HttpServletRequest request){
        
        model.put("recId", recId);
        
        return chooseGift(model, selectedCatId, request);
    }    
    /**
     *
     * @param model 
     * @param request
     * @return
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "order-summary", method = RequestMethod.GET)
    public ModelAndView orderSummary(Map<String, Object> model, HttpServletRequest request) {

        User u = this.userService.findByEmail(loginedUser.getEmail());

        // check order created
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(orderId == null){
            
            // to do
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }
        
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order); // in USD
        
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.LIXI_TOTAL_AMOUNT, currentPayments[0]);
        model.put(LiXiConstants.REC_GIFTS, recGifts);

        return new ModelAndView("giftprocess2/order-summary", model);
    }
    
    /**
     * 
     * @param giftId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "delete/gift/{giftId}", method = RequestMethod.GET)
    public ModelAndView delete(@PathVariable Long giftId, HttpServletRequest request) {
        
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        LixiOrderGift lxogift = this.lxogiftService.findByIdAndOrder(giftId, order);

        if (lxogift != null) {

            this.lxogiftService.delete(lxogift.getId());

        } else {

            log.info("Lixi order gift is null: " + giftId);
        }

        // jump 
        return new ModelAndView(new RedirectView("/gifts/order-summary", true, true));
        
    }
    
    /**
     * 
     * @param model
     * @param giftId
     * @param request 
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "change/{giftId}", method = RequestMethod.GET)
    public ModelAndView changeTheGift(Map<String, Object> model, @PathVariable Long giftId, HttpServletRequest request){
        
        // check the order
        Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);
        if(orderId == null){
            
            return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        }
        else{
            
            //LixiOrder order = this.lxorderService.findById(orderId);
            LixiOrderGift gift = this.lxogiftService.findById(giftId);
            Long recId = gift.getRecipient().getId();
            Integer catId = gift.getCategory().getId();
            if(gift.getOrder().getId().equals(orderId)){
                
                this.lxogiftService.delete(giftId);
                
            }
            
            return new ModelAndView(new RedirectView("/gifts/choose/" + catId + "/" + recId, true, true));
        }
    }
    
}
