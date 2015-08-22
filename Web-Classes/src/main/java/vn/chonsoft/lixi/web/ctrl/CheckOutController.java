/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.form.BillingAddressForm;
import vn.chonsoft.lixi.model.form.CardAddForm;
import vn.chonsoft.lixi.repositories.service.BillingAddressService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserCardService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.model.pojo.EnumCard;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("checkout")
public class CheckOutController {
    
    private static final Logger log = LogManager.getLogger(CheckOutController.class);
    
    @Inject
    private UserService userService;
    
    @Inject
    private UserCardService ucService;
    
    @Inject
    private BillingAddressService baService;
    
    @Inject
    private LixiOrderService lxorderService;
    
    @Inject
    private RecipientService recService;
    /**
     * Add a card
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "cards/add", method = RequestMethod.GET)
    public ModelAndView addACard(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        CardAddForm addForm = new CardAddForm();
        addForm.setCardType(1);
        
        model.put("cardAddForm", addForm);
        
        return new ModelAndView("giftprocess/add-a-card", model);
        
    }
    
    /**
     * 
     * @param model
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "cards/add", method = RequestMethod.POST)
    public ModelAndView addACard(Map<String, Object> model,
            @Valid CardAddForm form, Errors errors, HttpServletRequest request) {

        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        if (errors.hasErrors()) {
            
            return new ModelAndView("giftprocess/add-a-card");
        }
        
        try {
            
            if(!LiXiUtils.checkMonthYearGreaterThanCurrent(form.getExpMonth(), form.getExpYear())){
                
                model.put("expiration_failed", 1);
                
                return new ModelAndView("giftprocess/add-a-card", model);
            }
            
            String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            User u = this.userService.findByEmail(email);

            // Add a card
            UserCard uc = new UserCard();
            uc.setUser(u);
            uc.setCardType(form.getCardType());
            uc.setCardName(form.getCardName());
            uc.setCardNumber(form.getCardNumber());
            uc.setExpMonth(form.getExpMonth());
            uc.setExpYear(form.getExpYear());
            uc.setCardCvv(form.getCvv());
            uc.setModifiedDate(Calendar.getInstance().getTime());
            
            uc = this.ucService.save(uc);
            
            // update order, add card
            LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
            order.setCard(uc);
            
            this.lxorderService.save(order);
            
            return new ModelAndView(new RedirectView("/checkout/billing-address/" + uc.getId(), true, true));
            
        } catch (ConstraintViolationException e) {

            log.info("Insert card failed", e);
            //
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("giftprocess/add-a-card", model);

        }
        
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "cards/change", method = RequestMethod.GET)
    public ModelAndView cards(Map<String, Object> model,  HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        List<UserCard> cards = this.ucService.findByUser(u);
        
        model.put(LiXiConstants.CARDS, cards);
        model.put(LiXiConstants.LIXI_ORDER, this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID)));
        
        return new ModelAndView("giftprocess/change-payment-method");
    }
    
    /**
     * 
     * User change payment method
     * 
     * @param cardId
     * @param request
     * @return 
     */
    @RequestMapping(value = "cards/change", method = RequestMethod.POST)
    public ModelAndView changeCards(@RequestParam Long cardId,  HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        order.setCard(this.ucService.findById(cardId));
        
        this.lxorderService.save(order);
        
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }
    /**
     * 
     * @param page
     * @param model
     * @param userId
     * @param request
     * @return 
     */
    @RequestMapping(value = "choose-billing-address/{userId}", method = RequestMethod.GET)
    public ModelAndView chooseBillingAddress(Map<String, Object> model, @PageableDefault(value = 6) Pageable page, @PathVariable Long userId,  HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        //Pageable just2rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);

        Page<BillingAddress> addresses = this.baService.findByUser(u, page);
        
        model.put(LiXiConstants.BILLING_ADDRESS_ES, addresses);
        model.put(LiXiConstants.USER_LOGIN_ID, u.getId());
        
        return new ModelAndView("giftprocess/billing-address-list", model);
    }
    /**
     * 
     * @param cardId 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address/{cardId}", method = RequestMethod.GET)
    public ModelAndView billingAddress(Map<String, Object> model, @PathVariable Long cardId, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        model.put("billingAddressForm", new BillingAddressForm());
        
        return new ModelAndView("giftprocess/billing-address");
        
    }
    
    /**
     * 
     * @param model
     * @param cardId
     * @param form
     * @param errors
     * @param request
     * @return 
     */
    @RequestMapping(value = "billing-address/{cardId}", method = RequestMethod.POST)
    public ModelAndView billingAddress(Map<String, Object> model, @PathVariable Long cardId, 
            @Valid BillingAddressForm form, Errors errors, HttpServletRequest request) {
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        if (errors.hasErrors()) {
            
            return new ModelAndView("giftprocess/billing-address");
        }
        
        try {

            String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
            User u = this.userService.findByEmail(email);
            
            // check card belong to user
            UserCard uc = this.ucService.findByIdAndUser(cardId, u);
            if(uc == null){
                
                return new ModelAndView("giftprocess/billing-address?card_failed=1");
            }
            // created billing address
            BillingAddress bil = new BillingAddress();
            bil.setUser(u);
            bil.setFullName(form.getFullName());
            bil.setAdd1(form.getAdd1());
            bil.setAdd2(form.getAdd2());
            bil.setCity(form.getCity());
            bil.setState(form.getState());
            bil.setZipCode(form.getZipCode());
            bil.setPhone(form.getPhone());
            
            bil = this.baService.save(bil);
            
            request.getSession().setAttribute(LiXiConstants.CARD_TYPE_NAME, EnumCard.findByValue(uc.getCardType()).toString());

            String numbers = uc.getCardNumber().substring(Math.max(0, uc.getCardNumber().length() - 4));
            request.getSession().setAttribute(LiXiConstants.CARD_ENDING_WITH, numbers);
            
            request.getSession().setAttribute(LiXiConstants.BILLING_ADDRESS, bil);
        } catch (ConstraintViolationException e) {
            
            model.put("validationErrors", e.getConstraintViolations());
            return new ModelAndView("giftprocess/billing-address", model);
        }
        
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }
    
    /**
     * 
     * @param model 
     * @param request
     * @return 
     */
    @RequestMapping(value = "place-order", method = RequestMethod.GET)
    public ModelAndView placeOrder(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }

        // get order id
        // get order
        LixiOrder order = null;
        // order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {
            
            order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
        }
        else{
            
            // order not exist, go to Choose recipient page
            return new ModelAndView(new RedirectView("/gifts/recipient", true, true));
        }
        
        Map<Recipient, List<LixiOrderGift>> recGifts = LiXiUtils.genMapRecGifts(order);
        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.REC_GIFTS, recGifts);
        
        
        return new ModelAndView("giftprocess/place-order");
    }
    
    /**
     * 
     * @param request
     * @return 
     */
    @RequestMapping(value = "edit-rec-phone", method = RequestMethod.POST)
    public ModelAndView editRecMobilePhone(HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        String recId = request.getParameter("recId");
        String phone = request.getParameter("phone");
        
        this.recService.updatePhone(phone, Long.parseLong(recId));
        
        return new ModelAndView(new RedirectView("/checkout/place-order", true, true));
    }
}
