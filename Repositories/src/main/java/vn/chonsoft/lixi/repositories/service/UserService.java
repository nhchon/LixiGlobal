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
    void save(@NotNull(message = "{validate.userService.save.user}") User user);
    
    @Null(message = "{validate.email.inuse}")
    User checkUniqueEmail(@NotNull(message = "{validate.user.email}") String email);
    
    @NotNull(message = "{validate.userService.login.cannot}")
    User findByEmail(@NotNull(message = "{validate.user.email}") String email);
    
    User findByActiveCode(String code);
    
    int updateEnaled(Boolean enabled, Long id);
    
    int updateActiveCode(String code, Long id);
    
    int updatePassword(String password, Long id);
}
