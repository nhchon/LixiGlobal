/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.MoneyLevel;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.MoneyLevelService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.ScalarFunctionService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VatgiaCategoryService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.UserSecurityAnnotation;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CategoriesBean;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping("gifts")
public class BuyGiftsController {
    
    private static final Logger log = LogManager.getLogger(BuyGiftsController.class);
    
    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private CategoriesBean categories;
    
    @Autowired
    private LixiCategoryService lxCategoryService;
    
    @Autowired
    private UserService userService;

    @Autowired
    private RecipientService reciService;

    @Autowired
    private LixiExchangeRateService lxexrateService;

    @Autowired
    private LixiOrderService lxorderService;

    @Autowired
    private LixiOrderGiftService lxogiftService;

    @Autowired
    private VatgiaProductService vgpService;
    
    @Autowired
    private MoneyLevelService moneyLevelService;
    
    @Autowired
    private VatgiaCategoryService vgcService;

    @Autowired
    private ScalarFunctionService scalarService;
    
    /**
     * 
     * @param giftId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "delete/{giftId}", method = RequestMethod.GET)
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
            Integer catId = gift.getCategory().getId();
            if(gift.getOrder().getId().equals(orderId)){
                
                this.lxogiftService.delete(giftId);
                
            }
            
            return new ModelAndView(new RedirectView("/gifts/choose/" + catId, true, true));
        }
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
            return new ModelAndView(new RedirectView("/gifts/choose", true, true));
        }
        
        LixiOrder order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));

        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order); // in USD
        
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.LIXI_TOTAL_AMOUNT, currentPayments[0]);
        model.put(LiXiConstants.REC_GIFTS, recGifts);
        // current total order
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());

        return new ModelAndView("giftprocess2/order-summary", model);
    }
    
    /**
     * 
     * @param model
     * @param quantity
     * @param productId
     * @param recId
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "buy", method = RequestMethod.POST)
    public ModelAndView buyGift(Map<String, Object> model, @RequestParam Integer quantity,  @RequestParam Integer productId, @RequestParam Long recId, HttpServletRequest request){
        
        User u = null;
        LixiOrder order = null;
        MoneyLevel ml = null;
        LixiExchangeRate lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        double buy = lxExch.getBuy();
        SumVndUsd[] currentPayments = null;
        // get price
        VatgiaProduct vgp = this.vgpService.findById(productId);
        double price = vgp.getPrice();
        
        // no login
        if(StringUtils.isEmpty(loginedUser.getEmail())){
            
            ml = moneyLevelService.findByIsDefault();
        }
        else{
            
            // check order already created
            if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {
                order = this.lxorderService.findById((Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID));
            }
            
            u = this.userService.findByEmail(loginedUser.getEmail());
            ml = u.getUserMoneyLevel().getMoneyLevel();
            // get current exchange rate
            if(order != null){
                // get buy from order
                lxExch = order.getLxExchangeRate();
                buy = lxExch.getBuy();
            }
        }
        
        /* get recipient */
        Recipient rec = this.reciService.findById(recId);
        LixiOrderGift alreadyGift = this.lxogiftService.findByOrderAndRecipientAndProductId(order, rec, productId);
        
        currentPayments = LiXiUtils.calculateCurrentPayment(order, alreadyGift);
        
        double currentPayment = currentPayments[0].getUsd();//USD
        double currPaymentVnd = currentPayments[0].getVnd();
        if(quantity>0){
            // add selected gift
            currentPayment += (LiXiUtils.toUsdPrice(price, buy) * quantity);
            
            currPaymentVnd += (price * quantity);
        }
        
