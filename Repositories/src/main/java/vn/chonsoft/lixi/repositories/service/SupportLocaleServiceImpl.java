/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.SupportLocale;
import vn.chonsoft.lixi.repositories.SupportLocaleRepository;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class SupportLocaleServiceImpl implements SupportLocaleService{

    @Inject SupportLocaleRepository supportLocaleRepository;
    
    /**
     * 
     * @return 
     */
    @Override
    public List<SupportLocale> findAll() {

        return LiXiRepoUtils.toList(this.supportLocaleRepository.findAll());
        
    }
    
    
}
