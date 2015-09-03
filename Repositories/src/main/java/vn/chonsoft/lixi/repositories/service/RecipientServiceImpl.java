/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.repositories.RecipientRepository;

/**
 *
 * @author chonnh
 */
@Service
public class RecipientServiceImpl implements RecipientService{

    @Inject RecipientRepository reciRepository;
    
    @Override
    public Recipient findById(Long id) {
        
        return this.reciRepository.findOne(id);
        
    }

    /**
     * 
     * Used for check unique recipient :D
     * 
     * @param firstName
     * @param middleName
     * @param lastName
     * @param phone
     * @return 
     */
    @Override
    public Recipient findByFirstNameAndMiddleNameAndLastNameAndPhone(String firstName, String middleName, String lastName, String phone){
        
        return this.reciRepository.findByFirstNameAndMiddleNameAndLastNameAndPhone(firstName, middleName, lastName, phone);
        
    }
    /**
     * 
     * 
     * @param rec
     * @return the saved entity
     */
    @Override
    @Transactional
    public Recipient save(Recipient rec) {
        
        return this.reciRepository.save(rec);
        
    }
    
    /**
     * 
     * @param phone
     * @param id
     * @return 
     */
    @Override
    public int updatePhone(String phone, Long id){
        
        return this.reciRepository.updatePhone(phone, id);
    }
    
    @Override
    public int updateEmail(String email, Long id){
        
        return this.reciRepository.updateEmail(email, id);
        
    }
}
