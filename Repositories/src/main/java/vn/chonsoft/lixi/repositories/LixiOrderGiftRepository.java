/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

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
    int updateProductIdAndPrice(@Param("productId") int productId, @Param("productPrice") float productPrice, @Param("id") Long id);
    
    LixiOrderGift findByOrderAndRecipient(LixiOrder order, Recipient recipient);
    
    LixiOrderGift findByIdAndOrder(Long id, LixiOrder order);
}
