/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import java.util.Date;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

/**
 *
 * @author chonnh
 */
public class LiXiExchangeRateForm {
    
    /* */
    private Long currency;
    /* */
    @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date dateInput;
    /* */
    private String timeInput;
    /* */
    @NotNull(message = "{validate.not_null}")
    @NumberFormat
    private Double buyPercentage;

    /* */
    @NotNull(message = "{validate.not_null}")
    @NumberFormat
    private Double sellPercentage;

    /* */
    @NotNull(message = "{validate.not_null}")
    @NumberFormat
    private Double buy;
    
    /* round to floor hundress*/
    @NumberFormat
    private Double roundBuy;
    
    /* */
    @NotNull(message = "{validate.not_null}")
    @NumberFormat
    private Double sell;

    /* round to floor hundress*/
    @NumberFormat
    private Double roundSell;
    
    public Long getCurrency() {
        return currency;
    }

    public void setCurrency(Long currency) {
        this.currency = currency;
    }

    public Date getDateInput() {
        return dateInput;
    }

    public void setDateInput(Date dateInput) {
        this.dateInput = dateInput;
    }

    public String getTimeInput() {
        return timeInput;
    }

    public void setTimeInput(String timeInput) {
        this.timeInput = timeInput;
    }

    public Double getBuy() {
        return buy;
    }

    public void setBuy(Double buy) {
        this.buy = buy;
    }

    public Double getSell() {
        return sell;
    }

    public void setSell(Double sell) {
        this.sell = sell;
    }
    
    public Double getRoundBuy() {
        return roundBuy;
    }

    public void setRoundBuy(Double roundBuy) {
        this.roundBuy = roundBuy;
    }

    public Double getRoundSell() {
        return roundSell;
    }

    public void setRoundSell(Double roundSell) {
        this.roundSell = roundSell;
    }

    public Double getBuyPercentage() {
        return buyPercentage;
    }

    public void setBuyPercentage(Double buyPercentage) {
        this.buyPercentage = buyPercentage;
    }

    public Double getSellPercentage() {
        return sellPercentage;
    }

    public void setSellPercentage(Double sellPercentage) {
        this.sellPercentage = sellPercentage;
    }

}
