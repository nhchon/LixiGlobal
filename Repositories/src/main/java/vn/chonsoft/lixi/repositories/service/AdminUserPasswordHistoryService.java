/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.AdminUserPasswordHistory;

/**
 *
 * @author chonnh
 */
@Validated
public interface AdminUserPasswordHistoryService {
    
    void save(AdminUserPasswordHistory auph);
    
}
