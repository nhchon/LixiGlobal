/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.model.SecurityAdminUser;
import vn.chonsoft.lixi.repositories.AdminUserRepository;

/**
 *
 * @author chonnh
 */
@Service
public class AuthenticationServiceImpl implements AuthenticationService{

    @Inject AdminUserRepository adminUserRepository; 
    
    /**
     * 
     * @param username
     * @return 
     */
    @Override
    @Transactional
    public SecurityAdminUser loadUserByUsername(String username) {
        
        AdminUser au = this.adminUserRepository.findByEmail(username);
        // make sure the authorities are loaded
        au.getAuthorities().size();
        //
        SecurityAdminUser sau = new SecurityAdminUser(au);
        return sau;
    }
    
}
