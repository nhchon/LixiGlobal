/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;

/**
 *
 * @author chonnh
 */
public interface LixiInvoiceRepository extends JpaRepository<LixiInvoice, Long>{
    
    LixiInvoice findByOrder(LixiOrder order);
    
    LixiInvoice findByNetTransId(String transId);
    
    List<LixiInvoice> findByNetResponseCodeIn(Iterable<String> code);

    List<LixiInvoice> findByNetTransStatusIn(Iterable<String> status);
    
}
