/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;

/**
 *
 * @author chonnh
 */
@Validated
public interface LixiOrderGiftService {
    
    int updateProductIdAndPrice(int productId, float productPrice, Long id);
    
    LixiOrderGift save (LixiOrderGift gift);
    
    List<LixiOrderGift> save(List<LixiOrderGift> gifts);
    
    void delete(LixiOrderGift gift);
    
    void delete(Long id);
    
    LixiOrderGift findByOrderAndRecipient(LixiOrder order, Recipient recipient);
    
    LixiOrderGift findById(Long id);
    
    /**
     * 
     * confirm oder gift belong to order
     * 
     * @param id
     * @param order
     * @return 
     */
    LixiOrderGift findByIdAndOrder(Long id, LixiOrder order);
}
