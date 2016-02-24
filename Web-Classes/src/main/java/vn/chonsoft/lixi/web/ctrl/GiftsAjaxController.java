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
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.RecipientService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VatgiaCategoryService;
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
@RequestMapping("gifts/ajax")
public class GiftsAjaxController {
    
    private static final Logger log = LogManager.getLogger(GiftsAjaxController.class);

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
    /**
     * 
     * Ajax call get products
     * 
     * @param model
     * @param recId 
     * @param pageNum
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "products/{recId}/{pageNum}", method = RequestMethod.GET)
    public ModelAndView getProducts(Map<String, Object> model, @PathVariable Long recId, @PathVariable Integer pageNum,  HttpServletRequest request) {
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        /* get selected category from session */
        Integer selectedCatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID);
        
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
        };
        
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
            ListVatGiaProduct pjs = LiXiVatGiaUtils.getInstance().getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
            products = LiXiVatGiaUtils.getInstance().convertVatGiaProduct2Model(pjs);
        }
        
        if(recId > 0){
            try {
                // get current recipient
                Recipient rec = this.reciService.findById(recId);

                // check selected
                LiXiUtils.checkSelected(products, order, rec);
            } catch (Exception e) {
            }
        }
        
        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/ajax-products", model);
        
    }
    
    /**
     * 
     * Ajax call get products
     * 
     * @param model
     * @param recId 
     * @param pageNum
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "loadProductsByNewPrice/{recId}/{pageNum}/{startPrice}", method = RequestMethod.GET)
    public ModelAndView loadProductsByNewPrice(Map<String, Object> model, @PathVariable Long recId, @PathVariable Integer pageNum, @PathVariable Integer startPrice,  HttpServletRequest request) {
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        /* get selected category from session */
        Integer selectedCatId = (Integer)request.getSession().getAttribute(LiXiConstants.SELECTED_LIXI_CATEGORY_ID);
        
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
            ListVatGiaProduct pjs = LiXiVatGiaUtils.getInstance().getVatGiaProducts(lxcategory.getVatgiaId().getId(), price);
            products = LiXiVatGiaUtils.getInstance().convertVatGiaProduct2Model(pjs);
        }
        
        if(recId > 0){
            try {
                // get current recipient
                Recipient rec = this.reciService.findById(recId);

                // check selected
                LiXiUtils.checkSelected(products, order, rec);
            } catch (Exception e) {
            }
        }

        SumVndUsd[] currentPayment = LiXiUtils.calculateCurrentPayment(order);
        
        model.put(LiXiConstants.PRODUCTS, products);
        model.put(LiXiConstants.PAGES, vgps);
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.USER_MAXIMUM_PAYMENT, u.getUserMoneyLevel().getMoneyLevel());
        model.put(LiXiConstants.CURRENT_PAYMENT, currentPayment[0].getVnd());
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment[0].getUsd());
        
        return new ModelAndView("giftprocess2/ajax-products", model);
        
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
    @UserSecurityAnnotation
    @RequestMapping(value = "checkExceed/{recId}/{productId}/{quantity}", method = RequestMethod.GET)
    public ModelAndView checkExceed(Map<String, Object> model, @PathVariable Long recId, @PathVariable Integer productId, @PathVariable Integer quantity, HttpServletRequest request){
        
        // sender
        User u = this.userService.findByEmail(loginedUser.getEmail());
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        // delet gift if quantity <= 0
        if(quantity <= 0){
            
            this.lxogiftService.deleteByOrderAndProductId(order, productId);
            //re-select order
            order = this.lxorderService.findById(order.getId());
        }

        /* get recipient */
        Recipient rec = this.reciService.findById(recId);
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
        
        RecipientInOrder recInOrder = null;
        SumVndUsd[] currentPayments;
        currentPayments = LiXiUtils.calculateCurrentPayment(order, alreadyGift);
        
        double currentPayment = currentPayments[0].getUsd();//USD
        double currPaymentVnd = currentPayments[0].getVnd();
        if(quantity>0){
            // add selected gift
            currentPayment += (LiXiUtils.toUsdPrice(price, buy) * quantity);
            
            currPaymentVnd += (price * quantity);
        }
        
        if (currentPayment > (u.getUserMoneyLevel().getMoneyLevel().getAmount())) {

            // maximum payment is over
            model.put("exceed", 1);
            
            double exceededPaymentVND = (currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount()) * buy;
            double exceededPaymentUSD = currentPayment - u.getUserMoneyLevel().getMoneyLevel().getAmount();
            
            model.put(LiXiConstants.EXCEEDED_VND, exceededPaymentVND);
            
            model.put(LiXiConstants.EXCEEDED_USD, exceededPaymentUSD);
         
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
            // check the gifts already bought
            if(alreadyGift == null){
                
                // checkbox is checked
                if(quantity > 0){
                    
                    // create the order
                    if(order == null){
                        order = new LixiOrder();
                        order.setSender(u);
                        order.setLxExchangeRate(lxExch);
                        order.setLixiStatus(EnumLixiOrderStatus.UNFINISHED.getValue());
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
                    lxogift.setOrder(order);
                    lxogift.setCategory(this.vgcService.findOne(vgp.getCategoryId()).getLixiCategory());
                    lxogift.setProductId(productId);
                    lxogift.setProductPrice(price);
                    lxogift.setUsdPrice(LiXiUtils.toUsdPrice(price, buy));
                    lxogift.setExchPrice((long)(lxogift.getUsdPrice() * buy));//truncated
                    lxogift.setProductName(vgp.getName());
                    lxogift.setProductImage(vgp.getImageUrl());
                    lxogift.setProductQuantity(quantity);
                    lxogift.setBkStatus(EnumLixiOrderStatus.NOT_YET_SUBMITTED.getValue());// not yet submitted
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
                    alreadyGift.setProductQuantity(quantity);

                    this.lxogiftService.save(alreadyGift);
                }
                else{
                    // remove the gift
                    this.lxogiftService.delete(alreadyGift.getId());
                }
            }
            /* re-calculate recipient's total */
            recInOrder = LiXiUtils.getRecipientInOrder(LiXiUtils.genMapRecGifts(this.lxorderService.findById(order.getId())), recId);
            
        }
        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayment);
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currPaymentVnd);
        
        if(recInOrder != null){
            
            model.put("RECIPIENT_PAYMENT_USD", recInOrder.getAllTotal().getUsd());
            model.put("RECIPIENT_PAYMENT_VND", recInOrder.getAllTotal().getVnd());
            //log.info(currentPayment + " " + recInOrder.getAllTotal().getUsd());
            //log.info((currentPayment * buy) + " " + recInOrder.getAllTotal().getVnd());
        }
        
        return new ModelAndView("giftprocess2/exceed", model);
    }
    
    /**
     * 
     * @param model
     * @param request
     * @return 
     */
    @UserSecurityAnnotation
    @RequestMapping(value = "getTotalCurrentOrder", method = RequestMethod.GET)
    public ModelAndView getTotalCurrentOrder(Map<String, Object> model, HttpServletRequest request){
        
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        SumVndUsd[] currentPayments = LiXiUtils.calculateCurrentPayment(order);
        
        // store current payment
        model.put(LiXiConstants.CURRENT_PAYMENT_USD, currentPayments[0].getUsd());
        model.put(LiXiConstants.CURRENT_PAYMENT_VND, currentPayments[0].getVnd());
        
        return new ModelAndView("giftprocess2/ajax-total");
    }
}
