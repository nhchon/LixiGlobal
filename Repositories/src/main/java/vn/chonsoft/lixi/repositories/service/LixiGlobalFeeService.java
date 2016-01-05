/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.data.domain.Sort;
import vn.chonsoft.lixi.model.Country;
import vn.chonsoft.lixi.model.LixiGlobalFee;

/**
 *
 * @author chonnh
 */
public interface LixiGlobalFeeService {
    
    LixiGlobalFee save(LixiGlobalFee fee);
    
    void delete(Long id);
    
    List<LixiGlobalFee> findByCountry(Country country);
    
    List<LixiGlobalFee> findByCountry(Country country, Sort sort);
}
