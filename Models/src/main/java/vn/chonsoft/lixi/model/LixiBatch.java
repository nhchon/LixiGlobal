/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author Asus
 */
@Entity
@Table(name = "lixi_batch")
public class LixiBatch implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    
    @Basic
    @Column(name = "vnd_margin")
    private double vndMargin;
    
    @Basic
    @Column(name = "usd_margin")
    private double usdMargin;
    
    @Basic
    @Column(name = "vnd_ship")
    private double vndShip;
    
    @Basic
    @Column(name = "usd_ship")
    private double usdShip;
    
    @Basic(optional = false)
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    
    @Basic(optional = false)
    @Column(name = "vcb_buy_usd")
    private double vcbBuyUsd;
    
    @Basic(optional = false)
    @Column(name = "vcb_time")
    private String vcbTime;
    
    @Basic(optional = false)
    @Column(name = "created_by")
    private String createdBy;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "batch")
    @OrderBy("id ASC")
    private List<LixiBatchOrder> orders;
    
    @Transient
    private double sumVnd;
    
    @Transient
    private double sumUsd;
    
    public LixiBatch() {
    }

    public LixiBatch(Long id) {
        this.id = id;
    }

    public LixiBatch(Long id, String name, Date createdDate, String createdBy) {
        this.id = id;
        this.name = name;
        this.createdDate = createdDate;
        this.createdBy = createdBy;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getVndMargin() {
        return vndMargin;
    }

    public void setVndMargin(double vndMargin) {
        this.vndMargin = vndMargin;
    }

    public double getUsdMargin() {
        return usdMargin;
    }

    public void setUsdMargin(double usdMargin) {
        this.usdMargin = usdMargin;
    }

    public double getVndShip() {
        return vndShip;
    }

    public void setVndShip(double vndShip) {
        this.vndShip = vndShip;
    }

    public double getUsdShip() {
        return usdShip;
    }

    public void setUsdShip(double usdShip) {
        this.usdShip = usdShip;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public double getVcbBuyUsd() {
        return vcbBuyUsd;
    }

    public void setVcbBuyUsd(double vcbBuyUsd) {
        this.vcbBuyUsd = vcbBuyUsd;
    }

    public String getVcbTime() {
        return vcbTime;
    }

    public void setVcbTime(String vcbTime) {
        this.vcbTime = vcbTime;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public List<LixiBatchOrder> getOrders() {
        return orders;
    }

    public void setOrders(List<LixiBatchOrder> orders) {
        this.orders = orders;
    }

    public double getSumVnd() {
        return sumVnd;
    }

    public void setSumVnd(double sumVnd) {
        this.sumVnd = sumVnd;
    }

    public double getSumUsd() {
        return sumUsd;
    }

    public void setSumUsd(double sumUsd) {
        this.sumUsd = sumUsd;
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
        if (!(object instanceof LixiBatch)) {
            return false;
        }
        LixiBatch other = (LixiBatch) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiBatch[ id=" + id + " ]";
    }
    
}
