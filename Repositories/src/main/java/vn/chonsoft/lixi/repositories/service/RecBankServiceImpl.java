/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.RecBank;
import vn.chonsoft.lixi.repositories.RecBankRepository;

/**
 *
 * @author Asus
 */
@Service
public class RecBankServiceImpl implements RecBankService{
    
    @Autowired
    private RecBankRepository rbRepo;

    /**
     * 
     * @param email
     * @param id
     * @return 
     */
    @Override
    public RecBank findById(String email, Long id){
        
        return this.rbRepo.findByIdAndRecEmail(id, email);
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public RecBank findById(Long id){
        
        return this.rbRepo.findOne(id);
    }
    
    /**
     * 
     * @param id 
     */
    @Override
    public void delete(Long id){
        this.rbRepo.delete(id);
    }
    
    /**
     * 
     * @param email
     * @return 
     */
    @Override
    public List<RecBank> findByEmail(String email){
        
        return this.rbRepo.findByRecEmail(email);
        
    }
    
    /**
     * 
     * @param rBank
     * @return 
     */
    @Override
    public RecBank save(RecBank rBank) {
        
        return this.rbRepo.save(rBank);
    }
}
