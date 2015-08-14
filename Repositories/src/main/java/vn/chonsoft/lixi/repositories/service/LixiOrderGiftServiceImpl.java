/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.repositories.LixiOrderGiftRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiOrderGiftServiceImpl implements LixiOrderGiftService{

    @Inject LixiOrderGiftRepository lxogiftRepository;
    
    
    /**
     * 
     * @param gift
     * @return 
     */
    @Transactional
    @Override
    public LixiOrderGift save(LixiOrderGift gift) {
        
        return this.lxogiftRepository.save(gift);
        
    }

    /**
     * 
     * @param gifts
     * @return 
     */
    @Transactional
    @Override
    public List<LixiOrderGift> save(List<LixiOrderGift> gifts) {
        
        return this.lxogiftRepository.save(gifts);
        
    }
    
    @Override
    @Transactional
    public LixiOrderGift findByOrderAndRecipient(LixiOrder order, Recipient recipient){
        
        return this.lxogiftRepository.findByOrderAndRecipient(order, recipient);
        
    }
}
