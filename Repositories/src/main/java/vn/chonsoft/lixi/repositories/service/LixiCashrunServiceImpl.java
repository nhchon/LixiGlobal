/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiCashrun;
import vn.chonsoft.lixi.repositories.LixiCashrunRepository;

/**
 *
 * @author Asus
 */
@Service
public class LixiCashrunServiceImpl implements LixiCashrunService{
    
    @Autowired
    private LixiCashrunRepository cashRepository;

    /**
     * 
     * @param cashrun 
     */
    @Override
    public void save(LixiCashrun cashrun) {
        
        this.cashRepository.save(cashrun);
        
    }
}
