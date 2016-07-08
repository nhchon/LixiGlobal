/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiCategory;
import vn.chonsoft.lixi.model.VatgiaCategory;

/**
 *
 * @author chonnh
 */
public interface LixiCategoryRepository extends JpaRepository<LixiCategory, Integer>{
    
    //List<LixiCategory> findByLocale_Code(String code);
    
    //List<LixiCategory> findByLocale_Code(String code, Sort sort);
    
    LixiCategory findByCode(String code);
    
    LixiCategory findByVatgiaId(VatgiaCategory vatgiaId);
    
    @Modifying
    @Transactional
    @Query("delete from LixiCategory t where t.vatgiaId.id=:vatgiaId")
    void deleteByVatgiaId(@Param("vatgiaId") Integer vatgiaId);
}
