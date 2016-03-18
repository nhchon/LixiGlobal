/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiBatch;
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
