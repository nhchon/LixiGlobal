/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.validation.constraints.NotNull;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.VatgiaCategory;

/**
 *
 * @author chonnh
 */
@Validated
public interface VatgiaCategoryService {
    
    void save(@NotNull(message = "{validate.thethingtosavemustnotbenull}") VatgiaCategory vg);
    
    void save(Iterable<VatgiaCategory> vgs);
    
    void delete(Integer id);
    
    VatgiaCategory findOne(Integer id);
    
    List<VatgiaCategory> findAll();
    
}
