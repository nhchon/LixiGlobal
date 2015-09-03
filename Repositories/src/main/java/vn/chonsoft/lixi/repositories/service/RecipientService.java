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
    
    Recipient findByFirstNameAndMiddleNameAndLastNameAndPhone(String firstName, String middleName, String lastName, String phone);
    
    int updatePhone(String phone, Long id);
    
    int updateEmail(String email, Long id);
}
