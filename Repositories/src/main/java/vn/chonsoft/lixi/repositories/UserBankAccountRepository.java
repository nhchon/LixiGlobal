/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;

/**
 *
 * @author chonnh
 */
public interface UserBankAccountRepository  extends JpaRepository<UserBankAccount, Long>{
    
    List<UserBankAccount> findByUser(User u);
}