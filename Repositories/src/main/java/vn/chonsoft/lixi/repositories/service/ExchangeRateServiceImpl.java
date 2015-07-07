/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.trader.ExchangeRate;
import vn.chonsoft.lixi.model.trader.Trader;
import vn.chonsoft.lixi.repositories.ExchangeRateRepository;

/**
 *
 * @author chonnh
 */
@Service
public class ExchangeRateServiceImpl implements ExchangeRateService{

    @Inject ExchangeRateRepository exrRepository;
    
    /**
     * 
     * @param exr 
     */
    @Override
    @Transactional
    public void save(ExchangeRate exr) {
        
        this.exrRepository.save(exr);
        
    }

    /**
     * 
     * @param trader
     * @return 
     */
    @Override
    public List<ExchangeRate> findByTraderId(Trader trader) {
        
        return this.exrRepository.findByTraderId(trader, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
    }

    /**
     * 
     * @param trader
     * @return 
     */
    @Override
    public ExchangeRate findLastERByTraderId(Trader trader) {

        Pageable just1rec = new PageRequest(0, 1, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
    
        Page<ExchangeRate> per = this.exrRepository.findByTraderId(trader, just1rec);
        
        if(per != null && per.hasContent()){
            
            return per.getContent().get(0);
            
        }
        else{
            return null;
        }
        
    }
    
    
}
