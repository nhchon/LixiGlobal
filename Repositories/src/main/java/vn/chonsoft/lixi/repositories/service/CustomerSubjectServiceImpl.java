/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
     * @param sub
     * @return 
     */
    @Override
    @Transactional
    public CustomerSubject save(CustomerSubject sub){
        
        return this.repository.save(sub);
        
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public CustomerSubject findOne(Long id){
        
        return this.repository.findOne(id);
        
    }
    
    /**
     * 
     * @return 
     */
    @Override
    public List<CustomerSubject> findAll() {
        
        return this.repository.findAll();
        
    }
 
    
}
