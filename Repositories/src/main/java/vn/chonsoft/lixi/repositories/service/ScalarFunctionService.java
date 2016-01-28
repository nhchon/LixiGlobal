/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

/**
 *
 * @author chonnh
 */
public interface ScalarFunctionService {
    
    double sumGiftOfRecipient(Long id);
    
    double sumTopUpOfRecipient(Long id);
    
    double sumGiftOfSender(Long id);
    
    double sumTopUpOfSender(Long id);
}
