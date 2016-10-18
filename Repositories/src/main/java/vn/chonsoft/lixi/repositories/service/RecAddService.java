/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.RecAdd;

/**
 *
 * @author Asus
 */
public interface RecAddService {
    
    RecAdd findById(String email, Long id);
    
    RecAdd findById(Long id);
    
    List<RecAdd> findByEmail(String email);
    
    RecAdd save(RecAdd recAdd);
    
    void delete(Long id);
}
