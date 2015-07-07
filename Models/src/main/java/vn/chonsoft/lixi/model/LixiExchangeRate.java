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
import vn.chonsoft.lixi.model.trader.CurrencyType;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "lixi_exchange_rates")
public class LixiExchangeRate implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "date_input")
    @Temporal(TemporalType.DATE)
    private Date dateInput;
    
    @Basic(optional = false)
    @Column(name = "time_input")
    @Temporal(TemporalType.TIME)
    private Date timeInput;
    
    @Basic(optional = false)
    @Column(name = "buy")
    private double buy;
    
    @Basic(optional = false)
    @Column(name = "buy_percentage")
    private double buyPercentage;
    
    @Basic(optional = false)
    @Column(name = "sell")
    private double sell;
    
    @Basic(optional = false)
    @Column(name = "sell_percentage")
    private double sellPercentage;
    
    @Basic(optional = false)
    @Column(name = "created_by")
    private String createdBy;
    
    @Basic(optional = false)
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    
    @JoinColumn(name = "currency", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private CurrencyType currency;

    public LixiExchangeRate() {
    }

    public LixiExchangeRate(Long id) {
        this.id = id;
    }

    public LixiExchangeRate(Long id, Date dateInput, Date timeInput, double buy, double buyPercentage, double sell, double sellPercentage, String createdBy, Date createdDate) {
        this.id = id;
        this.dateInput = dateInput;
        this.timeInput = timeInput;
        this.buy = buy;
        this.buyPercentage = buyPercentage;
        this.sell = sell;
        this.sellPercentage = sellPercentage;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getDateInput() {
        return dateInput;
    }

    public void setDateInput(Date dateInput) {
        this.dateInput = dateInput;
    }

    public Date getTimeInput() {
        return timeInput;
    }

    public void setTimeInput(Date timeInput) {
        this.timeInput = timeInput;
    }

    public double getBuy() {
        return buy;
    }

    public void setBuy(double buy) {
        this.buy = buy;
    }

    public double getBuyPercentage() {
        return buyPercentage;
    }

    public void setBuyPercentage(double buyPercentage) {
        this.buyPercentage = buyPercentage;
    }

    public double getSell() {
        return sell;
    }

    public void setSell(double sell) {
        this.sell = sell;
    }

    public double getSellPercentage() {
        return sellPercentage;
    }

    public void setSellPercentage(double sellPercentage) {
        this.sellPercentage = sellPercentage;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public CurrencyType getCurrency() {
        return currency;
    }

    public void setCurrency(CurrencyType currency) {
        this.currency = currency;
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
        if (!(object instanceof LixiExchangeRate)) {
            return false;
        }
        LixiExchangeRate other = (LixiExchangeRate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiExchangeRate[ id=" + id + " ]";
    }
    
}
