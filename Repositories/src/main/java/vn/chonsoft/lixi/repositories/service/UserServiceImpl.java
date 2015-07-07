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
    
    @Override
    @Transactional
    public void save(User user){
        this.userRepository.save(user);
    }
    
    @Override
    @Transactional
    public User checkUniqueEmail(String email){
        return this.userRepository.findByEmail(email);
    }
    
    @Override
    @Transactional
    public User findByEmail(String email){
        return this.userRepository.findByEmail(email);
    }
}
