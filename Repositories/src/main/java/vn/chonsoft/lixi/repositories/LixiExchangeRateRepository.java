/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.LixiExchangeRate;

/**
 *
 * @author chonnh
 */
public interface LixiExchangeRateRepository  extends JpaRepository<LixiExchangeRate, Long>{
    
    Page<LixiExchangeRate> findByCurrency_Code(String code, Pageable p);
    
}
