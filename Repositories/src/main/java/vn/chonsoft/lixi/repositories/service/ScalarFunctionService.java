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
    
    long countTopUp();
    
    long countPurchases(int id);
    
    List<Integer> getBestSellingProducts();
    
    List<Long> getOrdersOfRecipient(String status, Long id);
    
    double sumVndOfBatch(long id);
    
    double sumUsdOfBatch(long id);
    
    double sumGiftOfRecipient(String invoiceStatus, Long id);
    
    double sumGiftOfRecipientByOrderStatus(String oStatus, Long id);
            
    double sumTopUpOfRecipient(String invoiceStatus, Long id);
    
    double sumTopUpOfRecipientByOrderStatus(String oStatus, Long id);
    
    /* sender's functions */
    long countOrdersOfSender(String oStatus, Long sender);
    long countInvoiceOfSender(String invoiceStatus, Long sender);
    
    double sumInvoiceOfSender(String invoiceStatus, Long sender);
    
    double sumInvoiceByOrderStatus(String status, long sender);
    
    double sumInvoiceVndByOrderStatus(String status, long sender);
    
    double sumTopUpOfSender(String invoiceStatus, Long sender);
    
    /* */
    double sumProductPrice(int catId, int alive);
}
