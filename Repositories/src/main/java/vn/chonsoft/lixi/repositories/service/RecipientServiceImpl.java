/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.repositories.RecipientRepository;

/**
 *
 * @author chonnh
 */
@Service
public class RecipientServiceImpl implements RecipientService{

    @Autowired
    private RecipientRepository reciRepository;
    
    @Override
    @Transactional
    public Page<Recipient> findAll(Pageable page){
        
        Page<Recipient> ps = this.reciRepository.findAll(page);
        if(ps != null && ps.hasContent()){
            ps.getContent().forEach(t -> {
                t.getSender();
            });
        }
        
        return ps;        
        
    }
    
    @Override
    public Recipient findById(Long id) {
        
        return this.reciRepository.findOne(id);
        
    }
    
    /**
     * 
     * @param sender 
     * @param email
     * @return 
     */
    @Override
    public Recipient findByEmail(User sender, String email){
        
        return this.reciRepository.findBySenderAndEmail(sender, email);
    }
    /**
     * 
     * Used for check unique recipient :D
     * 
     * @param sender 
     * @param firstName
     * @param middleName
     * @param lastName
     * @param phone
     * @return 
     */
    @Override
    public Recipient findByNameAndPhone(User sender, String firstName, String middleName, String lastName, String phone){
        
        return this.reciRepository.findBySenderAndFirstNameAndMiddleNameAndLastNameAndPhone(sender, firstName, middleName, lastName, phone);
        
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
