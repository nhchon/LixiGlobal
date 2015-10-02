/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.VtcResponseCode;
import vn.chonsoft.lixi.repositories.VtcResponseCodeRepository;

/**
 *
 * @author chonnh
 */
@Service
public class VtcResponseCodeServiceImpl implements VtcResponseCodeService{
    
    @Inject
    private VtcResponseCodeRepository responseCodeRepository;

    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public VtcResponseCode findByCode(int code) {
        
        return this.responseCodeRepository.findByCode(code);
        
    }
}
