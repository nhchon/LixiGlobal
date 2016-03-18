/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiBatch;
import vn.chonsoft.lixi.repositories.LixiBatchRepository;

/**
 *
 * @author Asus
 */
@Service
public class LixiBatchServiceImpl implements LixiBatchService{

    @Autowired
    private LixiBatchRepository bRepo;
    
    /**
     * 
     * @param b
     * @return 
     */
    @Override
    public LixiBatch save(LixiBatch b) {
        
        return this.bRepo.save(b);
    }
 
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public LixiBatch findById(Long id){
        
        LixiBatch b = this.bRepo.findOne(id);
        if(b != null){
            b.getOrders().size();
        }
        
        return b;
    }
    /**
     * 
     * @param begin
     * @param end
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<LixiBatch> findByCreatedDate(Date begin, Date end, Pageable page){
        
        Page<LixiBatch> pBs = this.bRepo.findByCreatedDateBetween(begin, end, page);
        
        if(pBs != null && !pBs.getContent().isEmpty()){
        
            pBs.getContent().forEach(b ->{ b.getOrders();});
        }
        
        return pBs;
    }
    
}
