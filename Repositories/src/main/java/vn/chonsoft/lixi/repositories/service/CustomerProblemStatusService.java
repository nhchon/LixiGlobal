/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.support.CustomerProblemStatus;

/**
 *
 * @author chonnh
 */
public interface CustomerProblemStatusService {
    
    List<CustomerProblemStatus> findAll();
    
    CustomerProblemStatus findById(Long id);
    
    CustomerProblemStatus findByCode(Integer code);
}
