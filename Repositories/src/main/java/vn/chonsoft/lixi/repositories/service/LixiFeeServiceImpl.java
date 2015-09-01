/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiFee;
import vn.chonsoft.lixi.repositories.LixiFeeRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiFeeServiceImpl implements LixiFeeService{

    @Inject
    private LixiFeeRepository feeRepository;
    
    @Override
    public LixiFee findByCode(String code) {
        
        return this.feeRepository.findByCode(code);
        
    }
    
}
