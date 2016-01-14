/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import vn.chonsoft.lixi.model.pojo.EnumCard;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "lixi_order_cards")
public class LixiOrderCard implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "user_id")
    private long userId;
    
    @Size(max = 255)
    @Column(name = "authorize_payment_id")
    private String authorizePaymentId;
    
    @Basic(optional = false)
    @Column(name = "card_type")
    private int cardType;
    
    @Basic(optional = false)
    @Column(name = "card_name")
    private String cardName;
    
    @Basic(optional = false)
    @Column(name = "card_number")
    private String cardNumber;
    
    @Basic(optional = false)
    @Column(name = "exp_month")
    private int expMonth;
    
    @Basic(optional = false)
    @Column(name = "exp_year")
    private int expYear;
    
    @Basic
    @Column(name = "card_cvv")
    private String cardCvv;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;

    @JoinColumn(name = "bill_address", referencedColumnName = "id")
    @ManyToOne
    private BillingAddress billingAddress;
    
    public LixiOrderCard() {
    }

    public LixiOrderCard(Long id) {
        this.id = id;
    }

    public LixiOrderCard(UserCard card){
        
        if(card != null){
            this.id = card.getId();
            this.userId = card.getUser().getId();
            this.authorizePaymentId = card.getAuthorizePaymentId();
            this.cardType = card.getCardType();
            this.cardName = card.getCardName();
            this.cardNumber = card.getCardNumber();
            this.expMonth = card.getExpMonth();
            this.expYear = card.getExpYear();
            this.cardCvv = card.getCardCvv();
            this.modifiedDate = card.getModifiedDate();
            this.billingAddress = card.getBillingAddress();
        }
    }
    
    public LixiOrderCard(Long id, long userId, int cardType, String cardName, String cardNumber, int expMonth, int expYear, String cardCvv, Date modifiedDate) {
        this.id = id;
        this.userId = userId;
        this.cardType = cardType;
        this.cardName = cardName;
        this.cardNumber = cardNumber;
        this.expMonth = expMonth;
        this.expYear = expYear;
        this.cardCvv = cardCvv;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getAuthorizePaymentId() {
        return authorizePaymentId;
    }

    public void setAuthorizePaymentId(String authorizePaymentId) {
        this.authorizePaymentId = authorizePaymentId;
    }

    public int getCardType() {
        return cardType;
    }

    public void setCardType(int cardType) {
        this.cardType = cardType;
    }
    
    public String getCardTypeName() {
        return EnumCard.findByValue(cardType).toString();
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

    public int getExpMonth() {
        return expMonth;
    }

    public void setExpMonth(int expMonth) {
        this.expMonth = expMonth;
    }

    public int getExpYear() {
        return expYear;
    }

    public void setExpYear(int expYear) {
        this.expYear = expYear;
    }

    public String getCardCvv() {
        return cardCvv;
    }

    public void setCardCvv(String cardCvv) {
        this.cardCvv = cardCvv;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public BillingAddress getBillingAddress() {
        return billingAddress;
    }

    public void setBillingAddress(BillingAddress billingAddress) {
        this.billingAddress = billingAddress;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LixiOrderCard)) {
            return false;
        }
        LixiOrderCard other = (LixiOrderCard) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiOrderCard[ id=" + id + " ]";
    }
    
}
