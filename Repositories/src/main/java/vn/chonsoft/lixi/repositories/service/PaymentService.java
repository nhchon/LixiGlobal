/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.scheduling.annotation.Scheduled;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserCard;

/**
 *
 * @author chonnh
 */
public interface PaymentService {
    
    @Scheduled(fixedDelay=3*60*60*1000, initialDelay=60*1000)
    void updateAllInvoiceStatus();
    
    void updateInvoiceStatus(LixiInvoice invoice);
    
    String createPaymentProfile(UserCard card);
    
    String createCustomerProfile(User u, UserCard card);
    
    void deletePaymentProfile(UserCard card);
    
    void getPaymentProfile(UserCard card);
    
    String voidTransaction(LixiInvoice invoice);
    
    boolean charge(LixiInvoice lxInvoice);
    
    boolean chargeByCustomerProfile(LixiInvoice lxInvoice);
}
