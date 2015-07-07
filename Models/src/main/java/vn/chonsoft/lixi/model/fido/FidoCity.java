/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.fido;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "fido_cities")
@XmlRootElement
public class FidoCity implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "state_abbr")
    private String stateAbbr;
    
    @Basic(optional = false)
    @Column(name = "city_name")
    private String cityName;
    
    @Basic(optional = false)
    @Column(name = "city_url")
    private String cityUrl;
    
    @Basic(optional = false)
    @Column(name = "completed")
    private short completed;
    
    @Basic(optional = false)
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cityId")
    private Collection<FidoDogPark> fidoDogParkCollection;

    public FidoCity() {
    }

    public FidoCity(Long id) {
        this.id = id;
    }

    public FidoCity(Long id, String stateAbbr, String cityName, String cityUrl, short completed, Date createdDate) {
        this.id = id;
        this.stateAbbr = stateAbbr;
        this.cityName = cityName;
        this.cityUrl = cityUrl;
        this.completed = completed;
        this.createdDate = createdDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStateAbbr() {
        return stateAbbr;
    }

    public void setStateAbbr(String stateAbbr) {
        this.stateAbbr = stateAbbr;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getCityUrl() {
        return cityUrl;
    }

    public void setCityUrl(String cityUrl) {
        this.cityUrl = cityUrl;
    }

    public short getCompleted() {
        return completed;
    }

    public void setCompleted(short completed) {
        this.completed = completed;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @XmlTransient
    public Collection<FidoDogPark> getFidoDogParkCollection() {
        return fidoDogParkCollection;
    }

    public void setFidoDogParkCollection(Collection<FidoDogPark> fidoDogParkCollection) {
        this.fidoDogParkCollection = fidoDogParkCollection;
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
        if (!(object instanceof FidoCity)) {
            return false;
        }
        FidoCity other = (FidoCity) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.fido.FidoCity[ id=" + id + " ]";
    }
    
}
