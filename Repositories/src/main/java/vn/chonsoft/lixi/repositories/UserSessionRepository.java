/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.UserSession;

/**
 *
 * @author Asus
 */
public interface UserSessionRepository   extends JpaRepository<UserSession, Long>{
    
    UserSession findByEmail(String email);
    
    void deleteByEmail(String email);
}
