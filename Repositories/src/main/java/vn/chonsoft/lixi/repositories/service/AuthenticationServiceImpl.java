/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.model.LixiConfig;
import vn.chonsoft.lixi.model.SecurityAdminUser;
import vn.chonsoft.lixi.repositories.AdminUserRepository;
import vn.chonsoft.lixi.repositories.LixiConfigRepository;

/**
 *
 * @author chonnh
 */
@Service
public class AuthenticationServiceImpl implements AuthenticationService{

    @Inject 
    private AdminUserRepository adminUserRepository; 

    @Autowired
    private LixiConfigRepository configRepo;
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
        
        List<LixiConfig> configs = this.configRepo.findAll();
        configs.forEach(c -> {au.addConfig(c.getName(), c.getValue());});
        //
        SecurityAdminUser sau = new SecurityAdminUser(au);
        return sau;
    }
    
}
