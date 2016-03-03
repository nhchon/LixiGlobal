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
            t.getOrder().getGifts();
            t.getRecipient();
        }
        return t;
        
    }
    
    /**
     * 
     * @param status
     * @return 
     */
    @Override
    @Transactional
    public List<TopUpMobilePhone> findByStatus(Iterable<String> status){
        
        
        List<TopUpMobilePhone>  l = this.topUpRepository.findByStatusIn(status, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        l.forEach(t -> {
            t.getOrder().getInvoice();
            t.getRecipient();
        });
        
        return l;
        
    }
    
    /**
     * 
     * @param status
     * @return 
     */
    @Override
    @Transactional
    public List<TopUpMobilePhone> findByStatus(String status){
        
        
        List<TopUpMobilePhone>  l = this.topUpRepository.findByStatus(status, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        l.forEach(t -> {
            t.getOrder().getInvoice();
            t.getRecipient();
        });
        
        return l;
        
    }
    
    /**
     * 
     * @param lxStatus
     * @param status
     * @return 
     */
    @Override
    @Transactional
    public List<TopUpMobilePhone> findByStatus(String lxStatus, String status){
        
        List<TopUpMobilePhone>  l = this.topUpRepository.findByOrder_LixiStatusAndStatus(lxStatus, status, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        l.forEach(t -> {
            t.getOrder().getInvoice();
            t.getRecipient();
        });
        
        return l;
        
    }

    /**
     * 
     * @param status
     * @param begin
     * @param end
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<TopUpMobilePhone> findByStatusAndModifiedDate(String status, Date begin, Date end, Pageable page){
        
        Page<TopUpMobilePhone> ps = this.topUpRepository.findByStatusAndModifiedDateBetween(status, begin, end, page);
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
     * @param status
     * @param begin
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<TopUpMobilePhone> findByStatusAndFromDate(String status, Date begin, Pageable page){
        
        Page<TopUpMobilePhone> ps = this.topUpRepository.findByStatusAndModifiedDateIsGreaterThanEqual(status, begin, page);
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
     * @param status
     * @param end
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<TopUpMobilePhone> findByStatusAndEndDate(String status, Date end, Pageable page){
        
        Page<TopUpMobilePhone> ps = this.topUpRepository.findByStatusAndModifiedDateIsLessThanEqual(status, end, page);
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
