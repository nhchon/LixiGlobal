/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.support.CustomerProblemManagement;
import vn.chonsoft.lixi.model.support.CustomerProblemStatus;

/**
 *
 * @author chonnh
 */
public interface CustomerProblemManagementRepository extends JpaRepository<CustomerProblemManagement, Long> {
    
    Page<CustomerProblemManagement> findByHandledBy(String handleBy, Pageable page);
    
    Page<CustomerProblemManagement> findByProblem_StatusAndHandledBy(CustomerProblemStatus status, String handleBy, Pageable page);
    
}
