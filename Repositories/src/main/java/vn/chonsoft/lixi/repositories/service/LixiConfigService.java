/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.LixiConfig;

/**
 *
 * @author chonnh
 */
public interface LixiConfigService {
    
    LixiConfig save(LixiConfig config);
            
    void delete(Integer id);
    
    List<LixiConfig> findAll();
    
    LixiConfig findByName(String name);
    LixiConfig findById(Integer id);
}
