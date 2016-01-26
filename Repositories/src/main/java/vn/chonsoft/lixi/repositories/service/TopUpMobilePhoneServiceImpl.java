/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.Date;
import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
     * @param ts 
     */
    @Override
    @Transactional
    public void save(List<TopUpMobilePhone> ts){
        
        this.topUpRepository.save(ts);
        
    }
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public TopUpMobilePhone findById(Long id){
        
        TopUpMobilePhone t = this.topUpRepository.findOne(id);
        if(t != null){
            t.getOrder().getInvoice();
            t.getRecipient();
        }
        return t;
        
    }
    
    /**
     * 
     * @param isSubmitted
     * @return 
     */
    @Override
    @Transactional
    public List<TopUpMobilePhone> findByIsSubmitted(Iterable<Integer> isSubmitted){
        
        
        List<TopUpMobilePhone>  l = this.topUpRepository.findByIsSubmittedIn(isSubmitted, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        l.forEach(t -> {
            t.getOrder().getInvoice();
            t.getRecipient();
        });
        
        return l;
        
    }
    
    /**
     * 
     * @param isSubmitted
     * @param begin
     * @param end
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<TopUpMobilePhone> findByIsSubmittedAndModifiedDate(Integer isSubmitted, Date begin, Date end, Pageable page){
        
        Page<TopUpMobilePhone> ps = this.topUpRepository.findByIsSubmittedAndModifiedDateBetween(isSubmitted, begin, end, page);
        if(ps != null && ps.hasContent()){
            ps.getContent().forEach(t -> {
                t.getOrder().getInvoice();
                t.getRecipient();
            });
        }
        
        return ps;
    }
    
    /**
     * 
     * @param isSubmitted
     * @param begin
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<TopUpMobilePhone> findByIsSubmittedAndFromDate(Integer isSubmitted, Date begin, Pageable page){
        
        Page<TopUpMobilePhone> ps = this.topUpRepository.findByIsSubmittedAndModifiedDateIsGreaterThanEqual(isSubmitted, begin, page);
        if(ps != null && ps.hasContent()){
            ps.getContent().forEach(t -> {
                t.getOrder().getInvoice();
                t.getRecipient();
            });
        }
        
        return ps;
    }
    
    /**
     * 
     * @param isSubmitted
     * @param end
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<TopUpMobilePhone> findByIsSubmittedAndEndDate(Integer isSubmitted, Date end, Pageable page){
        
        Page<TopUpMobilePhone> ps = this.topUpRepository.findByIsSubmittedAndModifiedDateIsLessThanEqual(isSubmitted, end, page);
        if(ps != null && ps.hasContent()){
            ps.getContent().forEach(t -> {
                t.getOrder().getInvoice();
                t.getRecipient();
            });
        }
        
        return ps;
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
