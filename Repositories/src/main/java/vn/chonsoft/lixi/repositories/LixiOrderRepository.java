/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
public interface LixiOrderRepository  extends JpaRepository<LixiOrder, Long>{
    
    @Modifying
    @Transactional
    @Query("update LixiOrder o set o.lixiStatus = :lixiStatus where o.id = :id")
    int updateStatus(@Param("lixiStatus") Integer lixiStatus, @Param("id") Long id);
    
    //@Transactional
    //@Query("SELECT o FROM LixiOrder o WHERE o.modifiedDate BETWEEN :begin AND :end")
    //Page<LixiOrder> findByModifiedDate(@Param("begin") Date begin, @Param("end") Date end, Pageable page);
    
    Page<LixiOrder> findByModifiedDateBetween(Date begin, Date end, Pageable page);
    
    Page<LixiOrder> findBySenderAndModifiedDateBetween(User sender, Date begin, Date end, Pageable page);
    
    Page<LixiOrder> findBySender(User sender, Pageable page);
    
    Page<LixiOrder> findByLixiStatus(Integer status, Pageable page);
    
    List<LixiOrder> findBySenderAndLixiStatus(User sender, Integer status);
}
