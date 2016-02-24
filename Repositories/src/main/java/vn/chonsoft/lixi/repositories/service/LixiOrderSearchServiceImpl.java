/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.repositories.search.LixiOrderSearchRepository;
import vn.chonsoft.lixi.repositories.search.SearchCriteria;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class LixiOrderSearchServiceImpl implements LixiOrderSearchService{

    @Autowired
    LixiOrderSearchRepository searchRepository;
    
    /**
     * 
     * @param searchCriteria
     * @param pageable
     * @return 
     */
    @Override
    @Transactional
    public Page<LixiOrder> search(SearchCriteria searchCriteria, Pageable pageable) {
        
        Page<LixiOrder> ps = this.searchRepository.search(searchCriteria, pageable);
        
        if(ps != null && ps.hasContent()){
            ps.getContent().forEach((LixiOrder o) -> {
                
                LiXiRepoUtils.loadOrder(o);
            });
        }
        
        return ps;
    }
    
}
