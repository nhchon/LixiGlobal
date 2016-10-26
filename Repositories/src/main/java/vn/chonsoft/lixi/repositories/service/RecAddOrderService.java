/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.RecAddOrder;

/**
 *
 * @author Asus
 */
public interface RecAddOrderService {
    
    List<RecAddOrder> findByRecEmailAndAddIdAndOrderId(String recEmail, Long addId, Long orderId);
    
    List<RecAddOrder> findByOrderIdAndRecEmail(Long orderId, String recEmail);
    
    List<RecAddOrder> findByAddId(Long addId);
    
    List<RecAddOrder> findByAddIdAndOrderId(Long addId, Long orderId);
    
    RecAddOrder save(RecAddOrder rao);
    
}
