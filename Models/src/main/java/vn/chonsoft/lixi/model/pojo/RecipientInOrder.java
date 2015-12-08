/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

import java.util.List;
import vn.chonsoft.lixi.model.BuyCard;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;

/**
 *
 * @author chonnh
 */
public class RecipientInOrder {
    
    private Long orderd;
    
    private LixiExchangeRate lxExchangeRate;
    
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

    public Long getOrderd() {
        return orderd;
    }

    public void setOrderd(Long orderd) {
        this.orderd = orderd;
    }

    public LixiExchangeRate getLxExchangeRate() {
        return lxExchangeRate;
    }

    public void setLxExchangeRate(LixiExchangeRate lxExchangeRate) {
        this.lxExchangeRate = lxExchangeRate;
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
    
    public SumVndUsd getGiftTotal(){
        
        /* */
        double buy = getLxExchangeRate().getBuy();
        // gift type
        //double sumGiftVND = 0;
        double sumGiftUSD = 0;
        if (getGifts() != null) {
            for (LixiOrderGift gift : getGifts()) {
                //sumGiftVND += (gift.getProductPrice() * gift.getProductQuantity());
                sumGiftUSD += (gift.getPriceInUSD(buy) * gift.getProductQuantity());
            }
        }
        
        return new SumVndUsd("LIXI_GIFT_TYPE", sumGiftUSD * buy, sumGiftUSD);
    }
    
    /**
     * 
     * @return 
     */
    public SumVndUsd getPhoneCardTotal(){
        
        /* */
        double buy = getLxExchangeRate().getBuy();
        
        // buy phone card
        //double sumBuyCardVND = 0;
        double sumBuyCardUSD = 0;
        if (getBuyPhoneCards() != null) {
            for (BuyCard card : getBuyPhoneCards()) {
                //sumBuyCardVND += (card.getNumOfCard() * card.getValueOfCard());
                sumBuyCardUSD += (card.getValueInUSD(buy) * card.getNumOfCard());
            }
        }
        return new SumVndUsd("LIXI_PHONE_CARD_TYPE", sumBuyCardUSD * buy, sumBuyCardUSD);
    }
    
    public SumVndUsd getTopUpTotal(){
        
        /* */
        double buy = getLxExchangeRate().getBuy();
        
        // top up mobile phone
        //double sumTopUpVND = 0;
        double sumTopUpUSD = 0;
        if (getTopUpMobilePhones() != null) {
            for (TopUpMobilePhone topUp : getTopUpMobilePhones()) {
                //sumTopUpVND += (topUp.getAmount() * buy);
                sumTopUpUSD += topUp.getAmount();
            }
        }
        return new SumVndUsd("LIXI_TOP_UP_TYPE", sumTopUpUSD * buy, sumTopUpUSD);
    }
    
    public SumVndUsd getAllTotal(){
        
        SumVndUsd gift = getGiftTotal();
        SumVndUsd topUp = getTopUpTotal();
        SumVndUsd buyCard = getPhoneCardTotal();
        
        return new SumVndUsd("TOTAL_ALL_TYPE", gift.getVnd() + topUp.getVnd() + buyCard.getVnd(), gift.getUsd() + topUp.getUsd() + buyCard.getUsd());
    }
}
