/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.Country;
import vn.chonsoft.lixi.model.LixiGlobalFee;

/**
 *
 * @author chonnh
 */
public interface LixiGlobalFeeRepository extends JpaRepository<LixiGlobalFee, Long>{
    
    List<LixiGlobalFee> findByCountry(Country country, Sort sort);
    
}
