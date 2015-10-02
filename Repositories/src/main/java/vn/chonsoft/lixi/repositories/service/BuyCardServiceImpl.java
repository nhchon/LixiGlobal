/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.BuyCard;
import vn.chonsoft.lixi.repositories.BuyCardRepository;

/**
 *
 * @author chonnh
 */
@Service
public class BuyCardServiceImpl implements BuyCardService{
    
    @Inject
    private BuyCardRepository buyPhoneCardRepository;

    /**
     * 
     * @param buyCard
     * @return 
     */
    @Override
    @Transactional
    public BuyCard save(BuyCard buyCard) {
        
        return this.buyPhoneCardRepository.save(buyCard);
    }
}