        if (currentPayment > (ml.getAmount())) {

            // maximum payment is over
            model.put("exceed", 1);
            
            double exceededPaymentVND = (currentPayment - ml.getAmount()) * buy;
            double exceededPaymentUSD = currentPayment - ml.getAmount();
            
            model.put(LiXiConstants.EXCEEDED_VND, LiXiGlobalUtils.round2Decimal(exceededPaymentVND));
            
            model.put(LiXiConstants.EXCEEDED_USD, LiXiGlobalUtils.round2Decimal(exceededPaymentUSD));
            
            model.put(LiXiGlobalConstants.MONEY_LEVEL, ml.getAmount());
            
            return new ModelAndView(new RedirectView("/gifts/detail/" + productId, true, true));
        }
        else{
            // the order is not exceeded
            model.put("exceed", 0);
            
            // check the gifts already bought
            if(alreadyGift == null){
                if(quantity > 0){
                    // create the order
                    if(order == null){
                        order = new LixiOrder();
                        order.setSender(u);
                        order.setLxExchangeRate(lxExch);
                        order.setLixiStatus(EnumLixiOrderStatus.UN_FINISHED.getValue());
                        order.setLixiSubStatus(EnumLixiOrderStatus.UN_FINISHED.getValue());
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
                    lxogift.setRecipientEmail(loginedUser.getEmail());
                    lxogift.setOrder(order);
                    lxogift.setCategory(this.vgcService.findOne(vgp.getCategoryId()).getLixiCategory());
                    lxogift.setProductId(productId);
                    lxogift.setProductPrice(price);
                    lxogift.setUsdPrice(LiXiUtils.toUsdPrice(price, buy));
                    lxogift.setProductName(vgp.getName());
                    lxogift.setProductImage(vgp.getImageUrl());
                    lxogift.setProductQuantity(quantity);
                    lxogift.setProductSource(vgp.getLinkDetail());
                    lxogift.setBkStatus(EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue());// not yet submitted
                    lxogift.setBkSubStatus(EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue());// not yet submitted
                    lxogift.setLixiMargined(false);
                    
                    /* date */
                    Date currDate = Calendar.getInstance().getTime();
                    lxogift.setCreatedDate(currDate);
                    lxogift.setModifiedDate(currDate);

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
                    alreadyGift.setProductQuantity(quantity + alreadyGift.getProductQuantity());
                    this.lxogiftService.save(alreadyGift);
                }
            }
            
        }
        
        return new ModelAndView(new RedirectView("/gifts/order-summary", true, true));
    }
    /**
     * 
     * @param model
     * @param id
     * @param request
     * @return 
     */
    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public ModelAndView giftDetail(Map<String, Object> model, @PathVariable Integer id,  HttpServletRequest request){
        
        VatgiaProduct p = this.vgpService.findById(id);
        // check p
        if(p == null){
            return new ModelAndView(new RedirectView("/gifts/choose/"+categories.getCandies().getId(), true, true));
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
        
        model.put("p", p);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        // current order
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        /* get selling products */
        List<Integer> sellId = scalarService.getBestSellingProducts();
        List<VatgiaProduct> bestSelling = this.vgpService.findById(sellId);
        if(bestSelling!=null){
            // add number of purchases
            bestSelling.forEach(b -> {b.setPurchases(scalarService.countPurchases(b.getId()));});
        }
        
        model.put(LiXiConstants.BEST_SELLING_PRODUCTS, bestSelling);
        model.put(LiXiConstants.TOPUP_PURCHASES, scalarService.countTopUp());
        
        // store category id into session
        LixiCategory lxcategory = this.lxCategoryService.findByVatgiaCategory(this.vgcService.findOne(p.getCategoryId()));
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, lxcategory.getId());
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_NAME, lxcategory.getName(LocaleContextHolder.getLocale()));
        
        return new ModelAndView("giftprocess2/giftDetail");
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @RequestMapping(value = "choose", method = RequestMethod.GET)
    public ModelAndView chooseGift(Map<String, Object> model, HttpServletRequest request){
        /* default category is candies */
        return new ModelAndView(new RedirectView("/gifts/choose/"+categories.getCandies().getId(), true, true));
    }
    
    
    /**
     * @param model
     * @param selectedCatId 
     * @param request
     * @return 
     */
    @RequestMapping(value = "choose/{selectedCatId}", method = RequestMethod.GET)
    public ModelAndView chooseGift(Map<String, Object> model, @PathVariable Integer selectedCatId, HttpServletRequest request){
        
        // load list products
        LixiCategory lxcategory = categories.getById(selectedCatId);
        
        if(lxcategory == null) lxcategory = categories.getCandies();
        
        // store category id into session
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID, lxcategory.getId());
        request.getSession().setAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_NAME, lxcategory.getName(LocaleContextHolder.getLocale()));
        
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
        /* store new value into session */
        request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND, price);
        request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_IN_USD, LiXiConstants.MINIMUM_PRICE_USD);
        
        /* list product */
        List<VatgiaProduct> products = null;
        /* zero-based page index */
        Pageable page = new PageRequest(0, LiXiConstants.NUM_PRODUCTS_PER_PAGE, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));

        Page<VatgiaProduct> vgps = this.vgpService.findByCategoryIdAndAliveAndPrice(lxcategory.getVatgiaId().getId(), 1, price, page);
        if(vgps.hasContent()){
            products = vgps.getContent();
        }
        
        /* get start slide price */
        double firstPrice = 0;
        final int slideStep = 5;
        if(products!=null && !products.isEmpty()){
            firstPrice = products.get(0).getPriceInUSD(lxExch.getBuy());
        }
        
        int startSlidePrice = ((int)firstPrice/slideStep)*slideStep;
        //log.info("startSlidePrice:" + startSlidePrice);
        if(startSlidePrice < LiXiConstants.MINIMUM_PRICE_USD){
            startSlidePrice = LiXiConstants.MINIMUM_PRICE_USD;
        }else
            if(startSlidePrice > LiXiConstants.MAXIMUM_PRICE_USD){
                startSlidePrice = LiXiConstants.MAXIMUM_PRICE_USD;
            }
        
        model.put(LiXiConstants.SLIDE_START_PRICE, startSlidePrice);
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        // current total order
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/select-gifts", model);

    }
}
