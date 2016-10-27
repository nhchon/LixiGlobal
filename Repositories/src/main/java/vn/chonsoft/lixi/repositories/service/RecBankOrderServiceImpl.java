/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.RecBankOrder;
import vn.chonsoft.lixi.repositories.RecBankOrderRepository;

/**
 *
 * @author Asus
 */
@Service
public class RecBankOrderServiceImpl implements RecBankOrderService{
    
    @Autowired
    private RecBankOrderRepository rboRepo;

    /**
     * 
     * @param orderId
     * @param recEmail
     * @return 
     */
    @Override
    public List<RecBankOrder> findByOrderIdAndRecEmail(Long orderId, String recEmail) {
        
        return this.rboRepo.findByOrderIdAndRecEmail(orderId, recEmail);
        
    }

    /**
     * 
     * @param recEmail
     * @param bankId
     * @param orderId
     * @return 
     */
    @Override
    public List<RecBankOrder> findByRecEmailAndBankIdAndOrderId(String recEmail, Long bankId, Long orderId){
        
        return this.rboRepo.findByRecEmailAndBankIdAndOrderId(recEmail, bankId, orderId);
    }
    
    /**
     * 
     * @param bankId
     * @return 
     */
    @Override
    public List<RecBankOrder> findByBankId(Long bankId){
        
        return this.rboRepo.findByBankId(bankId);
        
    }
    /**
     * 
     * @param rbo
     * @return 
     */
    @Override
    public RecBankOrder save(RecBankOrder rbo) {
        
        return this.rboRepo.save(rbo);
    }
    
    
}
