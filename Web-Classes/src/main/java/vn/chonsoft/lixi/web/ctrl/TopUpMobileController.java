/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl;

import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.repositories.service.LixiCategoryService;
import vn.chonsoft.lixi.repositories.service.LixiExchangeRateService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.repositories.service.VtcServiceCodeService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping("topUp")
public class TopUpMobileController {
    
    private static final Logger log = LogManager.getLogger(TopUpMobileController.class);

    @Inject
    private UserService userService;
    
    @Inject
    private LixiOrderService lxorderService;
    
    @Inject
    private LixiExchangeRateService lxexrateService;

    @Inject
    private LixiCategoryService lxcService;
    
    @Inject
    private VtcServiceCodeService vtcServiceCodeService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView show(Map<String, Object> model, HttpServletRequest request){
        
        // check login
        if (!LiXiUtils.isLoggined(request)) {

            return new ModelAndView(new RedirectView("/user/signIn?signInFailed=1", true, true));

        }
        
        // for debug: what is in model
        if(model.isEmpty()){
            System.out.println("Wow ! It's empty");
        }
        for (Map.Entry<String, Object> entry : model.entrySet())
        {
            System.out.println(entry.getKey() + "/" + entry.getValue());
        }
        
        // sender
        String email = (String) request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL);
        User u = this.userService.findByEmail(email);
        
        // sort categories
        Sort sort = new Sort(new Sort.Order(Sort.Direction.DESC, "activated"), 
                            new Sort.Order(Sort.Direction.ASC, "sortOrder"));
        List<LixiCategory> categories = this.lxcService.findByLocaleCode(LocaleContextHolder.getLocale().toString(), sort);
        // get exchange rate
        LixiOrder order = null;
        // check order already created
        if (request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID) != null) {

            Long orderId = (Long) request.getSession().getAttribute(LiXiConstants.LIXI_ORDER_ID);

            order = this.lxorderService.findById(orderId);

        }
        
        // check current payment <==> maximum payment
        LixiExchangeRate lxExch = null;
        //double buy = lxExch.getBuy();
        if(order != null){
            
            // get buy from order
            lxExch = order.getLxExchangeRate();
        }
        else{
            // get latest from database
            lxExch = this.lxexrateService.findLastRecord(LiXiConstants.USD);
        }
        
        model.put(LiXiConstants.LIXI_EXCHANGE_RATE, lxExch);
        model.put(LiXiConstants.LIXI_CATEGORIES, categories);
        model.put(LiXiConstants.PHONE_COMPANIES, this.vtcServiceCodeService.findAll());
        
        return new ModelAndView("topup/topup", model);
    }
}
