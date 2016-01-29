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
    
    double sumGiftOfRecipient(String invoiceStatus, Long id);
    
    double sumTopUpOfRecipient(String invoiceStatus, Long id);
    
    double sumInvoiceOfSender(String invoiceStatus, Long sender);
    
    double sumTopUpOfSender(String invoiceStatus, Long sender);
}
