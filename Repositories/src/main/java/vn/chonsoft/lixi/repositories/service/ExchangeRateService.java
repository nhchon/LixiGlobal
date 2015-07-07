/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.validation.constraints.NotNull;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.trader.ExchangeRate;
import vn.chonsoft.lixi.model.trader.Trader;

/**
 *
 * @author chonnh
 */
@Validated
public interface ExchangeRateService {
    
    /**
     * 
     * @param exr 
     */
    void save(@NotNull(message = "{validate.exchangeRateService.save.notnull}") ExchangeRate exr);
    
    /**
     * 
     * @param trader
     * @return 
     */
    List<ExchangeRate> findByTraderId(Trader trader);
    
    /**
     * 
     * @param trader
     * @return 
     */
    ExchangeRate findLastERByTraderId(Trader trader);
}
