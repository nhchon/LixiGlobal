/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.support.CustomerProblem;
import vn.chonsoft.lixi.model.support.CustomerProblemStatus;

/**
 *
 * @author chonnh
 */
public interface CustomerProblemRepository extends JpaRepository<CustomerProblem, Long> {
    
    List<CustomerProblem> findByStatus(CustomerProblemStatus status);
    
    Page<CustomerProblem> findByStatus(CustomerProblemStatus status, Pageable page);
}
