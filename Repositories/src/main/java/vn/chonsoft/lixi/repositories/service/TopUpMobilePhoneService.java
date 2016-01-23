/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;

/**
 *
 * @author chonnh
 */
@Validated
public interface TopUpMobilePhoneService {
    
    TopUpMobilePhone save(TopUpMobilePhone topUp);
    
    @Transactional
    TopUpMobilePhone findById(Long id);
    
    @Transactional
    List<TopUpMobilePhone> findByIsSubmitted(Iterable<Integer> isSubmitted);
            
    void deleteById(Long id);
    
    @Transactional
    Long deleteByOrderAndRecipient(LixiOrder order, Recipient recipient);
}
