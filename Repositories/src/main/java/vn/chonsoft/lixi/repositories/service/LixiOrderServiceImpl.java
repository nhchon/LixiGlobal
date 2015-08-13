/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.repositories.LixiOrderRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiOrderServiceImpl implements LixiOrderService{
    
    @Inject LixiOrderRepository lxorderRepository;

    /**
     * 
     * @param order
     * @return 
     */
    @Transactional
    @Override
    public LixiOrder save(LixiOrder order) {
        
        return this.lxorderRepository.save(order);
        
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public LixiOrder findById(Long id) {
        
        return this.lxorderRepository.findOne(id);
        
    }
    
}
