/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.validation.constraints.NotNull;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiExchangeRate;

/**
 *
 * @author chonnh
 */
@Validated
public interface LixiExchangeRateService {
    
    @Scheduled(fixedDelay=1*60*60*1000, initialDelay=60*1000)
    void autoUpdateExFromVCB();
    /**
     * 
     * @param lx 
     */
    void save(@NotNull(message = "{validate.thethingtosavemustnotbenull}") LixiExchangeRate lx);
    
    LixiExchangeRate findById(Long id);
    /**
     * 
     * @return 
     */
    List<LixiExchangeRate> findAll();
    
    LixiExchangeRate findLastRecord(String code);
}
