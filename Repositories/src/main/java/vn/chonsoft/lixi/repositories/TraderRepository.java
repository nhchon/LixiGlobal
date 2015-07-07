/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.trader.Trader;

/**
 *
 * @author chonnh
 */
public interface TraderRepository extends JpaRepository<Trader, Long> {
    
    Trader findByEmail(String email);

    Trader findByPhone(String phone);
    
    Trader findByUsername(String username);
    
    Trader findById(Long id);
}
