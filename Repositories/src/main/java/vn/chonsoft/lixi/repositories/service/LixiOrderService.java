/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
@Validated
public interface LixiOrderService {
    
    int updateStatus(String status, Long id);
    
    @Transactional
    LixiOrder save(LixiOrder order);
    
    @Transactional
    LixiOrder findById(Long id);

    @Transactional
    LixiOrder findByIdAndSender(Long id, User sender);

    @Transactional
    LixiOrder findLastOrder(User user);
    
    @Transactional
    LixiOrder findLastBySenderAndLixiStatus(User sender, String status);
    
    @Transactional
    List<LixiOrder> findAll(List<Long> ids);
    
    @Transactional
    Page<LixiOrder> findBySender(User sender, Pageable page);
    
    @Transactional
    Page<LixiOrder> findByLixiStatus(String status, Pageable page);
    
    @Transactional
    List<LixiOrder> findByLixiStatus(String status);
    
    @Transactional
    List<LixiOrder> findByLixiStatus(String status, String subStatus);
    
    @Transactional
    List<LixiOrder> findByLixiSubStatus(String status);
    
    @Transactional
    Page<LixiOrder> findByModifiedDate(User sender, Date begin, Date end, Pageable page);
}
