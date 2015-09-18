/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.BuyPhoneCard;
import vn.chonsoft.lixi.repositories.BuyPhoneCardRepository;

/**
 *
 * @author chonnh
 */
@Service
public class BuyPhoneCardServiceImpl implements BuyPhoneCardService{
    
    @Inject
    private BuyPhoneCardRepository buyPhoneCardRepository;

    /**
     * 
     * @param buyCard
     * @return 
     */
    @Override
    @Transactional
    public BuyPhoneCard save(BuyPhoneCard buyCard) {
        
        return this.buyPhoneCardRepository.save(buyCard);
    }
}
