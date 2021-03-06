/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.validation.constraints.NotNull;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
@Validated
public interface UserService {
    
    User save(@NotNull(message = "{validate.userService.save.user}") User user);
    
    List<User> findAllByEmail(String email);
    
    @Transactional
    Page<User> findByActivated(boolean activated, Pageable page);
    
    User findByEmail(String email, boolean enabled);
    
    User findByEmail(String email);
    
    User findById(Long id);
    
    int updateEnaled(Boolean enabled, Long id);

    int updateActivated(Boolean activated, Long id);
    
    int updatePassword(String password, Long id);
    
    int updateEmail(String email, Long id);
    
    int updatePhoneNumber(String phoneNumber, Long id);
    
    int updateAuthorizeProfileId(String profileId, Long id);
}
