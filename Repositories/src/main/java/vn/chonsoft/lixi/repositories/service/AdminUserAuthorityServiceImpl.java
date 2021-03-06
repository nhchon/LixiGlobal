/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.model.AdminUserAuthority;
import vn.chonsoft.lixi.repositories.AdminUserAuthorityRepository;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
@Service
public class AdminUserAuthorityServiceImpl implements AdminUserAuthorityService{

    @Inject
    private AdminUserAuthorityRepository auAuRepository;

    /**
     * 
     * @param au 
     */
    @Override
    @Transactional
    public void save(AdminUserAuthority au) {
        
        this.auAuRepository.save(au);
        
    }

    @Override
    @Transactional
    public void save(List<AdminUserAuthority> aus){
        
        this.auAuRepository.save(aus);
        
    }
    /**
     * 
     * @param adminUserId 
     */
    @Override
    @Transactional
    public void deleteByAdminUserId(Long adminUserId) {
        
        this.auAuRepository.deleteByAdminUserId(adminUserId);
        
    }
    
    
    
    @Override
    public List<AdminUserAuthority> findAll() {
        
        return LiXiGlobalUtils.toList(this.auAuRepository.findAll());
        
    }

    /**
     * 
     * @param authorities
     * @return 
     */
    @Transactional
    @Override
    public List<AdminUserAuthority> findByAuthorityNames(List<String> authorities) {
        
        List<AdminUserAuthority> auaL = LiXiRepoUtils.toList(this.auAuRepository.findByAuthorityNames(authorities));
        auaL.forEach(aua -> {
            aua.getAdminUserId().getEmail();
        });
        
        return auaL;
        
    }

    /**
     * 
     * @param adminUserId
     * @param authority
     * @return 
     */
    @Override
    public AdminUserAuthority findByAdminUserIdAndAuthority(AdminUser adminUserId, String authority) {
        
        return this.auAuRepository.findByAdminUserIdAndAuthority(adminUserId, authority);
        
    }
    
    
}
