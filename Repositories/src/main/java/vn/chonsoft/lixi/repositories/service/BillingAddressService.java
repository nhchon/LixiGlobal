/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
@Validated
public interface BillingAddressService {
    
    BillingAddress save(BillingAddress ba);
    
    List<BillingAddress> findByUser(User u);
    
    Page<BillingAddress> findByUser(User u, Pageable p);
}
