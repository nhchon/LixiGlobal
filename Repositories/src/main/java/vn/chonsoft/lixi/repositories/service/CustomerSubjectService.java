/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.support.CustomerSubject;

/**
 *
 * @author chonnh
 */
public interface CustomerSubjectService {
    
    CustomerSubject save(CustomerSubject sub);
    
    CustomerSubject findOne(Long id);
    
    List<CustomerSubject> findAll();
    
}
