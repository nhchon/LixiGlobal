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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Asus
 */
@Entity
@Table(name = "shipping_charged")
public class ShippingCharged implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "order_from")
    private double orderFrom;
    
    @Basic(optional = false)
    @Column(name = "order_to_end")
    private double orderToEnd;
    
    @Basic(optional = false)
    @Column(name = "charged_amount")
    private double chargedAmount;
    
    @Basic(optional = false)
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    
    @Basic(optional = false)
    @Column(name = "created_by")
    private String createdBy;

    public ShippingCharged() {
    }

    public ShippingCharged(Long id) {
        this.id = id;
    }

    public ShippingCharged(Long id, double orderFrom, double orderToEnd, double chargedAmount, Date createdDate, String createdBy) {
        this.id = id;
        this.orderFrom = orderFrom;
        this.orderToEnd = orderToEnd;
        this.chargedAmount = chargedAmount;
        this.createdDate = createdDate;
        this.createdBy = createdBy;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getOrderFrom() {
        return orderFrom;
    }

    public void setOrderFrom(double orderFrom) {
        this.orderFrom = orderFrom;
    }

    public double getOrderToEnd() {
        return orderToEnd;
    }

    public void setOrderToEnd(double orderToEnd) {
        this.orderToEnd = orderToEnd;
    }

    public double getChargedAmount() {
        return chargedAmount;
    }

    public void setChargedAmount(double chargedAmount) {
        this.chargedAmount = chargedAmount;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
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
        if (!(object instanceof ShippingCharged)) {
            return false;
        }
        ShippingCharged other = (ShippingCharged) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.ShippingCharged[ id=" + id + " ]";
    }
    
}
