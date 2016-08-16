/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.ShippingCharged;
import vn.chonsoft.lixi.repositories.ShippingChargedRepository;

/**
 *
 * @author Asus
 */
@Service
public class ShippingChargedServiceImpl implements ShippingChargedService{
    
    @Autowired
    private ShippingChargedRepository shipRepo;
    
    /**
     * 
     * @param sc
     * @return 
     */
    @Override
    public ShippingCharged save(ShippingCharged sc) {
        
        return this.shipRepo.save(sc);
        
    }

    /**
     * 
     * @return 
     */
    @Override
    public List<ShippingCharged> findAll() {
        
        return this.shipRepo.findAll(new Sort(new Sort.Order(Sort.Direction.ASC, "orderFrom")));
        
    }
    
}
