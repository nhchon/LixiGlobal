/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
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
    
    private static final Logger log = LogManager.getLogger(RecipientInOrder.class);
    
    private Long orderd;
    
    private LixiExchangeRate lxExchangeRate;
    
    private Recipient recipient;
    
    private List<LixiOrderGift> gifts;
    
    private List<BuyCard> buyPhoneCards;
    
    private List<TopUpMobilePhone> topUpMobilePhones;

    private SumVndUsd giftTotal = null;
    private SumVndUsd phoneCardTotal = null;
    
    private SumVndUsd topUpTotal = null;
    private SumVndUsd allTotal = null;
    
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
    
    private SumVndUsd calculateGiftTotal(){
        
        /* */
        double buy = getLxExchangeRate().getBuy();
        
        // gift type
        double sumGiftVND = 0;
        double sumGiftUSD = 0;
        if (getGifts() != null) {
            for (LixiOrderGift gift : getGifts()) {
                //sumGiftVND += (gift.getExchPrice() * gift.getProductQuantity());
                double temp = gift.getUsdPrice() * gift.getProductQuantity();
                sumGiftUSD += (Math.round(temp * 100.0) / 100.0);//(gift.getUsdPrice() * gift.getProductQuantity());
                sumGiftVND += (gift.getProductPrice() * gift.getProductQuantity());
                /* round up */
                sumGiftUSD = Math.round(sumGiftUSD * 100.0) / 100.0;
                sumGiftVND = Math.round(sumGiftVND * 100.0) / 100.0;
            }
        }
        
        return new SumVndUsd(LiXiGlobalConstants.LIXI_GIFT_TYPE, sumGiftVND, sumGiftUSD);
    }
    
    
    /**
     * 
     * @return 
     */
    public SumVndUsd getGiftTotal(){
        
        if(giftTotal == null){
            giftTotal = calculateGiftTotal();
        }
        
        return giftTotal;
    }
    
    /**
     * 
     * @return 
     */
    private SumVndUsd calculatePhoneCardTotal(){
        
        /* */
        double buy = getLxExchangeRate().getBuy();
        
        // buy phone card
        double sumBuyCardUSD = 0;
        if (getBuyPhoneCards() != null) {
            for (BuyCard card : getBuyPhoneCards()) {
                double temp = (card.getValueInUSD(buy) * card.getNumOfCard());
                sumBuyCardUSD += (double) Math.round(temp * 100) / 100;
                /* round up */
                sumBuyCardUSD = Math.round(sumBuyCardUSD * 100.0) / 100.0;
            }
        }
        return new SumVndUsd(LiXiGlobalConstants.LIXI_PHONE_CARD_TYPE, sumBuyCardUSD * buy, sumBuyCardUSD);
    }
    
    public SumVndUsd getPhoneCardTotal(){
        
        if(phoneCardTotal == null)
            phoneCardTotal = calculatePhoneCardTotal();
        
        return phoneCardTotal;
    }
    
    private SumVndUsd calculateTopUpTotal(){
        
        // top up mobile phone
        double sumTopUpUSD = 0;
        double sumTopUpVND = 0;
        if (getTopUpMobilePhones() != null) {
            for (TopUpMobilePhone topUp : getTopUpMobilePhones()) {
                sumTopUpUSD += topUp.getAmountUsd();
                sumTopUpVND += topUp.getAmount();
            }
        }
        return new SumVndUsd(LiXiGlobalConstants.LIXI_TOP_UP_TYPE, sumTopUpVND, sumTopUpUSD);
    }
    
    public SumVndUsd getTopUpTotal(){
        
        if(topUpTotal == null)
            topUpTotal = calculateTopUpTotal();
        
        return topUpTotal;
    }
    
    public SumVndUsd getAllTotal(){
        
        SumVndUsd gift = getGiftTotal();
        SumVndUsd topUp = getTopUpTotal();
        SumVndUsd buyCard = getPhoneCardTotal();
        
        return new SumVndUsd(LiXiGlobalConstants.LIXI_TOTAL_ALL_TYPE, gift.getVnd() + topUp.getVnd() + buyCard.getVnd(), gift.getUsd() + topUp.getUsd() + buyCard.getUsd());
    }
    
    /**
     * 
     * @return 
     */
    public String getBkStatus(){
        
        final String p = "Passed";
        final String f = "Not Sent";
        
        if(gifts != null){
            
            for(LixiOrderGift g : gifts){
                if(EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue().equals(g.getBkStatus())){
                    return f;
                }
            }
        }
        
        return p;
    }
}
