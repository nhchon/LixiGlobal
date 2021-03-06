/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.RecBankOrder;

/**
 *
 * @author Asus
 */
public interface RecBankOrderService {
    
    List<RecBankOrder> findByRecEmailAndBankIdAndOrderId(String recEmail, Long bankId, Long orderId);
    
    List<RecBankOrder> findByOrderIdAndRecEmail(Long orderId, String recEmail);
    
    List<RecBankOrder> findByBankId(Long bankId);
    
    RecBankOrder save(RecBankOrder rbo);
}
