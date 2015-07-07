/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.AdminUser;

/**
 *
 * @author chonnh
 */
@Validated
public interface AdminUserService {
    
    void save(AdminUser au);
    
    AdminUser find(Long id);
    
    AdminUser find(String email);
    
    List<AdminUser> findAll();
    
}
