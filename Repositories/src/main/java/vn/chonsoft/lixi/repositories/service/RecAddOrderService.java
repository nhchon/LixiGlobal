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
    
    List<RecAddOrder> findByAddId(Long addId);
    
    RecAddOrder save(RecAddOrder rao);
    
}
