/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author chonnh
 */
public class AddCardForm {
    
    private Long cardId;
    
    /* card detail */
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
    
    /* Billing address */
    private Long blId;
    
    @NotBlank(message = "{validate.not_null}")
    private String firstName;
    
    @NotBlank(message = "{validate.not_null}")
    private String lastName;
    
    @NotBlank(message = "{validate.not_null}")
    private String address;
    
    @NotBlank(message = "{validate.not_null}")
    private String city;
    
    @NotBlank(message = "{validate.not_null}")
    private String state;
    
    @NotBlank(message = "{validate.not_null}")
    private String zipCode;
    
    //@NotBlank(message = "{validate.not_null}")
    //private String phone;

    @NotBlank(message = "{validate.not_null}")
    private String country;

    public AddCardForm(){}
    
    public AddCardForm(UserCard card){
        
        if(card != null){
            
            this.cardId = card.getId();
            this.cardType = card.getCardType();
            this.cardName = card.getCardName();
            this.cardNumber = card.getCardNumber();
            this.expMonth = card.getExpMonth();
            this.expYear = card.getExpYear();
            this.cvv = card.getCardCvv();
            /* billing address */
            BillingAddress bl = card.getBillingAddress();
            this.blId = bl.getId();
            this.firstName = bl.getFirstName();
            this.lastName = bl.getLastName();
            this.address = bl.getAddress();
            this.city = bl.getCity();
            this.state = bl.getState();
            this.zipCode = bl.getZipCode();
            this.country = bl.getCountry();
        }
    }
    
    public Long getCardId() {
        return cardId;
    }

    public void setCardId(Long cardId) {
        this.cardId = cardId;
    }

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

    public Long getBlId() {
        return blId;
    }

    public void setBlId(Long blId) {
        this.blId = blId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
