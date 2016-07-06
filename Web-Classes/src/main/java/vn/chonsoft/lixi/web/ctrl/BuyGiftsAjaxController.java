/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.MoneyLevel;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.MoneyLevelService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VatgiaCategoryService;
import vn.chonsoft.lixi.repositories.service.VatgiaProductService;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.beans.CategoriesBean;
import vn.chonsoft.lixi.web.beans.LoginedUser;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author Asus
 */
@WebController
@RequestMapping("gifts/ajax")
public class BuyGiftsAjaxController {
    
    private static final Logger log = LogManager.getLogger(BuyGiftsAjaxController.class);
    
    /* session bean - Login user */
    @Autowired
    private LoginedUser loginedUser;
    
    @Autowired
    private CategoriesBean categories;
    
    @Autowired
    private UserService userService;

    @Autowired
    private RecipientService reciService;

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
    
    @Autowired
    private VatgiaCategoryService vgcService;

    @Autowired
    private LiXiVatGiaUtils lxVatGiaUtils;
    
    @Autowired
    private MoneyLevelService moneyLevelService;
    
    /**
     * 
     * @param model
     * @param productId
     * @param quantity
     * @param request
     * @return 
     */
    @RequestMapping(value = "checkExceed/{recId}/{productId}/{quantity}", method = RequestMethod.GET)
    public ModelAndView checkExceed(Map<String, Object> model, @PathVariable Long recId, @PathVariable Integer productId, @PathVariable Integer quantity, HttpServletRequest request){
        
        User u = null;
        LixiOrder order = null;
        MoneyLevel ml = null;
        LixiExchangeRate lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        double buy = lxExch.getBuy();
        SumVndUsd[] currentPayments = new SumVndUsd[]{new SumVndUsd(), new SumVndUsd(), new SumVndUsd(), new SumVndUsd()};
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
            
            model.put(LiXiConstants.EXCEEDED_VND, exceededPaymentVND);
            
            model.put(LiXiConstants.EXCEEDED_USD, exceededPaymentUSD);
         
        }
        else{
            // the order is not exceeded
            model.put("exceed", 0);
        }
        
        model.put(LiXiConstants.SELECTED_PRODUCT_ID, productId);
        model.put(LiXiConstants.SELECTED_PRODUCT_QUANTITY, quantity);
        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currPaymentVnd);
        
        return new ModelAndView("giftprocess2/exceed", model);
    }
    
    /**
     * 
     * @param model
     * @param pageNum
     * @param startPrice
     * @param request
     * @return 
     */
    @RequestMapping(value = "loadProductsByNewPrice/{pageNum}/{startPrice}", method = RequestMethod.GET)
    public ModelAndView loadProductsByNewPrice(Map<String, Object> model, @PathVariable Integer pageNum, @PathVariable Integer startPrice,  HttpServletRequest request) {
        
        /* get selected category from session */
        Integer selectedCatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID);
        
        if(selectedCatId==null){
            selectedCatId = categories.getCandies().getId();
        }
        
        /* get category object */
        LixiCategory lxcategory = categories.getById(selectedCatId);
        
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
        double price = startPrice * lxExch.getBuy();
        /* store new value into session */
        request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_IN_VND, price);
        request.getSession().setAttribute(LiXiConstants.SELECTED_AMOUNT_IN_USD, startPrice);
        
        List<VatgiaProduct> products = null;
        /* zero-based page index */
        Pageable page = new PageRequest(pageNum-1, LiXiConstants.NUM_PRODUCTS_PER_PAGE, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        
        Page<VatgiaProduct> vgps = this.vgpService.findByCategoryIdAndAliveAndPrice(lxcategory.getVatgiaId().getId(), 1, price, page);
        if(vgps.hasContent()){
            products = vgps.getContent();
        }
        
        // still null ?
        if(products == null || products.isEmpty()){
            // call BaoKim Rest service
            log.info("No products in database. So call BaoKim Rest service");
            ListVatGiaProduct pjs = lxVatGiaUtils.getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
            products = lxVatGiaUtils.convertVatGiaProduct2Model(pjs);
        }
        
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        //model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/ajax-products-2", model);
        
    }
    
    /**
     * 
     * @param model
     * @param pageNum
     * @param request
     * @return 
     */
    @RequestMapping(value = "products/{pageNum}", method = RequestMethod.GET)
    public ModelAndView getProducts(Map<String, Object> model, @PathVariable Integer pageNum,  HttpServletRequest request) {
        
        /* get selected category from session */
        Integer selectedCatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID);
        if(selectedCatId==null){
            selectedCatId = categories.getCandies().getId();
        }
        
        /* get category object */
        LixiCategory lxcategory = categories.getById(selectedCatId);
        
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
        }
        
        log.info("Price: " + price);
        
        List<VatgiaProduct> products = null;
        /* zero-based page index */
        Pageable page = new PageRequest(pageNum-1, LiXiConstants.NUM_PRODUCTS_PER_PAGE, new Sort(new Sort.Order(Sort.Direction.ASC, "price")));
        
        Page<VatgiaProduct> vgps = this.vgpService.findByCategoryIdAndAliveAndPrice(lxcategory.getVatgiaId().getId(), 1, price, page);
        if(vgps.hasContent()){
            products = vgps.getContent();
        }
        
        // still null ?
        if(products == null || products.isEmpty()){
            // call BaoKim Rest service
            log.info("No products in database. So call BaoKim Rest service");
            ListVatGiaProduct pjs = lxVatGiaUtils.getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
            products = lxVatGiaUtils.convertVatGiaProduct2Model(pjs);
        }
        
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/ajax-products-2", model);
        
    }
    
}
