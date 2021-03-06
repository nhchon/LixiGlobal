/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author chonnh
 */
public class CardAddForm {
    
    @Min(1)
    private Integer cardType;
    
    @NotBlank(message = "{validate.not_null}")
    private String cardName;
    
    @NotBlank(message = "{validate.not_null}")
    private String cardNumber;
    
    @Min(1)
    @Max(12)
    private Integer expMonth;
    
    @Min(2015)
    @Max(9999)
    private Integer expYear;
    
    @NotNull(message = "{validate.not_null}")
    private String cvv;

    public Integer getCardType() {
        return cardType;
    }

    public void setCardType(Integer cardType) {
        this.cardType = cardType;
    }

    public String getCardName() {
        return cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public Integer getExpMonth() {
        return expMonth;
    }

    public void setExpMonth(Integer expMonth) {
        this.expMonth = expMonth;
    }

    public Integer getExpYear() {
        return expYear;
    }

    public void setExpYear(Integer expYear) {
        this.expYear = expYear;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
    
    
}
