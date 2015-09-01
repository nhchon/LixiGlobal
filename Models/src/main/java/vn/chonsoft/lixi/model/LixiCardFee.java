/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "lixi_card_fees")
public class LixiCardFee implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "card_type")
    private int cardType;
    
    @Basic(optional = false)
    @Column(name = "credit_debit")
    private String creditDebit;
    
    @Basic(optional = false)
    @Column(name = "country")
    private String country;
    
    @Basic(optional = false)
    @Column(name = "gift_only")
    private double giftOnly;
    
    @Basic(optional = false)
    @Column(name = "allow_refund")
    private double allowRefund;

    public LixiCardFee() {
    }

    public LixiCardFee(Long id) {
        this.id = id;
    }

    public LixiCardFee(Long id, int cardType, String creditDebit, String country, double giftOnly, double allowRefund) {
        this.id = id;
        this.cardType = cardType;
        this.creditDebit = creditDebit;
        this.country = country;
        this.giftOnly = giftOnly;
        this.allowRefund = allowRefund;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getCardType() {
        return cardType;
    }

    public void setCardType(int cardType) {
        this.cardType = cardType;
    }

    public String getCreditDebit() {
        return creditDebit;
    }

    public void setCreditDebit(String creditDebit) {
        this.creditDebit = creditDebit;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public double getGiftOnly() {
        return giftOnly;
    }

    public void setGiftOnly(double giftOnly) {
        this.giftOnly = giftOnly;
    }

    public double getAllowRefund() {
        return allowRefund;
    }

    public void setAllowRefund(double allowRefund) {
        this.allowRefund = allowRefund;
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
        if (!(object instanceof LixiCardFee)) {
            return false;
        }
        LixiCardFee other = (LixiCardFee) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiCardFee[ id=" + id + " ]";
    }
    
}
