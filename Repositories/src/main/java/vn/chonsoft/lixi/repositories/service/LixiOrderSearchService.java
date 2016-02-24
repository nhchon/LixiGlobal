/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.repositories.search.SearchCriteria;

/**
 *
 * @author chonnh
 */
public interface LixiOrderSearchService {
    
    Page<LixiOrder> search(SearchCriteria searchCriteria, Pageable pageable);
    
}
