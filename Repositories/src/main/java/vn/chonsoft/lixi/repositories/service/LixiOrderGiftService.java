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
    
    int updateProductIdAndPrice(int productId, double productPrice, Long id);
    
    LixiOrderGift save (LixiOrderGift gift);
    
    List<LixiOrderGift> save(List<LixiOrderGift> gifts);
    
    void delete(LixiOrderGift gift);
    
    void delete(Long id);
    
    void deleteByOrderAndProductId(LixiOrder order, int productId);
    
    Long deleteByOrderAndRecipient(LixiOrder order, Recipient recipient);
    
    List<LixiOrderGift> findByOrderAndRecipient(LixiOrder order, Recipient recipient);
    
    List<LixiOrderGift> findByRecipientEmailAndBkStatus(String recipientEmail, String bkStatus);
    
    List<LixiOrderGift> findByRecipientEmailAndBkStatusIn(String recipientEmail, Iterable<String> bkStatus);
    
    List<LixiOrderGift> findByRecipientEmailAndBkStatusAndBkReceiveMethod(String recipientEmail, String bkStatus, String bkReceiveMethod);
    
    List<LixiOrderGift> findByBkStatusAndBkReceiveMethod(String bkStatus, String bkReceiveMethod);
    
    List<LixiOrderGift> findByBkReceiveMethodAndBkStatusIn(String bkReceiveMethod, Iterable<String> bkStatus);
    
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
    
    LixiOrderGift findByOrderAndRecipientAndProductId(LixiOrder order, Recipient recipient, Integer productId);
}
