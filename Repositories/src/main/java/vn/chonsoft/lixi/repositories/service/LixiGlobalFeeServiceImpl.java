/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiGlobalFee;
import vn.chonsoft.lixi.repositories.LixiGlobalFeeRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiGlobalFeeServiceImpl implements LixiGlobalFeeService{
    
    @Autowired
    private LixiGlobalFeeRepository fRepository;

    @Override
    public LixiGlobalFee save(LixiGlobalFee fee) {
        
        return this.fRepository.save(fee);
    }
}
