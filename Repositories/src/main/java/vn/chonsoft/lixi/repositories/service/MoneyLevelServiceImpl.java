/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.MoneyLevel;
import vn.chonsoft.lixi.repositories.MoneyLevelRepository;

/**
 *
 * @author chonnh
 */
@Service
public class MoneyLevelServiceImpl implements MoneyLevelService{

    @Inject
    private MoneyLevelRepository mnlRepository;
    
    /**
     * 
     * @param isDefault
     * @return 
     */
    @Override
    public MoneyLevel findByIsDefault() {

        List<MoneyLevel> ls = this.mnlRepository.findByIsDefault(true);
        
        if(ls != null && !ls.isEmpty()){
            
            return ls.get(0);
            
        }
        //
        return null;
    }
    
    
}
