/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.UserSecretCode;
import vn.chonsoft.lixi.repositories.UserSecretCodeRepository;

/**
 *
 * @author chonnh
 */
@Service
public class UserSecretCodeServiceImpl implements UserSecretCodeService{

    @Inject UserSecretCodeRepository uscRepository;
    
    /**
     * 
     * @param usc 
     */
    @Override
    public void save(UserSecretCode usc) {
        
        this.uscRepository.save(usc);
        
    }

    /**
     * 
     * @param id 
     */
    @Override
    public void delete(Long id) {
        
        this.uscRepository.delete(id);
        
    }

    /**
     * 
     * @param code 
     */
    @Override
    public void deleteByCode(String code){
        
        try {
            this.uscRepository.deleteByCode(code);
        } catch (Exception e) {
            // Nothing todo
        }
        
    }
    /**
     * 
     * @param code
     * @return 
     */
    @Override
    @Transactional
    public UserSecretCode findByCode(String code) {
        
        UserSecretCode usc = this.uscRepository.findByCode(code);
        if(usc != null){
            // sure to user is loaded
            usc.getUserId().getId();
        }
        
        return usc;
        
    }
    
}
