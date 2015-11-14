/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.support.CustomerSubject;
import vn.chonsoft.lixi.repositories.CustomerSubjectRepository;

/**
 *
 * @author chonnh
 */
@Service
public class CustomerSubjectServiceImpl implements CustomerSubjectService{

    @Inject
    private CustomerSubjectRepository repository;
    
    /**
     * 
     * @return 
     */
    @Override
    public List<CustomerSubject> findAll() {
        
        return this.repository.findAll();
        
    }
 
    
}
