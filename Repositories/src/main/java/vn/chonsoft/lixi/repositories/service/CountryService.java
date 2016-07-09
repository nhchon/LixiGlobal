/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.Country;

/**
 *
 * @author chonnh
 */
public interface CountryService {
    
    Country findById(Long id);
    
    Country findByName(String name);
    
    Country findByCode(String code);
    
    @Transactional
    List<Country> findAll();
}
