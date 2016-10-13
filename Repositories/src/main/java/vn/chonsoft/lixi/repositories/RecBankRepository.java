/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.RecBank;

/**
 *
 * @author Asus
 */
public interface RecBankRepository extends JpaRepository<RecBank, Long>{
    
}
