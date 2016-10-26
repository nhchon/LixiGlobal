/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.RecAddOrder;
import vn.chonsoft.lixi.repositories.RecAddOrderRepository;

/**
 *
 * @author Asus
 */
@Service
public class RecAddOrderServiceImpl implements RecAddOrderService{
    
    @Autowired
    private RecAddOrderRepository raoRepo;

    @Override
    public List<RecAddOrder> findByRecEmailAndAddIdAndOrderId(String recEmail, Long addId, Long orderId){
        
        return this.raoRepo.findByRecEmailAndAddIdAndOrderId(recEmail, addId, orderId);
    }
    
    /**
     * 
     * @param addId
     * @param orderId
     * @return 
     */
    @Override
    public List<RecAddOrder> findByAddIdAndOrderId(Long addId, Long orderId){
        
        return this.raoRepo.findByAddIdAndOrderId(addId, orderId);
        
    }
    
    /**
     * 
     * @param orderId
     * @param recEmail
     * @return 
     */
    @Override
    public List<RecAddOrder> findByOrderIdAndRecEmail(Long orderId, String recEmail){
     
        return this.raoRepo.findByOrderIdAndRecEmail(orderId, recEmail);
        
    }
    
    /**
     * 
     * @param addId
     * @return 
     */
    @Override
    public List<RecAddOrder> findByAddId(Long addId) {
        return this.raoRepo.findByAddId(addId);
    }
    
    
    /**
     * 
     * @param rao
     * @return 
     */
    @Override
    public RecAddOrder save(RecAddOrder rao){
        
        return this.raoRepo.save(rao);
    }
}
