/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;

/**
 *
 * @author chonnh
 */
@Validated
public interface LixiOrderGiftService {
    
    LixiOrderGift save (LixiOrderGift gift);
    
    List<LixiOrderGift> save(List<LixiOrderGift> gifts);
    
    LixiOrderGift findByOrderAndRecipient(LixiOrder order, Recipient recipient);
}
