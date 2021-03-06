/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.model.support.CustomerProblemStatus;
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
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public CustomerProblem findOne(Long id){
        
        CustomerProblem prob = this.repository.findOne(id);
        /* load comments*/
        prob.getComments().size();
        
        return prob;
        
    }
    /**
     * 
     * @return 
     */
    @Override
    @Transactional
    public List<CustomerProblem> findAll(){
        
        List<CustomerProblem> list = this.repository.findAll();
        /* load comments */
        list.forEach(x -> {x.getComments().size();});
        
        return list;
    }
    
    /**
     * 
     * @param status
     * @param page
     * @return 
     */
    @Override
    public Page<CustomerProblem> findByStatus(CustomerProblemStatus status, Pageable page){
        
        return this.repository.findByStatus(status, page);
    }
    
    /**
     * 
     * @param status
     * @return 
     */
    @Override
    public List<CustomerProblem> findByStatus(CustomerProblemStatus status){
        
        return this.repository.findByStatus(status);
    }
}
