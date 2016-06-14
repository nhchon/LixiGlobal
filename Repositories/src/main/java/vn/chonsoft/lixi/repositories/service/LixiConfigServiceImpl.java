/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiConfig;
import vn.chonsoft.lixi.repositories.LixiConfigRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiConfigServiceImpl implements LixiConfigService{
    
    @Autowired
    private LixiConfigRepository configRepo;

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public LixiConfig findById(Integer id){
        
        return this.configRepo.findById(id);
    }
    
    @Override
    public void delete(Integer id){
        
        this.configRepo.delete(id);
    }
    /**
     * 
     * @param config
     * @return 
     */
    @Override
    public LixiConfig save(LixiConfig config){
        
        return this.configRepo.save(config);
        
    }
    /**
     * 
     * @return 
     */
    @Override
    public List<LixiConfig> findAll() {
        
        return this.configRepo.findAll();
    }

    /**
     * 
     * @param name
     * @return 
     */
    @Override
    public LixiConfig findByName(String name) {
    
        return this.configRepo.findByName(name);
    }
}
