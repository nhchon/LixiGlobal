/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserCard;

/**
 *
 * @author chonnh
 */
@Validated
public interface UserCardService {
    
    UserCard save(UserCard uc);
    
    void delete(Long id);
    
    UserCard findById(Long id);
    
    List<UserCard> findByUser(User u);
    
    UserCard findByIdAndUser(Long id, User u);
    
    UserCard findByCardNumber(String cardNumber);
    
    int updateAuthorizeProfileId(String paymentId, Long id);
}
