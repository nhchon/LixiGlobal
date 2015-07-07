/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.AdminUserPasswordHistory;
import vn.chonsoft.lixi.repositories.AdminUserPasswordHistoryRepository;

/**
 *
 * @author chonnh
 */
@Service
public class AdminUserPasswordHistoryServiceImpl implements AdminUserPasswordHistoryService{
    
    @Inject AdminUserPasswordHistoryRepository auphRepository;

    /**
     * 
     * @param auph 
     */
    @Override
    public void save(AdminUserPasswordHistory auph) {
        
        this.auphRepository.save(auph);
        
    }
    
}
