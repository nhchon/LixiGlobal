/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;

/**
 *
 * @author chonnh
 */
@Validated
public interface UserBankAccountService {
    
    UserBankAccount save (UserBankAccount ubc);
    
    UserBankAccount findById(Long id);
    
    List<UserBankAccount> findByUser(User u);
    
}
