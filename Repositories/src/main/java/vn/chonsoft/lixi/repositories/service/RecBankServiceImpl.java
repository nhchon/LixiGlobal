/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

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
     * @param rBank
     * @return 
     */
    @Override
    public RecBank save(RecBank rBank) {
        
        return this.rbRepo.save(rBank);
    }
}
