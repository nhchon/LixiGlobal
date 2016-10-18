/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.RecBankOrder;

/**
 *
 * @author Asus
 */
public interface RecBankOrderRepository extends  JpaRepository<RecBankOrder, Long>{
    
    List<RecBankOrder> findByBankId(Long bankId);
}
