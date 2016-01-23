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
    
    @Async
    void submitOrdersToBaoKim(LixiOrder order);
    
    @Async
    void processTopUpItems(LixiOrder order);
    
    @Async
    String processTopUpItem(TopUpMobilePhone topUp);
    
    String processTopUpItemNoAsync(TopUpMobilePhone topUp);
    
    @Async
    void processBuyCardItems(LixiOrder order);
}
