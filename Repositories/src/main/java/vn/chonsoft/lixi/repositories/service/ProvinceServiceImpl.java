/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.Province;
import vn.chonsoft.lixi.repositories.ProvinceReporitosy;

/**
 *
 * @author Asus
 */
@Service
public class ProvinceServiceImpl implements ProvinceService{

    @Autowired
    private ProvinceReporitosy pRepo;
    
    @Override
    public Province findById(Integer id){
        return this.pRepo.findOne(id);
    }
    /**
     * 
     * @return 
     */
    @Override
    public List<Province> findAll() {
        
        return this.pRepo.findAll();
        
    }
    
}
