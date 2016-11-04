/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.model.AdminUserAuthority;

/**
 *
 * @author chonnh
 */
public interface AdminUserAuthorityRepository extends JpaRepository<AdminUserAuthority, Long>{
    
    @Modifying
    @Transactional
    @Query("SELECT auAuth FROM AdminUserAuthority auAuth WHERE auAuth.authority IN :authorities")
    List<AdminUserAuthority> findByAuthorityNames(@Param("authorities") List<String> authorities);
    
    AdminUserAuthority findByAdminUserIdAndAuthority(AdminUser adminUserId, String authority);
    
    @Modifying
    @Transactional
    @Query("delete from AdminUserAuthority t where t.adminUserId.id=:adminUserId")
    void deleteByAdminUserId(@Param("adminUserId") Long adminUserId);
    
}
