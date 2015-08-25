/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.repositories.UserBankAccountRepository;

/**
 *
 * @author chonnh
 */
@Service
public class UserBankAccountServiceImpl implements UserBankAccountService{

    @Inject
    private UserBankAccountRepository ubcRepository;
    
    /**
     * 
     * @param ubc
     * @return 
     */
    @Override
    public UserBankAccount save(UserBankAccount ubc) {
        
        return this.ubcRepository.save(ubc);
        
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public UserBankAccount findById(Long id){
        
        return this.ubcRepository.findOne(id);
    }
    
    /**
     * 
     * @param u
     * @return 
     */
    @Override
    public List<UserBankAccount> findByUser(User u){
        
        return this.ubcRepository.findByUser(u);
        
    }
    
}
