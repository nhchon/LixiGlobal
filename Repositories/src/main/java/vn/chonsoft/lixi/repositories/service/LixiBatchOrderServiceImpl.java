/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiBatchOrder;
import vn.chonsoft.lixi.repositories.LixiBatchOrderRepository;

/**
 *
 * @author Asus
 */
@Service
public class LixiBatchOrderServiceImpl implements LixiBatchOrderService{
    
    @Autowired
    private LixiBatchOrderRepository boRepo;

    /**
     * 
     * @param bo
     * @return 
     */
    @Override
    public LixiBatchOrder save(LixiBatchOrder bo) {
        return this.boRepo.save(bo);
    }
    
}
