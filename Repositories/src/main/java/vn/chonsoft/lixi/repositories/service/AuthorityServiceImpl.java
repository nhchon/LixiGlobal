/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.Authority;
import vn.chonsoft.lixi.repositories.AuthorityRepository;

/**
 *
 * @author chonnh
 */
@Service
public class AuthorityServiceImpl implements AuthorityService{

    @Inject AuthorityRepository authRepository;
    
    @Override
    public List<Authority> findByParentId(Long parentId){
        
        return this.authRepository.findByParentId(parentId);
    }
    
    /**
     * 
     * @return 
     */
    @Override
    public List<Authority> findAll() {
        
        List<Authority> loa = this.authRepository.findAll(new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        
        loa.forEach(a ->{
            
            a.setChildren(this.findByParentId(a.getId()));
            
        });
        
        return loa;
        
    }
    
    
}
