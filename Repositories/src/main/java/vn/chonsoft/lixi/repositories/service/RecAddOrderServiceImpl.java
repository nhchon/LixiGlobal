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
