/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.RecAdd;
import vn.chonsoft.lixi.repositories.RecAddRepository;

/**
 *
 * @author Asus
 */
@Service
public class RecAddServiceImpl implements RecAddService{

    @Autowired
    private RecAddRepository recAddRepository;

    /**
     * 
     * @param id 
     */
    @Override
    public void delete(Long id){
        this.recAddRepository.delete(id);
    }
    /**
     * 
     * @param email
     * @param id
     * @return 
     */
    @Override
    public RecAdd findById(String email, Long id) {
        
        return this.recAddRepository.findByEmailAndId(email, id);
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public RecAdd findById(Long id) {
        return this.recAddRepository.findOne(id);
    }
    
    
    /**
     * 
     * @param email
     * @return 
     */
    @Override
    public List<RecAdd> findByEmail(String email){
        
        return this.recAddRepository.findByEmail(email);
    }
    /**
     * 
     * @param recAdd 
     * @return 
     */
    @Override
    public RecAdd save(RecAdd recAdd) {
        return this.recAddRepository.save(recAdd);
    }
    
}
