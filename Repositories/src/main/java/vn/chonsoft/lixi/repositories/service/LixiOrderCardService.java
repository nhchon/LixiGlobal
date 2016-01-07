/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrderCard;

/**
 *
 * @author chonnh
 */
public interface LixiOrderCardService {
    
    LixiOrderCard save(LixiOrderCard card);
    
    @Transactional
    LixiOrderCard findById(Long id);
}
