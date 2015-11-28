/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.model.support.CustomerProblemManagement;
import vn.chonsoft.lixi.model.support.CustomerProblemStatus;
import vn.chonsoft.lixi.repositories.CustomerProblemManagementRepository;

/**
 *
 * @author chonnh
 */
@Service
public class CustomerProblemManagementServiceImpl implements CustomerProblemManagementService{
    
    @Autowired
    private CustomerProblemManagementRepository repository;

    /**
     * 
     * @param cpm
     * @return 
     */
    @Override
    @Transactional
    public CustomerProblemManagement save(CustomerProblemManagement cpm){
        
        return this.repository.save(cpm);
        
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public CustomerProblemManagement find(Long id){
        
        return this.repository.findOne(id);
        
    }
    
    /**
     * 
     * @param problem
     * @return 
     */
    @Override
    public CustomerProblemManagement findByProblem(CustomerProblem problem){
        
        return this.repository.findByProblem(problem);
        
    }
    /**
     * 
     * @param page
     * @return 
     */
    @Override
    public Page<CustomerProblemManagement> findAll(Pageable page) {
        
        return this.repository.findAll(page);
    }

    /**
     * 
     * @param handler
     * @param page
     * @return 
     */
    @Override
    public Page<CustomerProblemManagement> findByHandler(String handler, Pageable page) {
        
        Page<CustomerProblemManagement> l = this.repository.findByHandledBy(handler, page);
        /* assurance */
        l.getContent().forEach(x -> {x.getProblem();});
        
        /* */
        return l;
    }
    
    /**
     * 
     * @param status
     * @param handler 
     * @param page
     * @return 
     */
    @Override
    public Page<CustomerProblemManagement> findByStatusAndHandler(CustomerProblemStatus status, String handler, Pageable page){
        
        return this.repository.findByProblem_StatusAndHandledBy(status, handler, page);
        
    }
}
