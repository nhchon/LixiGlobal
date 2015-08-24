/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.repositories.LixiOrderRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiOrderServiceImpl implements LixiOrderService{
    
    @Inject LixiOrderRepository lxorderRepository;

    /**
     * 
     * @param order
     * @return 
     */
    @Transactional
    @Override
    public LixiOrder save(LixiOrder order) {
        
        return this.lxorderRepository.save(order);
        
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Transactional
    @Override
    public LixiOrder findById(Long id) {
        
        LixiOrder order = this.lxorderRepository.findOne(id);
        if(order != null){
            
            // make sure load gifts
            order.getGifts().size();
            
            // exchange rate
            order.getLxExchangeRate();
            
            //
            order.getCard();
            
        }
        
        return order;
        
    }
    
    /**
     * 
     * @param user
     * @return 
     */
    @Override
    public LixiOrder findLastOrder(User user){
        
        Pageable just1rec = new PageRequest(0, 1, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        Page<LixiOrder> page1 = this.lxorderRepository.findBySender(user, just1rec);
        
        if(page1 != null){
            
            List<LixiOrder> l1 = page1.getContent();
            
            if(l1 != null && !l1.isEmpty()){
                
                return l1.get(0);
                
            }
        }
        //
        return null;
        
    }
}
