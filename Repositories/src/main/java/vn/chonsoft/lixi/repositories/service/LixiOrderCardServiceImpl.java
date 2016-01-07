/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrderCard;
import vn.chonsoft.lixi.repositories.LixiOrderCardRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiOrderCardServiceImpl implements LixiOrderCardService{

    @Autowired
    private LixiOrderCardRepository cardRepository;
    
    /**
     * 
     * @param card
     * @return 
     */
    @Override
    public LixiOrderCard save(LixiOrderCard card) {
        
        return this.cardRepository.save(card);
        
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public LixiOrderCard findById(Long id) {
        
        LixiOrderCard c = this.cardRepository.findOne(id);
        if(c != null){
            c.getBillingAddress();
        }
        
        return c;
    }
    
}
