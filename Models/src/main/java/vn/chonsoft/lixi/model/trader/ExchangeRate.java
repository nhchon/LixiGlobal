/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.trader;

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

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "exchange_rates")
public class ExchangeRate implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "buy")
    private double buy;
    
    @Basic(optional = false)
    @Column(name = "sell")
    private double sell;
    
    @Basic(optional = false)
    @Column(name = "vcb_buy")
    private double vcbBuy;
    
    @Basic(optional = false)
    @Column(name = "vcb_sell")
    private double vcbSell;
    
    @Basic(optional = false)
    @Column(name = "date_input")
    @Temporal(TemporalType.DATE)
    private Date dateInput;
    
    @Basic(optional = false)
    @Column(name = "time_input")
    @Temporal(TemporalType.TIME)
    private Date timeInput;
    
    @JoinColumn(name = "trader_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Trader traderId;
    
    @JoinColumn(name = "currency_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private CurrencyType currencyId;

    public ExchangeRate() {
    }

    public ExchangeRate(Long id) {
        this.id = id;
    }

    public ExchangeRate(Long id, double buy, double sell, double vcbBuy, double vcbSell, Date dateInput, Date timeInput) {
        this.id = id;
        this.buy = buy;
        this.sell = sell;
        this.vcbBuy = vcbBuy;
        this.vcbSell = vcbSell;
        this.dateInput = dateInput;
        this.timeInput = timeInput;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 
     * @return 
     */
    public double getBuyPercentage(){
        
        if(vcbBuy == 0) return 0;
        //
        double p = buy/vcbBuy*100.0 - 100.0;
        
        return Math.round(p * 100.0) / 100.0;
    }
    
    public double getBuy() {
        return buy;
    }

    public void setBuy(double buy) {
        this.buy = buy;
    }

    /**
     * 
     * @return 
     */
    public double getSellPercentage(){
        
        if(vcbSell == 0) return 0;
        //
        double p = sell/vcbSell*100.0 - 100.0;
        
        return Math.round(p * 100.0) / 100.0;
    }
    
    public double getSell() {
        return sell;
    }

    public void setSell(double sell) {
        this.sell = sell;
    }

    public double getVcbBuy() {
        return vcbBuy;
    }

    public void setVcbBuy(double vcbBuy) {
        this.vcbBuy = vcbBuy;
    }

    public double getVcbSell() {
        return vcbSell;
    }

    public void setVcbSell(double vcbSell) {
        this.vcbSell = vcbSell;
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

    public Trader getTraderId() {
        return traderId;
    }

    public void setTraderId(Trader traderId) {
        this.traderId = traderId;
    }

    public CurrencyType getCurrencyId() {
        return currencyId;
    }

    public void setCurrencyId(CurrencyType currencyId) {
        this.currencyId = currencyId;
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
        if (!(object instanceof ExchangeRate)) {
            return false;
        }
        ExchangeRate other = (ExchangeRate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.trader.ExchangeRate[ id=" + id + " ]";
    }
    
}
