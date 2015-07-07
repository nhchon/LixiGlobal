/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.trader.Trader;
import vn.chonsoft.lixi.repositories.TraderRepository;
import vn.chonsoft.lixi.repositories.util.LiXiRepoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class TraderServiceImpl implements TraderService{

    @Inject TraderRepository traderRepository;
    
    /**
     * 
     * @param trader 
     */
    @Override
    @Transactional
    public void save(Trader trader) {
        
        this.traderRepository.save(trader);
        
    }

    /**
     * 
     * @param email
     * @return 
     */
    @Override
    public Trader checkUniqueEmail(String email) {
        
        return this.traderRepository.findByEmail(email);
        
    }

    /**
     * 
     * @param phone
     * @return 
     */
    @Override
    public Trader checkUniquePhone(String phone) {
        
        return this.traderRepository.findByPhone(phone);
        
    }

    /**
     * 
     * @param username
     * @return 
     */
    @Override
    public Trader findByUsername(String username) {
        
        return this.traderRepository.findByUsername(username);
        
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public Trader findById(Long id) {

        return this.traderRepository.findById(id);
    }

    /**
     * 
     * @return 
     */
    @Override
    public List<Trader> findAll() {
        
        return LiXiRepoUtils.toList(this.traderRepository.findAll());
        
    }
    
    
}
