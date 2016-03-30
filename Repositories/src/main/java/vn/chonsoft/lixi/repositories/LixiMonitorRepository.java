/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.LixiMonitor;

/**
 *
 * @author Asus
 */
public interface LixiMonitorRepository extends JpaRepository<LixiMonitor, Long>{
    
    List<LixiMonitor> findByProcessed(Integer processed);
}
