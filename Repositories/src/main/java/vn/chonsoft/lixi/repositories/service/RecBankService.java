/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.RecBank;

/**
 *
 * @author Asus
 */
public interface RecBankService {
    
    RecBank save(RecBank rBank);
    
    RecBank findById(Long id);
    
    RecBank findById(String email, Long id);
    
    void delete(Long id);
    
    List<RecBank> findByEmail(String email);
}
