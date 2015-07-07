/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.trader.CurrencyType;
import vn.chonsoft.lixi.model.trader.ExchangeRate;
import vn.chonsoft.lixi.model.trader.Trader;

/**
 *
 * @author chonnh
 */
public interface ExchangeRateRepository extends JpaRepository<ExchangeRate, Long> {
    
    List<ExchangeRate> findByTraderId(Trader trader, Sort sort);
    
    Page<ExchangeRate> findByTraderId(Trader trader, Pageable p);
    
    Page<ExchangeRate> findByTraderIdAndCurrencyId(Trader trader, CurrencyType cur, Pageable p);
}
