/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;

/**
 *
 * @author chonnh
 */
public interface TopUpMobilePhoneRepository  extends JpaRepository<TopUpMobilePhone, Long>{
    
    List<TopUpMobilePhone> findByIsSubmittedIn(Iterable<Integer> isSubmitted, Sort sort);
    
    Long deleteByOrderAndRecipient(LixiOrder order, Recipient recipient);
}
