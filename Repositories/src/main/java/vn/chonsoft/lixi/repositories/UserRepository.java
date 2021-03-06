/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
    
    @Transactional
    Page<User> findByActivated(boolean activated, Pageable page);
    
    List<User> findByEmail(String email);
    
    User findByEmailAndEnabled(String email, boolean enabled);
    
    @Modifying
    @Transactional
    @Query("update User u set u.authorizeProfileId = :profileId where u.id = :id")
    int updateAuthorizeProfileId(@Param("profileId") String profileId, @Param("id") Long id);
    
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
    @Query("update User u set u.activated = :activated where u.id = :id")
    int updateActivated(@Param("activated") Boolean activated, @Param("id") Long id);  
    
    @Modifying
    @Transactional
    @Query("update User u set u.email = :email where u.id = :id")
    int updateEmail(@Param("email") String email, @Param("id") Long id);
    
    @Modifying
    @Transactional
    @Query("update User u set u.phone = :phone where u.id = :id")
    int updatePhoneNumber(@Param("phone") String phoneNumber, @Param("id") Long id);
}
