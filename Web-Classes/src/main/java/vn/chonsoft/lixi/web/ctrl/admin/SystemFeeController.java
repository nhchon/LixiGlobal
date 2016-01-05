/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import vn.chonsoft.lixi.model.LixiGlobalFee;
import vn.chonsoft.lixi.repositories.service.CountryService;
import vn.chonsoft.lixi.repositories.service.LixiGlobalFeeService;
import vn.chonsoft.lixi.web.annotation.WebController;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
@WebController
@RequestMapping(value = "/Administration/SystemFee")
public class SystemFeeController {
    
    @Autowired
    private CountryService countryService;
    
    @Autowired
    private LixiGlobalFeeService feeService;
    
    /**
     * 
     * 
     * @param model 
     * @return 
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView list(Map<String, Object> model){
        
        model.put("countries", this.countryService.findAll());
        
        return new ModelAndView("Administration/config/fees");
    }
    
    /**
     * 
     * @param id
     * @param model 
     * @return 
     */
    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public ModelAndView delete(Map<String, Object> model, @PathVariable Long id){
        
        this.feeService.delete(id);
        
        return new ModelAndView(new RedirectView("/Administration/SystemFee/list", true, true));
    }
    
    /**
     * 
     * 
     * @param request 
     * @return 
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ModelAndView save(HttpServletRequest request){
        
        String countryStr = request.getParameter("country");
        String paymentStr = request.getParameter("payment");
        String amountStr = request.getParameter("amount");
        String giftOnlyStr = request.getParameter("giftOnly");
        String allowRefundStr = request.getParameter("allowRefund");
        String maxFeeStr = request.getParameter("maxFee");
        String lixiFeeStr = request.getParameter("lixiFee");
        
        LixiGlobalFee fee = new LixiGlobalFee();
        fee.setCountry(this.countryService.findById(Long.parseLong(countryStr)));
        fee.setPaymentMethod(Integer.parseInt(paymentStr));
        fee.setAmount(LiXiUtils.round2Decimal(Double.parseDouble(amountStr)));
        fee.setGiftOnlyFee(LiXiUtils.round2Decimal(Double.parseDouble(giftOnlyStr)));
        fee.setAllowRefundFee(LiXiUtils.round2Decimal(Double.parseDouble(allowRefundStr)));
        fee.setMaxFee(LiXiUtils.round2Decimal(Double.parseDouble(maxFeeStr)));
        fee.setLixiFee(LiXiUtils.round2Decimal(Double.parseDouble(lixiFeeStr)));
        
        /* save */
        this.feeService.save(fee);
        
        
        return new ModelAndView(new RedirectView("/Administration/SystemFee/list", true, true));
    }
    
    
}
