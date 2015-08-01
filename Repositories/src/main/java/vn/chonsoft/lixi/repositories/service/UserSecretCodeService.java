/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.validation.constraints.NotNull;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.UserSecretCode;

/**
 *
 * @author chonnh
 */
@Validated
public interface UserSecretCodeService {
    
    void save(@NotNull(message = "{validate.thethingtosavemustnotbenull}") UserSecretCode usc);
    
    void delete(Long id);
    
    UserSecretCode findByCode(String code);
}
