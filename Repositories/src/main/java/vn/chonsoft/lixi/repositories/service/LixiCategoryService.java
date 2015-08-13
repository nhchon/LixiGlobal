/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.validation.constraints.NotNull;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiCategory;

/**
 *
 * @author chonnh
 */
@Validated
public interface LixiCategoryService {
    
    void save(@NotNull(message = "{validate.thethingtosavemustnotbenull}") LixiCategory lxc);
    
    List<LixiCategory> findAll();
    
    List<LixiCategory> findByLocaleCode(String code);
    
    void deleteByVatGiaId(Integer vatgiaId);
}
