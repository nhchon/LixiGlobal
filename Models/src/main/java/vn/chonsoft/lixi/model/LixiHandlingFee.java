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
@Table(name = "lixi_handling_fees")
public class LixiHandlingFee implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "currency_cde")
    private String currencyCde;
    
    @Basic(optional = false)
    @Column(name = "start_range")
    private double startRange;
    
    @Basic(optional = false)
    @Column(name = "end_range")
    private double endRange;
    
    @Basic(optional = false)
    @Column(name = "fee")
    private double fee;

    public LixiHandlingFee() {
    }

    public LixiHandlingFee(Long id) {
        this.id = id;
    }

    public LixiHandlingFee(Long id, String currencyCde, double startRange, double endRange, double fee) {
        this.id = id;
        this.currencyCde = currencyCde;
        this.startRange = startRange;
        this.endRange = endRange;
        this.fee = fee;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCurrencyCde() {
        return currencyCde;
    }

    public void setCurrencyCde(String currencyCde) {
        this.currencyCde = currencyCde;
    }

    public double getStartRange() {
        return startRange;
    }

    public void setStartRange(double startRange) {
        this.startRange = startRange;
    }

    public double getEndRange() {
        return endRange;
    }

    public void setEndRange(double endRange) {
        this.endRange = endRange;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
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
        if (!(object instanceof LixiHandlingFee)) {
            return false;
        }
        LixiHandlingFee other = (LixiHandlingFee) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiHandlingFee[ id=" + id + " ]";
    }
    
}
