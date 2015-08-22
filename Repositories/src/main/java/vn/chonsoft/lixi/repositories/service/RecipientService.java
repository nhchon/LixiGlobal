/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.Recipient;

/**
 *
 * @author chonnh
 */
@Validated
public interface RecipientService {
    
    Recipient save(Recipient rec);
    
    Recipient findById(Long id);
    
    int updatePhone(String phone, Long id);
}
