/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
@Validated
public interface LixiOrderService {
    
    int updateStatus(Integer status, Long id);
    
    LixiOrder save(LixiOrder order);
    
    LixiOrder findLastOrder(User user);
    
    List<LixiOrder> findAll(List<Long> ids);
    
    LixiOrder findById(Long id);
    
    Page<LixiOrder> findByLixiStatus(Integer status, Pageable page);
    
    LixiOrder findLastBySenderAndLixiStatus(User sender, Integer status);
}
