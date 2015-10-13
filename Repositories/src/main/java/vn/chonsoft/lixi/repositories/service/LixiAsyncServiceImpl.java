/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;

/**
 *
 * @author chonnh
 */
@Service
public class LixiAsyncServiceImpl implements LixiAsyncService{

    @Inject
    private LixiOrderService orderService;
    
    @Inject
    private LixiOrderGiftService orderGiftService;
    
    /**
     * 
     * @param order 
     */
    @Override
    @Async
    public void submitOrdersToBaoKim(LixiOrder order) {
        
        LiXiVatGiaUtils.getInstance().submitOrdersToBaoKim(order, orderService, orderGiftService);
        
    }
    
    
}
