/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import vn.chonsoft.lixi.model.AuthorizePaymentResult;

/**
 *
 * @author chonnh
 */
public interface AuthorizePaymentResultService {
    
    AuthorizePaymentResult save(AuthorizePaymentResult paymentProfile);
    
}
