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
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserCard;

/**
 *
 * @author chonnh
 */
public interface UserCardRepository  extends JpaRepository<UserCard, Long>{
    
    List<UserCard> findByUser(User u);
    
    /**
     * 
     * Used to check the card belong to user
     * 
     * @param id
     * @param u
     * @return 
     */
    UserCard findByIdAndUser(Long id, User u);
    
    UserCard findByCardNumber(String cardNumber);
    
    /**
     * 
     * @param paymentId
     * @param id
     * @return 
     */
    @Modifying
    @Transactional
    @Query("update UserCard c set c.authorizePaymentId = :paymentId where c.id = :id")
    int updateAuthorizeProfileId(@Param("paymentId") String paymentId, @Param("id") Long id);
    
}
