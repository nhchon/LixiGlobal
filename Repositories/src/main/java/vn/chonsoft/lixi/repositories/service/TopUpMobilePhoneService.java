/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;

/**
 *
 * @author chonnh
 */
@Validated
public interface TopUpMobilePhoneService {
    
    TopUpMobilePhone save(TopUpMobilePhone topUp);
    
    @Transactional
    void save(List<TopUpMobilePhone> ts);
    
    @Transactional
    TopUpMobilePhone findById(Long id);
    
    @Transactional
    List<TopUpMobilePhone> findByStatus(Iterable<String> status);

    @Transactional
    List<TopUpMobilePhone> findByStatus(String status);

    @Transactional
    List<TopUpMobilePhone> findByStatus(String lxStatus, String status);

    @Transactional
    Page<TopUpMobilePhone> findByStatusAndModifiedDate(Iterable<String> status, Date begin, Date end, Pageable page);
    
    @Transactional
    Page<TopUpMobilePhone> findByStatusAndFromDate(Iterable<String> status, Date begin, Pageable page);
    
    @Transactional
    Page<TopUpMobilePhone> findByStatusAndEndDate(Iterable<String> status, Date end, Pageable page);
    
    void deleteById(Long id);
    
    @Transactional
    Long deleteByOrderAndRecipient(LixiOrder order, Recipient recipient);
}
