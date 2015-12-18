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
    
    LixiInvoice findById(long id);
    
    LixiInvoice findByNetTransId(String transId);
    
    LixiInvoice findByOrder(LixiOrder order);
    
    List<LixiInvoice> findByNetResponseCode(Iterable<String> code);
    
    List<LixiInvoice> findByNetTransStatusIn(Iterable<String> status);
}
