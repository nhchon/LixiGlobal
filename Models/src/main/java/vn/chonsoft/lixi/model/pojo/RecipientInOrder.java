/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

import java.util.List;
import vn.chonsoft.lixi.model.BuyCard;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;

/**
 *
 * @author chonnh
 */
public class RecipientInOrder {
    
    private Long orderd;
    
    private Recipient recipient;
    
    private List<LixiOrderGift> gifts;
    
    private List<BuyCard> buyPhoneCards;
    
    private List<TopUpMobilePhone> topUpMobilePhones;

    public Long getOrderId() {
        return orderd;
    }

    public void setOrderId(Long orderd) {
        this.orderd = orderd;
    }

    public List<LixiOrderGift> getGifts() {
        return gifts;
    }

    public Recipient getRecipient() {
        return recipient;
    }

    public void setRecipient(Recipient recipient) {
        this.recipient = recipient;
    }

    public void setGifts(List<LixiOrderGift> gifts) {
        this.gifts = gifts;
    }

    public List<BuyCard> getBuyPhoneCards() {
        return buyPhoneCards;
    }

    public void setBuyPhoneCards(List<BuyCard> buyPhoneCards) {
        this.buyPhoneCards = buyPhoneCards;
    }

    public List<TopUpMobilePhone> getTopUpMobilePhones() {
        return topUpMobilePhones;
    }

    public void setTopUpMobilePhones(List<TopUpMobilePhone> topUpMobilePhones) {
        this.topUpMobilePhones = topUpMobilePhones;
    }
}
