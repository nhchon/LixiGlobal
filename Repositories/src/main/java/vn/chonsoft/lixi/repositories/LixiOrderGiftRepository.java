/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;

/**
 *
 * @author chonnh
 */
public interface LixiOrderGiftRepository extends JpaRepository<LixiOrderGift, Long>{
    
    @Modifying
    @Transactional
    @Query("update LixiOrderGift p set p.productId = :productId, p.productPrice = :productPrice where p.id = :id")
    int updateProductIdAndPrice(@Param("productId") int productId, @Param("productPrice") double productPrice, @Param("id") Long id);
    
    Long deleteByOrderAndProductId(LixiOrder order, int productId);
    
    Long deleteByOrderAndRecipient(LixiOrder order, Recipient recipient);
    
    List<LixiOrderGift> findByOrderAndRecipient(LixiOrder order, Recipient recipient);
    
    List<LixiOrderGift> findByRecipientEmailAndBkStatus(String recipientEmail, String bkStatus);
    
    List<LixiOrderGift> findByRecipientEmailAndBkStatusIn(String recipientEmail, Iterable<String> bkStatus);
    
    List<LixiOrderGift> findByRecipientEmailAndBkStatusAndBkReceiveMethod(String recipientEmail, String bkStatus, String bkReceiveMethod);
    
    LixiOrderGift findByIdAndOrder(Long id, LixiOrder order);
    
    LixiOrderGift findByOrderAndRecipientAndProductId(LixiOrder order, Recipient recipient, Integer productId);
}
