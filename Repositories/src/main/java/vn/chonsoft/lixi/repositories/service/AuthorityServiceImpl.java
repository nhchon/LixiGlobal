/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.Authority;
import vn.chonsoft.lixi.repositories.AuthorityRepository;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class AuthorityServiceImpl implements AuthorityService{

    @Inject AuthorityRepository authRepository;
    
    @Override
    public List<Authority> findAll() {
        
        return LiXiRepoUtils.toList(this.authRepository.findAll());
        
    }
    
    
}
