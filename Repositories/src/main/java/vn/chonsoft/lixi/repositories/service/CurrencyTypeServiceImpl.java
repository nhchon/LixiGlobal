/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.trader.CurrencyType;
import vn.chonsoft.lixi.repositories.CurrencyTypeRepository;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
@Service
public class CurrencyTypeServiceImpl implements CurrencyTypeService{

    /* */
    @Inject CurrencyTypeRepository currencyRepository;
    
    /**
     * 
     * @return 
     */
    @Override
    public List<CurrencyType> findAll() {

        return LiXiGlobalUtils.toList(this.currencyRepository.findAll(new Sort(new Sort.Order(Sort.Direction.ASC, "sortOrder"))));
        
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public CurrencyType findOne(Long id) {

        return this.currencyRepository.findOne(id);
        
    }
    
    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public CurrencyType findByCode(String code){
        
        return this.currencyRepository.findByCode(code);
        
    }
}
