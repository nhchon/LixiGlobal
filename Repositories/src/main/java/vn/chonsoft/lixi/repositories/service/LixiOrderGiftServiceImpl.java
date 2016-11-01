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
     * @param status
     * @param oId 
     */
    @Transactional
    @Override
    public void updateBkStatusByOrderId(String status, Long oId) {
        this.lxogiftRepository.updateBkStatusByOrderId(status, oId);
    }
    
    
    /**
     * 
     * @param recipientEmail
     * @param bkReceiveMethod
     * @param bkStatus
     * @return 
     */
    @Override
    public List<LixiOrderGift> findByRecipientEmailAndBkReceiveMethodAndBkStatusIn(String recipientEmail, String bkReceiveMethod, Iterable<String> bkStatus){
        
        return this.lxogiftRepository.findByRecipientEmailAndBkReceiveMethodAndBkStatusIn(recipientEmail, bkReceiveMethod, bkStatus);
    }
    
    /**
     * 
     * @param bkReceiveMethod
     * @param bkStatus
     * @return 
     */
    @Override
    public List<LixiOrderGift> findByBkReceiveMethodAndBkStatusIn(String bkReceiveMethod, Iterable<String> bkStatus){
        
        return this.lxogiftRepository.findByBkReceiveMethodAndBkStatusIn(bkReceiveMethod, bkStatus);
        
    }
    
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
     * @param order
     * @param productId 
     */
    @Override
    @Transactional
    public void deleteByOrderAndProductId(LixiOrder order, int productId){
        
        this.lxogiftRepository.deleteByOrderAndProductId(order, productId);
        
    }
    
    /**
     * 
     * @param order
     * @param recipient
     * @return 
     */
    @Override
    @Transactional
    public Long deleteByOrderAndRecipient(LixiOrder order, Recipient recipient){
        
        return this.lxogiftRepository.deleteByOrderAndRecipient(order, recipient);
        
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
    public int updateProductIdAndPrice(int productId, double productPrice, Long id){
        
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
     * @param recipientEmail
     * @param bkStatus
     * @return 
     */
    @Override
    public List<LixiOrderGift> findByRecipientEmailAndBkStatus(String recipientEmail, String bkStatus){
        return this.lxogiftRepository.findByRecipientEmailAndBkStatus(recipientEmail, bkStatus);
    }
    
    /**
     * 
     * @param recipientEmail
     * @param bkStatus
     * @return 
     */
    @Override
    public List<LixiOrderGift> findByRecipientEmailAndBkStatusIn(String recipientEmail, Iterable<String> bkStatus){
        
        return this.lxogiftRepository.findByRecipientEmailAndBkStatusIn(recipientEmail, bkStatus);
    }
    
    /**
     * 
     * @param recipientEmail
     * @param bkStatus
     * @param bkReceiveMethod
     * @return 
     */
    @Override
    public List<LixiOrderGift> findByRecipientEmailAndBkReceiveMethodAndBkStatus(String recipientEmail, String bkReceiveMethod, String bkStatus){
        
        return this.lxogiftRepository.findByRecipientEmailAndBkReceiveMethodAndBkStatus(recipientEmail, bkReceiveMethod, bkStatus);
        
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
            //
            gift.getRecipient();
            
            gift.getOrder().getId();
        }
        return gift;
        
    }
    
    /**
     * 
     * @param order
     * @param recipient
     * @param productId
     * @return 
     */
    @Override
    public LixiOrderGift findByOrderAndRecipientAndProductId(LixiOrder order, Recipient recipient, Integer productId){
        
        return this.lxogiftRepository.findByOrderAndRecipientAndProductId(order, recipient, productId);
        
    }
    
    /**
     * 
     * @param bkStatus
     * @param bkReceiveMethod
     * @return 
     */
    @Override
    public List<LixiOrderGift> findByBkStatusAndBkReceiveMethod(String bkStatus, String bkReceiveMethod){
        
        return this.lxogiftRepository.findByBkStatusAndBkReceiveMethod(bkStatus, bkReceiveMethod);
        
    }
}
