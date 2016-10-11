/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.RecAdd;

/**
 *
 * @author Asus
 */
public interface RecAddRepository  extends  JpaRepository<RecAdd, Long>{
    
}
