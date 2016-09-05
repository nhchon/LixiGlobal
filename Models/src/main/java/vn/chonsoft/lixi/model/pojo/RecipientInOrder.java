/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.ShippingCharged;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
public class RecipientInOrder {
    
    private static final Logger log = LogManager.getLogger(RecipientInOrder.class);
    
    private Long orderId;
    
    private Integer orderSetting;
    
    private double baoKimTransferPercent;
    
    private LixiExchangeRate lxExchangeRate;
    
    private Recipient recipient;
    
    private List<LixiOrderGift> gifts;
    private List<TopUpMobilePhone> topUpMobilePhones;

    private SumVndUsd giftTotal = null;
    private SumVndUsd topUpTotal = null;
    private SumVndUsd allTotal = null;

    private List<ShippingCharged> charged;
    private double shippingChargeAmount;
    
    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getOrderd() {
        return orderId;
    }

    public void setOrderd(Long orderId) {
        this.orderId = orderId;
    }

    public Integer getOrderSetting() {
        return orderSetting;
    }

    public void setOrderSetting(Integer orderSetting) {
        this.orderSetting = orderSetting;
    }

    public double getBaoKimTransferPercent() {
        return baoKimTransferPercent;
    }

    public void setBaoKimTransferPercent(double baoKimTransferPercent) {
        this.baoKimTransferPercent = baoKimTransferPercent;
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

    public List<TopUpMobilePhone> getTopUpMobilePhones() {
        return topUpMobilePhones;
    }

    public void setTopUpMobilePhones(List<TopUpMobilePhone> topUpMobilePhones) {
        this.topUpMobilePhones = topUpMobilePhones;
    }
    
    /**
     * 
     * @return 
     */
    public double getGiftMargin(){
        
        double giftMarginTotal = 0;
        double marginPercent = 100.0 - baoKimTransferPercent;
        
        if (getGifts() != null) {
            for (LixiOrderGift gift : getGifts()) {
                if(orderSetting == EnumLixiOrderSetting.ALLOW_REFUND.getValue() && LiXiGlobalConstants.BAOKIM_GIFT_METHOD.equals(gift.getBkReceiveMethod()) &&
                    !gift.isLixiMargined()){
                    
                    giftMarginTotal += (gift.getProductPrice()*gift.getProductQuantity() * marginPercent)/100.0;
                }
            }
        }
        
        return LiXiGlobalUtils.round2Decimal(giftMarginTotal);
    }
    
    /**
     * 
     * @return 
     */
    public SumVndUsd getSentToBaoKim(){
        
        // gift type
        double sumGiftVND = 0;
        double sumGiftUSD = 0;
        if (getGifts() != null) {
            for (LixiOrderGift gift : getGifts()) {
                if(orderSetting == EnumLixiOrderSetting.GIFT_ONLY.getValue() || 
                    (orderSetting == EnumLixiOrderSetting.ALLOW_REFUND.getValue() && LiXiGlobalConstants.BAOKIM_GIFT_METHOD.equals(gift.getBkReceiveMethod()))){
                    // baoKimTransferPercent
                    sumGiftVND += (gift.getProductPrice() * gift.getProductQuantity() * baoKimTransferPercent)/100.0;
                }
                else
                {
                    
                    sumGiftVND += (gift.getProductPrice() * gift.getProductQuantity());
                }
                sumGiftUSD += gift.getUsdPrice() * gift.getProductQuantity();
                
            }
        }
        /* round up */
        sumGiftUSD = Math.round(sumGiftUSD * 100.0) / 100.0;
        sumGiftVND = Math.round(sumGiftVND * 100.0) / 100.0;
        
        return new SumVndUsd(LiXiGlobalConstants.LIXI_GIFT_TYPE, sumGiftVND, sumGiftUSD);
    }
    
    
    /**
     * 
     * @return 
     */
    private SumVndUsd calculateGiftTotal(){
        
        // gift type
        double sumGiftVND = 0;
        double sumGiftUSD = 0;
        if (getGifts() != null) {
            for (LixiOrderGift gift : getGifts()) {
                    
                sumGiftVND += (gift.getProductPrice() * gift.getProductQuantity());
                sumGiftUSD += gift.getUsdPrice() * gift.getProductQuantity();
                
            }
        }
        /* round up */
        sumGiftUSD = Math.round(sumGiftUSD * 100.0) / 100.0;
        sumGiftVND = Math.round(sumGiftVND * 100.0) / 100.0;
        
        return new SumVndUsd(LiXiGlobalConstants.LIXI_GIFT_TYPE, sumGiftVND, sumGiftUSD);
    }
    
    
    /**
     * 
     * @return 
     */
    public SumVndUsd getGiftTotal(){
        
        giftTotal = calculateGiftTotal();
        
        return giftTotal;
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
        
        return new SumVndUsd(LiXiGlobalConstants.LIXI_TOTAL_ALL_TYPE, gift.getVnd() + topUp.getVnd(), gift.getUsd() + topUp.getUsd());
    }

    public void setCharged(List<ShippingCharged> charged) {
        this.charged = charged;
    }

    public double getShippingChargeAmount() {
        
        if(this.charged == null) return 0;
        
        shippingChargeAmount = 0;
        
        if(getGifts()!=null && !getGifts().isEmpty()){
            
            SumVndUsd tempGiftTotal = calculateGiftTotal();

            for(ShippingCharged c : charged){

                if(tempGiftTotal.getUsd() <= c.getOrderToEnd()){
                    shippingChargeAmount = c.getChargedAmount();
                    break;
                }
            }
        }
        
        return shippingChargeAmount;
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
