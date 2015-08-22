/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
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
    
}
