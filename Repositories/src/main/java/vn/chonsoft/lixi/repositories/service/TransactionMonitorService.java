/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.scheduling.annotation.Async;
import vn.chonsoft.lixi.model.LixiOrder;

/**
 *
 * @author Asus
 */
public interface TransactionMonitorService {
    
    @Async
    void transactions(LixiOrder order);
}
