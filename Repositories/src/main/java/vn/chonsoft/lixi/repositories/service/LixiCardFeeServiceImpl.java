/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiCardFee;
import vn.chonsoft.lixi.repositories.LixiCardFeeRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiCardFeeServiceImpl implements LixiCardFeeService{

    @Inject
    private LixiCardFeeRepository cardFeeRepository;

    /**
     * 
     * @param cardType
     * @param creditDebit
     * @param country
     * @return 
     */
    @Override
    public LixiCardFee findByCardTypeAndCreditDebitAndCountry(int cardType, String creditDebit, String country) {
        
        return this.cardFeeRepository.findByCardTypeAndCreditDebitAndCountry(cardType, creditDebit, country);
        
    }
}
