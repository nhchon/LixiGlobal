/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.UserSession;
import vn.chonsoft.lixi.repositories.UserSessionRepository;

/**
 *
 * @author Asus
 */
@Service
public class UserSessionServiceImpl implements UserSessionService{

    @Autowired
    private UserSessionRepository usRepo;
    
    @Override
    public void save(UserSession us) {
        this.usRepo.save(us);
    }

    @Override
    public void delete(UserSession us) {
        this.usRepo.delete(us);
    }

    @Override
    public void deleteByEmail(String email){
        this.usRepo.deleteByEmail(email);
    }
    
    @Override
    public UserSession findByEmail(String email) {
        return this.usRepo.findByEmail(email);
    }
    
}
