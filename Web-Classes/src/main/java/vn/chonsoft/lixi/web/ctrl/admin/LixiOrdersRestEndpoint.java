/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.ctrl.admin;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.form.BaoKimStatusForm;
import vn.chonsoft.lixi.model.pojo.LixiSimpleMessage;
import vn.chonsoft.lixi.repositories.service.LixiOrderGiftService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.web.annotation.RestEndpoint;
import vn.chonsoft.lixi.web.beans.LixiAsyncMethods;

/**
 *
 * @author chonnh
 */
@RestEndpoint
public class LixiOrdersRestEndpoint {
    
    private static final Logger log = LogManager.getLogger(LixiOrdersRestEndpoint.class);
    
    @Autowired
    private LixiOrderService lxOrderService;
    
    @Autowired
    private LixiOrderGiftService lxgiftService;

    @Autowired
    private MessageSource messageSource;
    
    @Autowired
    private LixiAsyncMethods lxAsyncMethods;
    
    /**
     * 
     * @param form
     * @return 
     */
    @RequestMapping(value = "bkUpdateStatus", method = RequestMethod.POST)
    public ResponseEntity<LixiSimpleMessage> bkUpdateStatus(@RequestBody BaoKimStatusForm form){
        
        LixiSimpleMessage message = new LixiSimpleMessage();
        
        LixiOrderGift gift = this.lxgiftService.findById(form.getOrderId());
        
        log.info("bkUpdateStatus:" + form.toString());
        
        if(gift != null){
            gift.setBkStatus(form.getStatus());
            gift.setBkMessage(form.getMessage());
            gift.setBkReceiveMethod(form.getReceiveMethod());
            gift.setBkUpdated(form.getUpdatedOn());
            
            // set lixi_margined
            if(EnumLixiOrderSetting.ALLOW_REFUND.getValue()==gift.getOrder().getSetting()
                    // gifted for allow refund order
                    && LiXiGlobalConstants.BAOKIM_GIFT_METHOD.equals(gift.getBkReceiveMethod())){
                /* for calculating gift margined */
                gift.setLixiMargined(false);
            }
            
            this.lxgiftService.save(gift);
            
            message.setError("0");
            message.setMessage(messageSource.getMessage("message.success", new Object[0], LocaleContextHolder.getLocale()));
            
            /* */
            try {
                lxAsyncMethods.updateLixiOrderStatus(gift.getOrder().getId(), form.getStatus());
            } catch (Exception e) {
                log.info("Rest updateLixiOrder:", e);
            }
        }
        else{
            message.setError("1");
            message.setMessage(messageSource.getMessage("validate.there_is_something_wrong", new Object[0], LocaleContextHolder.getLocale()));
        }
        
        return new ResponseEntity<>(message, HttpStatus.OK);
    }    
}
