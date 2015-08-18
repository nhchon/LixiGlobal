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
    
    /**
     * 
     * @param gift 
     */
    @Override
    @Transactional
    public void delete(LixiOrderGift gift){
        
        this.lxogiftRepository.delete(gift);
    }
    
    /**
     * 
     * @param id 
     */
    @Override
    @Transactional
    public void delete(Long id){
        
        this.lxogiftRepository.delete(id);
        
    }
    
    /**
     * 
     * @param productId
     * @param productPrice
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public int updateProductIdAndPrice(int productId, float productPrice, Long id){
        
        return this.lxogiftRepository.updateProductIdAndPrice(productId, productPrice, id);
        
    }
    
    /**
     * 
     * one recipient have more than one gift
     * 
     * @param order
     * @param recipient
     * @return 
     */
    @Override
    @Transactional
    public List<LixiOrderGift> findByOrderAndRecipient(LixiOrder order, Recipient recipient){
        
        return this.lxogiftRepository.findByOrderAndRecipient(order, recipient);
        
    }
    
    /**
     * 
     * @param id
     * @param order
     * @return 
     */
    @Override
    @Transactional
    public LixiOrderGift findByIdAndOrder(Long id, LixiOrder order){
        
        return this.lxogiftRepository.findByIdAndOrder(id, order);
        
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public LixiOrderGift findById(Long id){
        
        LixiOrderGift gift = this.lxogiftRepository.findOne(id);
        if(gift != null){
            gift.getRecipient();
        }
        return gift;
        
    }
}
