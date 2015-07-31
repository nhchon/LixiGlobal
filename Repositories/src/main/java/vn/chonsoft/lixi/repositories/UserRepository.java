/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
public interface UserRepository extends JpaRepository<User, Long>{
    
    User findByEmail(String email);
    
    User findByActiveCode(String code);

    @Modifying
    @Transactional
    @Query("update User u set u.password = :password where u.id = :id")
    int updatePassword(@Param("password") String password, @Param("id") Long id);
    
    @Modifying
    @Transactional
    @Query("update User u set u.enabled = :enabled where u.id = :id")
    int updateEnaled(@Param("enabled") Boolean enabled, @Param("id") Long id);
    
    @Modifying
    @Transactional
    @Query("update User u set u.activeCode = :activeCode where u.id = :id")
    int updateActiveCode(@Param("activeCode") String activeCode, @Param("id") Long id);    
}
