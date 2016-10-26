/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.RecAddOrder;

/**
 *
 * @author Asus
 */
public interface RecAddOrderRepository extends  JpaRepository<RecAddOrder, Long>{
    
    List<RecAddOrder> findByRecEmailAndAddIdAndOrderId(String recEmail, Long addId, Long orderId);
    
    List<RecAddOrder> findByAddIdAndOrderId(Long addId, Long orderId);
    
    List<RecAddOrder> findByAddId(Long addId);
    
    List<RecAddOrder> findByOrderIdAndRecEmail(Long orderId, String recEmail);
}
