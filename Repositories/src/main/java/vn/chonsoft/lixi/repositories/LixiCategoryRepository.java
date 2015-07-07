/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiCategory;

/**
 *
 * @author chonnh
 */
public interface LixiCategoryRepository extends JpaRepository<LixiCategory, Long>{
    
    @Modifying
    @Transactional
    @Query("delete from LixiCategory t where t.vatgiaId.id=:vatgiaId")
    void deleteByVatgiaId(@Param("vatgiaId") Integer vatgiaId);
}
