/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

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
    LixiInvoice findByOrder(LixiOrder order);
}
