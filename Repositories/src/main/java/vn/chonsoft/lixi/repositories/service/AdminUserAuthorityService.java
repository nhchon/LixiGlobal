/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.validation.constraints.NotNull;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.model.AdminUserAuthority;

/**
 *
 * @author chonnh
 */
@Validated
public interface AdminUserAuthorityService {
    
    void save(AdminUserAuthority au);
    
    void save(List<AdminUserAuthority> aus);
    
    @NotNull
    List<AdminUserAuthority> findAll();
    
    List<AdminUserAuthority> findByAuthorityNames(List<String> authorities);
    
    AdminUserAuthority findByAdminUserIdAndAuthority(AdminUser adminUserId, String authority);
    
    void deleteByAdminUserId(Long adminUserId);
}
