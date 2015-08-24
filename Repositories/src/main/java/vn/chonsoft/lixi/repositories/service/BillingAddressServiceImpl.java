/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.repositories.BillingAddressRepository;

/**
 *
 * @author chonnh
 */
@Service
public class BillingAddressServiceImpl implements BillingAddressService{

    @Inject
    private BillingAddressRepository baRepository;
    
    
    /**
     * 
     * @param ba
     * @return 
     */
    @Override
    @Transactional
    public BillingAddress save(BillingAddress ba) {

        return this.baRepository.save(ba);
        
    }

    @Override
    public BillingAddress findById(Long id){
        
        return this.baRepository.findOne(id);
        
    }
    /**
     * 
     * @param u
     * @return 
     */
    @Override
    public List<BillingAddress> findByUser(User u) {
        
        return this.baRepository.findByUser(u);
        
    }
    
    /**
     * 
     * @param u
     * @param page
     * @return 
     */
    @Override
    public Page<BillingAddress> findByUser(User u, Pageable page){
        
        Page<BillingAddress> entities = this.baRepository.findByUser(u, page);
        
        return new PageImpl<>(entities.getContent(), page, entities.getTotalElements());
    }
    
    @Override
    public BillingAddress findByIdAndUser(Long id, User u){
        
        return this.baRepository.findByIdAndUser(id, u);
        
    }
}
