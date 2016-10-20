/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.VatgiaProduct;

/**
 *
 * @author chonnh
 */
@Validated
public interface VatgiaProductService {
    
    @Transactional
    VatgiaProduct save(VatgiaProduct product);
    
    @Transactional
    List<VatgiaProduct> save(List<VatgiaProduct> products);
    
    VatgiaProduct findById(Integer id);
    
    List<VatgiaProduct> findById(Iterable<Integer> ids);
    
    List<VatgiaProduct> findByCategoryIdAndAliveAndPrice(int category, int alive, double price);
    
    List<VatgiaProduct> findByCategoryIdAndAlive(int category, int alive, Sort sort);
    
    Page<VatgiaProduct> findByCategoryIdAndAliveAndPrice(int category, int alive, double price, Pageable page);
    
    Page<VatgiaProduct> findByName(String name, Pageable page);
    
    int updateAlive(Integer category, Integer alive);
    
    void loadAllVatGiaProducts();
    
    Page<VatgiaProduct> findAll(Pageable page);
}
