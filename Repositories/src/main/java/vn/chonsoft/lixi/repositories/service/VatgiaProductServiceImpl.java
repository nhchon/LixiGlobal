/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.repositories.VatgiaCategoryRepository;
import vn.chonsoft.lixi.repositories.VatgiaProductRepository;
import vn.chonsoft.lixi.repositories.util.LiXiVatGiaUtils;

/**
 *
 * @author chonnh
 */
@Service
public class VatgiaProductServiceImpl implements VatgiaProductService{

    @Inject
    private VatgiaProductRepository vgpRepository;
    
    @Inject
    private VatgiaCategoryRepository vgcRepository;
    
    /**
     * 
     * @param product
     * @return 
     */
    @Override
    @Transactional
    public VatgiaProduct save(VatgiaProduct product) {
        
        return this.vgpRepository.save(product);
        
    }

    /**
     * 
     * @param products
     * @return 
     */
    @Override
    @Transactional
    public List<VatgiaProduct> save(List<VatgiaProduct> products) {
        
        return this.vgpRepository.save(products);
        
    }
    
    /**
     * 
     * @param category
     * @param alive
     * @param price
     * @return 
     */
    @Override
    public List<VatgiaProduct> findByCategoryIdAndAliveAndPrice(int category, int alive, double price){
        
        return this.vgpRepository.findByCategoryIdAndAliveAndPriceIsGreaterThanEqual(category, alive, price);
        
    }
    
    /**
     * 
     * update alive attribute before load products again from BaoKim
     * 
     * @param category
     * @param alive
     * @return 
     */
    @Override
    @Transactional
    public int updateAlive(Integer category, Integer alive){
        
        return this.vgpRepository.updateAlive(category, alive);
        
    }
    ///////////////////////////////////////////////////////////////////////////
    /**
     * 
     */
    @Override
    @Scheduled(cron = "0 1 1 * * ?")
    public void loadAllVatGiaProducts(){
        
        // get list vatgia categories
        List<VatgiaCategory> categories = this.vgcRepository.findAll();
        
        for(VatgiaCategory c : categories){
            
            // get all products in the category (price >= 0)
            ListVatGiaProduct vgps = LiXiVatGiaUtils.getInstance().getVatGiaProducts(c.getId(), 0);
            
            List<VatgiaProduct> ps = LiXiVatGiaUtils.getInstance().convertVatGiaProduct2Model(vgps);
            
            // save to database
            synchronized(this){
                // update alive = 0
                updateAlive(c.getId(), 0);
                // update products
                this.vgpRepository.save(ps);
            }
        }
    }
    
}
