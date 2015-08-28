/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.repositories.VatgiaCategoryRepository;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class VatgiaCategoryServiceImpl implements VatgiaCategoryService{

    @Inject VatgiaCategoryRepository vgcRepository;
    
    /**
     * 
     * @param vg 
     */
    @Override
    @Transactional
    public void save(VatgiaCategory vg) {
        
        this.vgcRepository.save(vg);
        
    }

    /**
     * 
     * @param vgs 
     */
    @Override
    @Transactional
    public void save(Iterable<VatgiaCategory> vgs) {

        this.vgcRepository.save(vgs);
        
    }

    @Override
    @Transactional
    public void delete(Integer id) {
        
        this.vgcRepository.delete(id);
        
    }

    
    /**
     * 
     * @param id
     * @return 
     */
    @Transactional
    @Override
    public VatgiaCategory findOne(Integer id) {
        
        VatgiaCategory vgc = this.vgcRepository.findOne(id);
        //
        if(vgc != null) {
            vgc.getLixiCategories();
        }
        //
        return vgc;
        
    }

    
    /**
     * 
     * @return 
     */
    @Transactional
    @Override
    public List<VatgiaCategory> findAll() {
        
        List<VatgiaCategory> vgcs = LiXiRepoUtils.toList(this.vgcRepository.findAll());
        for(VatgiaCategory vgc : vgcs){
            
            if(vgc != null){
                
                vgc.getLixiCategories();
                
            }
        }
        
        return vgcs;
        
    }
    
}
