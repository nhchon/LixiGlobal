/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;

/**
 *
 * @author chonnh
 */
public interface LixiInvoiceService {
    
    @Transactional
    LixiInvoice save(LixiInvoice invoice);
    
    @Transactional
    LixiInvoice findById(long id);
    
    @Transactional
    LixiInvoice findByNetTransId(String transId);
    
    @Transactional
    LixiInvoice findByOrder(LixiOrder order);
    
    @Transactional
    List<LixiInvoice> findAll();
    
    @Transactional
    List<LixiInvoice> findByNetResponseCode(Iterable<String> code);
    
    @Transactional
    List<LixiInvoice> findByNetTransStatusIn(Iterable<String> status);
    
    @Transactional
    List<LixiInvoice> findByPayerAndInvoiceStatusIn(Long payer, Iterable<String> invStatus);
    
    @Transactional
    List<LixiInvoice> findByPayerAndInvoiceStatus(Long payer, String invStatus);
    
    @Transactional
    List<LixiInvoice> findByInvoiceStatus(String invStatus);
    
    @Transactional
    List<LixiInvoice> findByInvoiceStatusIn(Iterable<String> invStatus);
    
    @Transactional
    List<LixiInvoice> findByMonitored(Integer monitored);
    
}
