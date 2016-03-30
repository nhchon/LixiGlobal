/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiMonitor;

/**
 *
 * @author Asus
 */
public interface LixiMonitorService {
    
    LixiMonitor save(LixiMonitor m);
    
    LixiMonitor find(Long id);
    
    @Transactional
    List<LixiMonitor> findByProcessed(Integer processed);
}
