/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import org.springframework.scheduling.annotation.Async;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.TopUpMobilePhone;

/**
 *
 * @author chonnh
 */
public interface LixiAsyncMethods {
    
    String processTopUpItemNoAsync(TopUpMobilePhone topUp);
    
    boolean reSubmitOrdersToBaoKimNoAsync(LixiOrder order);
    
    void submitOrdersToBaoKimNoAsync(LixiOrder order);
            
    boolean cancelOrdersOnBaoKimNoAsync(LixiOrder order);
            
    @Async
    boolean cancelOrdersOnBaoKim(LixiOrder order);
    
    boolean sendPaymentInfoToBaoKim(LixiOrder order);
    
    boolean checkBaoKimSystem();
    
    @Async
    void updateLixiOrderStatus(Long lixiOrderId, String status);
    
    @Async
    void submitOrdersToBaoKim(LixiOrder order);
    
    @Async
    void processTopUpItems(LixiOrder order);
    
    @Async
    String processTopUpItem(TopUpMobilePhone topUp);
    
    @Async
    void processBuyCardItems(LixiOrder order);
    
    @Async
    void cashRunTransactionStatusUpdate(String userAgent, long invoiceId, long orderId, String amount, String currency);
}
