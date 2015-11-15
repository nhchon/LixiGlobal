/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.support.CustomerProblem;

/**
 *
 * @author chonnh
 */
public interface CustomerProblemService {
    
    @Transactional
    CustomerProblem save(CustomerProblem problem);
    
}
