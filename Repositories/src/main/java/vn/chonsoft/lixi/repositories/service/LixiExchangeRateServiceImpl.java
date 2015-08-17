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

    @Override
    public LixiExchangeRate findById(Long id){
        
        return this.lxrRepository.findOne(id);
        
    }
    /**
     * 
     * @return 
     */
    @Override
    public List<LixiExchangeRate> findAll() {

        return LiXiRepoUtils.toList(this.lxrRepository.findAll(new Sort(new Sort.Order(Sort.Direction.DESC, "id"))));
        
    }
    
    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public LixiExchangeRate findLastRecord(String code){
        
        Pageable just1rec = new PageRequest(0, 1, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        Page<LixiExchangeRate> p1 = this.lxrRepository.findByCurrency_Code(code, just1rec);
        
        if(p1 != null){
            
            List<LixiExchangeRate> l1 = p1.getContent();
            
            if(l1 != null && !l1.isEmpty()){
                
                return l1.get(0);
                
            }
        }
        //
        return null;
    }
}
