/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.repositories.AdminUserRepository;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
@Service
public class AdminUserServiceImpl implements AdminUserService{

    private static final Logger log = LogManager.getLogger(AdminUserServiceImpl.class);
    
    @Inject AdminUserRepository adminUserRepository;

    /**
     * 
     * @param au 
     */
    @Override
    @Transactional
    public void save(AdminUser au) {
        
        this.adminUserRepository.save(au);
        
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public AdminUser find(Long id) {
        
        AdminUser au = this.adminUserRepository.findOne(id);
        // sure authorities are loaded
        au.getAuthorities().size();
        
        return au;
        
    }

    @Override
    public AdminUser find(String email) {
        
        return this.adminUserRepository.findByEmail(email);
        
    }
    
    
    /**
     * 
     * @return 
     */
    @Override
    public List<AdminUser> findAll() {

        return LiXiGlobalUtils.toList(this.adminUserRepository.findAll());
        
    }
    
    
}
