/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.TopUpResult;
import vn.chonsoft.lixi.repositories.TopUpResultRepository;

/**
 *
 * @author chonnh
 */
@Service
public class TopUpResultServiceImpl implements TopUpResultService{
    
    @Inject
    private TopUpResultRepository turRepository;

    /**
     * 
     * @param tur
     * @return 
     */
    @Override
    public TopUpResult save(TopUpResult tur) {
        
        return this.turRepository.save(tur);
        
    }
}
