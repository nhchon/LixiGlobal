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
     * @param status
     * @param id
     * @return 
     */
    @Override
    public int updateStatus(Integer status, Long id){
        
        return this.lxorderRepository.updateStatus(status, id);
        
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
            
            //
            order.getBankAccount();
        }
        
        return order;
        
    }
    
    /**
     * 
     * @param user
     * @return 
     */
    @Override
    @Transactional
    public LixiOrder findLastOrder(User user){
        
        Pageable just1rec = new PageRequest(0, 1, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        Page<LixiOrder> page1 = this.lxorderRepository.findBySender(user, just1rec);
        
        if(page1 != null){
            
            List<LixiOrder> l1 = page1.getContent();
            
            if(l1 != null && !l1.isEmpty()){
                
                LixiOrder i0 = l1.get(0);
                // load them
                i0.getCard();
                i0.getBankAccount();
                
                return i0;
                
            }
        }
        //
        return null;
        
    }
    
    /**
     * 
     * @param status
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<LixiOrder> findByLixiStatus(Integer status, Pageable page){
        
        Page<LixiOrder> ps = this.lxorderRepository.findByLixiStatus(status, page);
        if(ps != null && ps.hasContent()){
            ps.getContent().forEach((LixiOrder o) -> o.getGifts().size());
        }
        
        return ps;
    }
    
    /**
     * 
     * @param ids
     * @return 
     */
    @Override
    @Transactional
    public List<LixiOrder> findAll(List<Long> ids){
        
        List<LixiOrder> ls = this.lxorderRepository.findAll(ids);
        if(ls != null && !ls.isEmpty()){
            ls.forEach((LixiOrder o) -> o.getGifts().size());
        }
        return ls;
        
    }
    
    @Override
    public LixiOrder findLastBySenderAndLixiStatus(User sender, Integer status){
        
        List<LixiOrder> ls = this.lxorderRepository.findBySenderAndLixiStatus(sender, status);
        if(ls != null && !ls.isEmpty()){
                
                return ls.get(0);
                
        }
        //
        return null;
    }
}
