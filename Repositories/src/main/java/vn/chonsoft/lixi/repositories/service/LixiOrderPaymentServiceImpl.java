/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.LixiOrderPayment;
import vn.chonsoft.lixi.repositories.LixiOrderPaymentRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiOrderPaymentServiceImpl implements LixiOrderPaymentService{
    
    @Inject
    private LixiOrderPaymentRepository paymentRepository;

    /**
     * 
     * @param payment
     * @return 
     */
    @Override
    public LixiOrderPayment save(LixiOrderPayment payment) {
        
        return this.paymentRepository.save(payment);
        
    }
}
