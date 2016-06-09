/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
    int updateStatus(@Param("lixiStatus") String lixiStatus, @Param("id") Long id);
    
    @Transactional
    List<LixiOrder> findByIdIn(List<Long> ids, Sort sort);
    
    //@Transactional
    //@Query("SELECT o FROM LixiOrder o WHERE o.modifiedDate BETWEEN :begin AND :end")
    //Page<LixiOrder> findByModifiedDate(@Param("begin") Date begin, @Param("end") Date end, Pageable page);
    LixiOrder findByIdAndSender(Long id, User sender);    
    
    Page<LixiOrder> findById(Long id, Pageable page);
    
    Page<LixiOrder> findByModifiedDateBetween(Date begin, Date end, Pageable page);
    
    Page<LixiOrder> findBySenderAndModifiedDateBetween(User sender, Date begin, Date end, Pageable page);
    
    Page<LixiOrder> findBySender(User sender, Pageable page);
    
    Page<LixiOrder> findByLixiStatus(String status, Pageable page);
    
    List<LixiOrder> findByLixiStatus(String status, Sort sort);
    
    List<LixiOrder> findByLixiSubStatus(String status, Sort sort);
    
    List<LixiOrder> findByLixiStatusAndLixiSubStatus(String status, String subStatus, Sort sort);
    
    Page<LixiOrder> findByLixiStatusAndLixiSubStatus(String status, String subStatus, Pageable page);
    
    List<LixiOrder> findBySenderAndLixiStatus(User sender, String status);
}
