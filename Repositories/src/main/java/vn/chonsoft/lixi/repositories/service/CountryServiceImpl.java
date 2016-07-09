/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.Country;
import vn.chonsoft.lixi.repositories.CountryRepository;

/**
 *
 * @author chonnh
 */
@Service
public class CountryServiceImpl implements CountryService{
    
    @Autowired
    private CountryRepository cRepository;

    @Override
    public Country findById(Long id){
        
        return this.cRepository.findOne(id);
        
    }
    
    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public Country findByCode(String code){
        
        return this.cRepository.findByCode(code);
    }
    /**
     * 
     * @param name
     * @return 
     */
    @Override
    public Country findByName(String name){
        
        return this.cRepository.findByName(name);
    }
    
    /**
     * 
     * @return 
     */
    @Override
    @Transactional
    public List<Country> findAll() {
        
        List<Country> countries = this.cRepository.findAll();
        
        /* make sure to load fee for every countries */
        countries.forEach(c -> {c.getFees().size();});
        
        return countries;
    }
    
    
}
