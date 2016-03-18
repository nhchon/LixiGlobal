/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.Date;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.LixiBatch;

/**
 *
 * @author Asus
 */
public interface LixiBatchRepository  extends JpaRepository<LixiBatch, Long>{
    
    Page<LixiBatch> findByCreatedDateBetween(Date begin, Date end, Pageable page);
    
}
