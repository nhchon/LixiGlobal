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
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.repositories.TopUpMobilePhoneRepository;

/**
 *
 * @author chonnh
 */
@Service
public class TopUpMobilePhoneServiceImpl implements TopUpMobilePhoneService{
    
    @Inject
    private TopUpMobilePhoneRepository topUpRepository;

    /**
     * 
     * @param topUp
     * @return 
     */
    @Override
    public TopUpMobilePhone save(TopUpMobilePhone topUp) {
        
        return this.topUpRepository.save(topUp);
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public TopUpMobilePhone findById(Long id){
        
        return this.topUpRepository.findOne(id);
        
    }
    
    /**
     * 
     * @param isSubmitted
     * @return 
     */
    @Override
    @Transactional
    public List<TopUpMobilePhone> findByIsSubmitted(Iterable<Integer> isSubmitted){
        
        List<TopUpMobilePhone>  l = this.topUpRepository.findByIsSubmittedIn(isSubmitted);
        
        l.forEach(t -> {
            t.getOrder().getInvoice();
            t.getRecipient();
        });
        
        return l;
        
    }
    /**
     * 
     * @param id 
     */
    @Override
    public void deleteById(Long id){
        
        this.topUpRepository.delete(id);
        
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
        
        return this.topUpRepository.deleteByOrderAndRecipient(order, recipient);
        
    }
}
