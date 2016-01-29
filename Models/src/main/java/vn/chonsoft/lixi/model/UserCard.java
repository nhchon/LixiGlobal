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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import vn.chonsoft.lixi.EnumCard;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "user_cards")
public class UserCard implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic
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
    
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User user;

    public UserCard() {
        
        this.cardName = "John Smith";
        this.cardNumber = "XXXX1111";
        this.expMonth = 0;
        this.expYear = 0;
        this.cardCvv = "";
        
    }

    public UserCard(Long id) {
        
        this.id = id;
        //
        this.cardName = "John Smith";
        this.cardNumber = "XXXX1111";
        this.expMonth = 0;
        this.expYear = 0;
        this.cardCvv = "";
        
    }

    public UserCard(Long id, String authorizePaymentId, int cardType, String cardName, String cardNumber, int expMonth, int expYear, String cardCvv, Date modifiedDate) {
        this.id = id;
        this.authorizePaymentId = authorizePaymentId;
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

    public String getAuthorizePaymentId() {
        return authorizePaymentId;
    }

    public void setAuthorizePaymentId(String authorizePaymentId) {
        this.authorizePaymentId = authorizePaymentId;
    }

    public String getCardTypeName() {
        return EnumCard.findByValue(cardType).toString();
    }
    
    public int getCardType() {
        return cardType;
    }

    public void setCardType(int cardType) {
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

    public BillingAddress getBillingAddress() {
        return billingAddress;
    }

    public void setBillingAddress(BillingAddress billingAddress) {
        this.billingAddress = billingAddress;
    }

    
    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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
        if (!(object instanceof UserCard)) {
            return false;
        }
        UserCard other = (UserCard) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.UserCard[ id=" + id + " ]";
    }

}
