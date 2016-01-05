/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.Country;
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
    
    /**
     * 
     * @param id 
     */
    @Override
    public void delete(Long id){
        
        this.fRepository.delete(id);
        
    }
    
    /**
     * 
     * @param country
     * @return 
     */
    @Override
    public List<LixiGlobalFee> findByCountry(Country country){
        
        Sort sort = new Sort(new Sort.Order(Sort.Direction.ASC, "amount"));
        
        return this.fRepository.findByCountry(country, sort);
        
    }
    
    /**
     * 
     * @param country
     * @param sort
     * @return 
     */
    @Override
    public List<LixiGlobalFee> findByCountry(Country country, Sort sort){
        
        return this.fRepository.findByCountry(country, sort);
    }
}
