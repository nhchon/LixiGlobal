/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.repositories.UserRepository;

/**
 *
 * @author chonnh
 */
@Service
public class UserServiceImpl implements UserService{
    
    @Inject UserRepository userRepository; 
    
    /**
     * 
     * @param user
     * @return 
     */
    @Override
    @Transactional
    public User save(User user){
        
        return this.userRepository.save(user);
        
    }
    
    @Override
    @Transactional
    public User checkUniqueEmail(String email){
        return this.userRepository.findByEmail(email);
    }
    
    /**
     * 
     * @param email
     * @return 
     */
    @Override
    @Transactional
    public User findByEmail(String email){
        
        User u = this.userRepository.findByEmail(email);
        if(u != null){
            
            // make sure recipients is loaded;
            u.getRecipients().size();
            
            // maximum payment amount
            u.getUserMoneyLevel().getMoneyLevel();
            
            //
            u.getAddresses().size();
        }
        
        return u;
        
    }
    
    @Override
    public int updateEnaled(Boolean enabled, Long id){
        
        return this.userRepository.updateEnaled(enabled, id);
        
    }
    
    @Override
    public int updateActivated(Boolean activated, Long id){
        
        return this.userRepository.updateActivated(activated, id);
    }
    
    @Override
    public int updatePassword(String password, Long id){
        
        return this.userRepository.updatePassword(password, id);
        
    }
    
    @Override
    public int updateEmail(String email, Long id){
        
        return this.userRepository.updateEmail(email, id);
        
    }
    
    @Override
    public int updatePhoneNumber(String phoneNumber, Long id){
        
        return this.userRepository.updatePhoneNumber(phoneNumber, id);
        
    }
    
}
