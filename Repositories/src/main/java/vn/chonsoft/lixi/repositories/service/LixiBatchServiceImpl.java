/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiBatch;
import vn.chonsoft.lixi.repositories.LixiBatchRepository;

/**
 *
 * @author Asus
 */
@Service
public class LixiBatchServiceImpl implements LixiBatchService{

    @Autowired
    private LixiBatchRepository bRepo;
    
    /**
     * 
     * @param b
     * @return 
     */
    @Override
    public LixiBatch save(LixiBatch b) {
        
        return this.bRepo.save(b);
    }
    
}
