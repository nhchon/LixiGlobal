/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.UserMoneyLevel;
import vn.chonsoft.lixi.repositories.UserMoneyLevelRepository;

/**
 *
 * @author chonnh
 */
@Service
public class UserMoneyLevelServiceImpl implements UserMoneyLevelService{

    @Inject
    private UserMoneyLevelRepository umlRepository;
    
    /**
     * 
     * @param uml
     * @return 
     */
    @Override
    @Transactional
    public UserMoneyLevel save(UserMoneyLevel uml) {

        return this.umlRepository.save(uml);
        
    }
    
    
}
