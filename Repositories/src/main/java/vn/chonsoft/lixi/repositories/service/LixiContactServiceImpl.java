/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiContact;
import vn.chonsoft.lixi.repositories.LixiContactRepository;

/**
 *
 * @author Asus
 */
@Service
public class LixiContactServiceImpl implements LixiContactService{

    @Autowired
    private LixiContactRepository lcRepository;
    
    /**
     * 
     * @param c
     * @return 
     */
    @Override
    public LixiContact save(LixiContact c) {
        return this.lcRepository.save(c);
    }
    
}
