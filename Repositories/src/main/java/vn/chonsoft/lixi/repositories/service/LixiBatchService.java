/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.Date;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiBatch;

/**
 *
 * @author Asus
 */
public interface LixiBatchService {
    
    LixiBatch save(LixiBatch b);
    
    @Transactional
    LixiBatch findById(Long id);
    
    @Transactional
    Page<LixiBatch> findByCreatedDate(Date begin, Date end, Pageable page);
}
