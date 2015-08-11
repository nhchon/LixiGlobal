/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.trader;

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
@Table(name = "currency_type")
public class CurrencyType implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;

    @Basic(optional = false)
    @Column(name = "code", unique = true)
    private String code;
    
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    
    @Basic(optional = false)
    @Column(name = "sort_order")
    private int sortOrder;
    
    //@OneToMany(cascade = CascadeType.ALL, mappedBy = "currencyId")
    //private List<ExchangeRate> exchangeRateList;
    //@OneToMany(cascade = CascadeType.ALL, mappedBy = "currency")
    //private List<LixiExchangeRate> lixiExchangeRateList;

    public CurrencyType() {
    }

    public CurrencyType(Long id) {
        this.id = id;
    }

    public CurrencyType(Long id, String name, int sortOrder) {
        this.id = id;
        this.name = name;
        this.sortOrder = sortOrder;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    /*
    public List<ExchangeRate> getExchangeRateList() {
        return exchangeRateList;
    }

    public void setExchangeRateList(List<ExchangeRate> exchangeRateList) {
        this.exchangeRateList = exchangeRateList;
    }
    */
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CurrencyType)) {
            return false;
        }
        CurrencyType other = (CurrencyType) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.trader.CurrencyType[ id=" + id + " ]";
    }

    //public List<LixiExchangeRate> getLixiExchangeRateList() {
        //return lixiExchangeRateList;
    //}

    //public void setLixiExchangeRateList(List<LixiExchangeRate> lixiExchangeRateList) {
        //this.lixiExchangeRateList = lixiExchangeRateList;
    //}
    
}
