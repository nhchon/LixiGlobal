/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.repositories.CustomerProblemRepository;

/**
 *
 * @author chonnh
 */
@Service
public class CustomerProblemServiceImpl implements CustomerProblemService{

    @Inject
    private CustomerProblemRepository repository;
    
    /**
     * 
     * @param problem
     * @return 
     */
    @Override
    @Transactional
    public CustomerProblem save(CustomerProblem problem) {
        
        return this.repository.save(problem);
        
    }
    
    
}
