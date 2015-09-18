/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.repositories.TopUpMobilePhoneRepository;

/**
 *
 * @author chonnh
 */
@Service
public class TopUpMobilePhoneServiceImpl implements TopUpMobilePhoneService{
    
    @Inject
    private TopUpMobilePhoneRepository topUpRepository;

    /**
     * 
     * @param topUp
     * @return 
     */
    @Override
    public TopUpMobilePhone save(TopUpMobilePhone topUp) {
        
        return this.topUpRepository.save(topUp);
    }
}
