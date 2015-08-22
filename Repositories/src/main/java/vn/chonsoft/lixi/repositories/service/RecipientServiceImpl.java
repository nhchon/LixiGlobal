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
}
