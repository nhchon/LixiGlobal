/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.AuthorizeCustomerResult;
import vn.chonsoft.lixi.repositories.AuthorizeCustomerResultRepository;

/**
 *
 * @author chonnh
 */
@Service
public class AuthorizeCustomerResultServiceImpl implements AuthorizeCustomerResultService{

    @Inject
    private AuthorizeCustomerResultRepository repository;
    
    /**
     * 
     * @param customerProfile
     * @return 
     */
    @Override
    public AuthorizeCustomerResult save(AuthorizeCustomerResult customerProfile) {
        
        return this.repository.save(customerProfile);
        
    }
    
    
}
