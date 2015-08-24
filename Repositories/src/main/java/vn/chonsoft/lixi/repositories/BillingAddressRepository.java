/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
public interface BillingAddressRepository extends JpaRepository<BillingAddress, Long>{
   
    BillingAddress findByIdAndUser(Long id, User u);
    
    List<BillingAddress> findByUser(User u);
    
    Page<BillingAddress> findByUser(User u, Pageable p);
            
}
