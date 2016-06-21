/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import vn.chonsoft.lixi.model.UserSession;

/**
 *
 * @author Asus
 */
public interface UserSessionService {
    
    void save(UserSession us);
    
    void delete(UserSession us);
    
    void deleteByEmail(String email);
    
    UserSession findByEmail(String email);
}
