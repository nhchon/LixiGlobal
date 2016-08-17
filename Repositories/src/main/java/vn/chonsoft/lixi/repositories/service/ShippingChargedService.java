/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.ShippingCharged;

/**
 *
 * @author Asus
 */
public interface ShippingChargedService {
    
    ShippingCharged save(ShippingCharged sc);
    
    void delete(Long id);
    
    List<ShippingCharged> findAll();
}
