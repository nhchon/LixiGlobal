/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.RecAdd;
import vn.chonsoft.lixi.repositories.RecAddRepository;

/**
 *
 * @author Asus
 */
@Service
public class RecAddServiceImpl implements RecAddService{

    private RecAddRepository recAddRepository;
    
    /**
     * 
     * @param recAdd 
     */
    @Override
    public void save(RecAdd recAdd) {
        this.recAddRepository.save(recAdd);
    }
    
}
