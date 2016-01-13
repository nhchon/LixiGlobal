/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.repositories.UserCardRepository;

/**
 *
 * @author chonnh
 */
@Service
public class UserCardServiceImpl implements UserCardService{

    @Inject UserCardRepository ucRepository;
    
    /**
     * 
     * @param uc
     * @return 
     */
    @Override
    @Transactional
    public UserCard save(UserCard uc) {

        return this.ucRepository.save(uc);
        
    }
    
    /**
     * 
     * @param id 
     */
    @Override
    public void delete(Long id){
        
        this.ucRepository.delete(id);
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public UserCard findById(Long id){
        
        UserCard uc = this.ucRepository.findOne(id);
        if(uc != null){
            
            // load billing address
            uc.getBillingAddress();
        }
        
        return uc;
        
    }
    /**
     * 
     * @param u
     * @return 
     */
    @Override
    public List<UserCard> findByUser(User u) {
        
        return this.ucRepository.findByUser(u);
        
    }
    
    /**
     * 
     * Used to check the card id belong to user
     * 
     * @param id
     * @param u
     * @return 
     */
    @Override
    @Transactional
    public UserCard findByIdAndUser(Long id, User u){
        
        UserCard c = this.ucRepository.findByIdAndUser(id, u);
        if(c != null){
            c.getUser();
            c.getBillingAddress();
        }
        
        return c;
        
    }
    
    /**
     * 
     * card number is unique
     * 
     * @param cardNumber
     * @return 
     */
    @Override
    public UserCard findByCardNumber(String cardNumber){
        
        return this.ucRepository.findByCardNumber(cardNumber);
    }
    
    /**
     * 
     * @param authorizePaymentId
     * @return 
     */
    @Override
    public UserCard findByAuthorizePaymentId(String authorizePaymentId){
       
        return this.ucRepository.findByAuthorizePaymentId(authorizePaymentId);
        
    }
    
    /**
     * 
     * @param paymentId
     * @param id
     * @return 
     */
    @Override
    @Transactional
    public int updateAuthorizeProfileId(String paymentId, Long id){
        
        return this.ucRepository.updateAuthorizeProfileId(paymentId, id);
    }
}
