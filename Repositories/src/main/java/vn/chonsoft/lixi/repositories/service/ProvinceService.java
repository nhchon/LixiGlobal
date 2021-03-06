/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.Province;

/**
 *
 * @author Asus
 */
public interface ProvinceService {
    
    Province findById(Integer id);
    
    List<Province> findAll();
}
