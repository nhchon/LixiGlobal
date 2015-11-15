/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.support.CustomerComment;
import vn.chonsoft.lixi.repositories.CustomerCommentRepository;

/**
 *
 * @author chonnh
 */
@Service
public class CustomerCommentServiceImpl implements CustomerCommentService{
    
    @Inject
    private CustomerCommentRepository repository;

    /**
     * 
     * @param comment
     * @return 
     */
    @Override
    @Transactional
    public CustomerComment save(CustomerComment comment) {
        
        return this.repository.save(comment);
        
    }
}
