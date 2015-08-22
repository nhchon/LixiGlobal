/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
@Validated
public interface UserService {
    
    User save(@NotNull(message = "{validate.userService.save.user}") User user);
    
    @Null(message = "{validate.email.inuse}")
    User checkUniqueEmail(@NotNull(message = "{validate.user.email}") String email);
    
    User findByEmail(@NotNull(message = "{validate.user.email}") String email);
    
    int updateEnaled(Boolean enabled, Long id);

    int updateActivated(Boolean activated, Long id);
    
    int updatePassword(String password, Long id);
    
    int updateEmail(String email, Long id);
    
    int updatePhoneNumber(String phoneNumber, Long id);
}
