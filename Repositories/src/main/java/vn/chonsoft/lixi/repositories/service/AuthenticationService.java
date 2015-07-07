/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.security.core.userdetails.UserDetailsService;
import vn.chonsoft.lixi.model.SecurityAdminUser;

/**
 *
 * @author chonnh
 */
public interface AuthenticationService extends UserDetailsService{

    @Override
    SecurityAdminUser loadUserByUsername(String username);
    
}
