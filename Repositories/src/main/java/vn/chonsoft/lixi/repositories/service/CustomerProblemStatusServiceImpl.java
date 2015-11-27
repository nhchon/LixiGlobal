/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.support.CustomerProblemStatus;
import vn.chonsoft.lixi.repositories.CustomerProblemStatusRepository;

/**
 *
 * @author chonnh
 */
@Service
public class CustomerProblemStatusServiceImpl implements CustomerProblemStatusService{
    
    @Autowired
    private CustomerProblemStatusRepository repository;

    /**
     * 
     * @return 
     */
    @Override
    public List<CustomerProblemStatus> findAll() {
        
        return this.repository.findAll();
        
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public CustomerProblemStatus findById(Long id){
        
        return this.repository.findOne(id);
        
    }
    
    /**
     * 
     * code is unique
     * 
     * @param code
     * @return 
     */
    @Override
    public CustomerProblemStatus findByCode(Integer code){
        
        return this.repository.findByCode(code);
        
    }
}
