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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "lixi_global_fee")
public class LixiGlobalFee implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "payment_method")
    private int paymentMethod;
    
    @Basic(optional = false)
    @Column(name = "amount")
    private double amount;
    
    @Basic(optional = false)
    @Column(name = "gift_only_fee")
    private double giftOnlyFee;
    
    @Basic(optional = false)
    @Column(name = "allow_refund_fee")
    private double allowRefundFee;
    
    @Basic(optional = false)
    @Column(name = "max_fee")
    private double maxFee;
    
    @Basic(optional = false)
    @Column(name = "lixi_fee")
    private double lixiFee;
    
    @JoinColumn(name = "country", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Country country;

    public LixiGlobalFee() {
    }

    public LixiGlobalFee(Long id) {
        this.id = id;
    }

    public LixiGlobalFee(Long id, int paymentMethod, double amount, double giftOnlyFee, double allowRefundFee, double maxFee, double lixiFee) {
        this.id = id;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
        this.giftOnlyFee = giftOnlyFee;
        this.allowRefundFee = allowRefundFee;
        this.maxFee = maxFee;
        this.lixiFee = lixiFee;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(int paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getGiftOnlyFee() {
        return giftOnlyFee;
    }

    public void setGiftOnlyFee(double giftOnlyFee) {
        this.giftOnlyFee = giftOnlyFee;
    }

    public double getAllowRefundFee() {
        return allowRefundFee;
    }

    public void setAllowRefundFee(double allowRefundFee) {
        this.allowRefundFee = allowRefundFee;
    }

    public double getMaxFee() {
        return maxFee;
    }

    public void setMaxFee(double maxFee) {
        this.maxFee = maxFee;
    }

    public double getLixiFee() {
        return lixiFee;
    }

    public void setLixiFee(double lixiFee) {
        this.lixiFee = lixiFee;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
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
        if (!(object instanceof LixiGlobalFee)) {
            return false;
        }
        LixiGlobalFee other = (LixiGlobalFee) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiGlobalFee[ id=" + id + " ]";
    }
    
}
