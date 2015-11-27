/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.chonsoft.lixi.model.support.CustomerProblemManagement;
import vn.chonsoft.lixi.model.support.CustomerProblemStatus;

/**
 *
 * @author chonnh
 */
public interface CustomerProblemManagementService {
    
    CustomerProblemManagement save(CustomerProblemManagement cpm);
    
    CustomerProblemManagement find(Long id);
    
    Page<CustomerProblemManagement> findAll(Pageable page);
    
    Page<CustomerProblemManagement> findByHandler(String handler, Pageable page);
    
    Page<CustomerProblemManagement> findByStatusAndHandler(CustomerProblemStatus reAssigned, String handler, Pageable page);
}
