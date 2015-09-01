/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.VatgiaProduct;

/**
 *
 * @author chonnh
 */
public interface VatgiaProductRepository extends JpaRepository<VatgiaProduct, Integer>{
    
    @Modifying
    @Transactional
    @Query("update VatgiaProduct p set p.alive = :alive where p.categoryId = :categoryId")
    int updateAlive(@Param("categoryId") Integer categoryId, @Param("alive") Integer alive);
    
    List<VatgiaProduct>  findByCategoryIdAndAliveAndPriceIsGreaterThanEqual(int category, int alive, double price);

}
