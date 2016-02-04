/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
    
    @Autowired
    private UserRepository userRepository; 
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public User findById(Long id){
        
        return this.userRepository.findOne(id);
    }
    /**
     * 
     * @param activated
     * @param page
     * @return 
     */
    @Override
    @Transactional
    public Page<User> findByActivated(boolean activated, Pageable page){
    
        Page<User> ps = this.userRepository.findByActivated(activated, page);
        
        if(ps != null && ps.hasContent()){
            ps.getContent().forEach(s -> {
                // TO DO
            });
        }
        
        return ps;    
    }
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
    
    /**
     * 
     * @param email
     * @return 
     */
    @Override
    @Transactional
    public List<User> findAllByEmail(String email){
        
        List<User> us = this.userRepository.findByEmail(email);
        
        us.forEach(u -> {
            // make sure recipients is loaded;
            u.getRecipients().size();
            
            // maximum payment amount
            u.getUserMoneyLevel().getMoneyLevel();
            
            //
            u.getAddresses().size();
        });
        
        return us;
        
    }
    
    /**
     * 
     * @param email
     * @param enabled
     * @return 
     */
    @Override
    @Transactional
    public User findByEmail(String email, boolean enabled){
        
        User u = this.userRepository.findByEmailAndEnabled(email, enabled);
        if(u != null){
            // make sure recipients is loaded;
            u.getRecipients().size();
            
            // maximum payment amount
            if(u.getUserMoneyLevel() != null)
                u.getUserMoneyLevel().getMoneyLevel();
            
            //
            u.getAddresses().size();
        }
        return u;
    }
    
    /**
     * 
     * @param email
     * @return 
     */
    @Override
    @Transactional
    public User findByEmail(String email){
        
        return findByEmail(email, Boolean.TRUE);
        
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
    
    /**
     * 
     * @param profileId
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public int updateAuthorizeProfileId(String profileId, Long id){
        
        return this.userRepository.updateAuthorizeProfileId(profileId, id);
    }
}
