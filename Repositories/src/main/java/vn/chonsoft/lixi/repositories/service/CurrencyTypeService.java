/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.trader.CurrencyType;

/**
 *
 * @author chonnh
 */
public interface CurrencyTypeService {
    
    List<CurrencyType> findAll();
    
    CurrencyType findOne(Long id);
    
}
