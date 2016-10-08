/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
public interface RecipientRepository extends JpaRepository<Recipient, Long>{
    
    @Modifying
    @Transactional
    @Query("update Recipient r set r.phone = :phone where r.id = :id")
    int updatePhone(@Param("phone") String password, @Param("id") Long id);
    
    @Modifying
    @Transactional
    @Query("update Recipient r set r.email = :email where r.id = :id")
    int updateEmail(@Param("email") String email, @Param("id") Long id);

    Recipient findBySenderAndFirstNameAndMiddleNameAndLastNameAndPhone(User sender, String firstName, String middleName, String lastName, String phone);
    
    Recipient findBySenderAndEmail(User sender, String email);
    
    Recipient findByEmail(String email);
}
