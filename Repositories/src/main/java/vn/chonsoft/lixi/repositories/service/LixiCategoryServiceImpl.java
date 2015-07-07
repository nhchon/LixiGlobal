/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.repositories.LixiCategoryRepository;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class LixiCategoryServiceImpl implements LixiCategoryService{

    @Inject LixiCategoryRepository lxcRepository;
    
    /**
     * 
     * @param lxc 
     */
    @Override
    @Transactional
    public void save(LixiCategory lxc) {
        
        this.lxcRepository.save(lxc);
        
    }

    /**
     * 
     * @return 
     */
    @Override
    public List<LixiCategory> findAll() {

        return LiXiRepoUtils.toList(this.lxcRepository.findAll());
    
    }
    
    @Override
    @Transactional
    public void deleteByVatGiaId(Integer vatgiaId){
        
        this.lxcRepository.deleteByVatgiaId(vatgiaId);
        
    }
}
