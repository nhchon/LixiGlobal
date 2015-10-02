/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.BuyCardResult;
import vn.chonsoft.lixi.repositories.BuyCardResultRepository;

/**
 *
 * @author chonnh
 */
@Service
public class BuyCardResultServiceImpl implements BuyCardResultService{
    
    @Inject
    private BuyCardResultRepository bcrRepository;

    /**
     * 
     * @param result
     * @return 
     */
    @Override
    public BuyCardResult save(BuyCardResult result) {
        
        return this.bcrRepository.save(result);
        
    }
}
