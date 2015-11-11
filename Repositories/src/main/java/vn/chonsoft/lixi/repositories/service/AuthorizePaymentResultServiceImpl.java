/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.AuthorizePaymentResult;
import vn.chonsoft.lixi.repositories.AuthorizePaymentResultRepository;

/**
 *
 * @author chonnh
 */
@Service
public class AuthorizePaymentResultServiceImpl implements AuthorizePaymentResultService{

    @Inject
    private AuthorizePaymentResultRepository repository;
    
    /**
     * 
     * @param paymentProfile
     * @return 
     */
    @Override
    public AuthorizePaymentResult save(AuthorizePaymentResult paymentProfile) {
        
        return this.repository.save(paymentProfile);
        
    }
    
    
}
