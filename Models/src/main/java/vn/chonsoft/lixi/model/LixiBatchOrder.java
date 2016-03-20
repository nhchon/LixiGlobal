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
 * @author Asus
 */
@Entity
@Table(name = "lixi_batch_orders")
public class LixiBatchOrder implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "order_id")
    private long orderId;

    @Basic
    @Column(name = "vnd_only_gift")
    private double vndOnlyGift;
    
    @Basic
    @Column(name = "usd_only_gift")
    private double usdOnlyGift;
    
    @JoinColumn(name = "batch_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private LixiBatch batch;
    
    public LixiBatchOrder() {
    }

    public LixiBatchOrder(Long id) {
        this.id = id;
    }

    public LixiBatchOrder(Long id, long orderId) {
        this.id = id;
        this.orderId = orderId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public double getVndOnlyGift() {
        return vndOnlyGift;
    }

    public void setVndOnlyGift(double vndOnlyGift) {
        this.vndOnlyGift = vndOnlyGift;
    }

    public double getUsdOnlyGift() {
        return usdOnlyGift;
    }

    public void setUsdOnlyGift(double usdOnlyGift) {
        this.usdOnlyGift = usdOnlyGift;
    }

    public LixiBatch getBatch() {
        return batch;
    }

    public void setBatch(LixiBatch batch) {
        this.batch = batch;
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
        if (!(object instanceof LixiBatchOrder)) {
            return false;
        }
        LixiBatchOrder other = (LixiBatchOrder) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiBatchOrder[ id=" + id + " ]";
    }
    
}
