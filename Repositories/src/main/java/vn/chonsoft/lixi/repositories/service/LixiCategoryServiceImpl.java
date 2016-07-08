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
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.repositories.LixiCategoryRepository;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

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
     * @param vgc
     * @return 
     */
    @Override
    public LixiCategory findByVatgiaCategory(VatgiaCategory vgc){
        
        return this.lxcRepository.findByVatgiaId(vgc);
        
    }
    /**
     * 
     * @return 
     */
    @Override
    public List<LixiCategory> findAll() {

        return LiXiGlobalUtils.toList(this.lxcRepository.findAll());
    
    }
    
    @Override
    public LixiCategory findByCode(String code){
        
        return this.lxcRepository.findByCode(code);
        
    }
    
    //@Override
    //public List<LixiCategory> findByLocaleCode(String code){
        
    //    return this.lxcRepository.findByLocale_Code(code);
        
    //}

    //@Override
    //public List<LixiCategory> findByLocaleCode(String code, Sort sort){
        
    //    return this.lxcRepository.findByLocale_Code(code, sort);
        
    //}
    
    @Transactional
    @Override
    public LixiCategory findById(Integer id){
        
        LixiCategory lxc = this.lxcRepository.findOne(id);
        if(lxc != null){
            // make sure
            lxc.getVatgiaId();
        }
        
        return lxc;
        
    }
    
    @Override
    @Transactional
    public void deleteByVatGiaId(Integer vatgiaId){
        
        this.lxcRepository.deleteByVatgiaId(vatgiaId);
        
    }
}
