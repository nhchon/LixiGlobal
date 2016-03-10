/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;

/**
 *
 * @author chonnh
 */
public interface ScalarFunctionService {
    
    /* recipient's functions */
    
    //List<Long> getListOrderProcessedOreCompletedOfRecipient(Long id);
    
    List<Long> getOrdersOfRecipient(String status, Long id);
    
    double sumGiftOfRecipient(String invoiceStatus, Long id);
    
    double sumGiftOfRecipientByOrderStatus(String oStatus, Long id);
            
    double sumTopUpOfRecipient(String invoiceStatus, Long id);
    
    double sumTopUpOfRecipientByOrderStatus(String oStatus, Long id);
    
    /* sender's functions */
    long countOrdersOfSender(String oStatus, Long sender);
    
    double sumInvoiceOfSender(String invoiceStatus, Long sender);
    
    double sumInvoiceByOrderStatus(String status, long sender);
    
    double sumInvoiceVndByOrderStatus(String status, long sender);
    
    double sumTopUpOfSender(String invoiceStatus, Long sender);
    
}
