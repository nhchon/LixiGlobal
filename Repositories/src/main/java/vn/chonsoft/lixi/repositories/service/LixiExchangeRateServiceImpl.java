/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.repositories.LixiExchangeRateRepository;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class LixiExchangeRateServiceImpl implements LixiExchangeRateService{

    @Inject LixiExchangeRateRepository lxrRepository;
    
    /**
     * 
     * @param lx 
     */
    @Override
    @Transactional
    public void save(LixiExchangeRate lx) {
        
        this.lxrRepository.save(lx);
        
    }

    /**
     * 
     * @return 
     */
    @Override
    public List<LixiExchangeRate> findAll() {

        return LiXiRepoUtils.toList(this.lxrRepository.findAll(new Sort(new Sort.Order(Sort.Direction.DESC, "id"))));
        
    }
    
    
}
