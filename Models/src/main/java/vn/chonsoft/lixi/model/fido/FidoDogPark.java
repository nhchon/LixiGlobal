/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.fido;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "fido_dog_park")
@XmlRootElement
public class FidoDogPark implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "park_name")
    private String parkName;
    
    @Column(name = "address_1")
    private String address1;
    
    @Column(name = "address_2")
    private String address2;
    
    @Column(name = "address_3")
    private String address3;
    
    @Basic(optional = false)
    @Column(name = "address_detail_url")
    private String addressDetailUrl;
    
    @Basic(optional = false)
    @Column(name = "photo_url")
    private String photoUrl;
    
    @Lob
    @Column(name = "description")
    private String description;
    
    @Basic(optional = false)
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    
    @JoinColumn(name = "city_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private FidoCity cityId;

    public FidoDogPark() {
    }

    public FidoDogPark(Long id) {
        this.id = id;
    }

    public FidoDogPark(Long id, String parkName, String addressDetailUrl, String photoUrl, Date createdDate) {
        this.id = id;
        this.parkName = parkName;
        this.addressDetailUrl = addressDetailUrl;
        this.photoUrl = photoUrl;
        this.createdDate = createdDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getParkName() {
        return parkName;
    }

    public void setParkName(String parkName) {
        this.parkName = parkName;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getAddress3() {
        return address3;
    }

    public void setAddress3(String address3) {
        this.address3 = address3;
    }

    public String getAddressDetailUrl() {
        return addressDetailUrl;
    }

    public void setAddressDetailUrl(String addressDetailUrl) {
        this.addressDetailUrl = addressDetailUrl;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public FidoCity getCityId() {
        return cityId;
    }

    public void setCityId(FidoCity cityId) {
        this.cityId = cityId;
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
        if (!(object instanceof FidoDogPark)) {
            return false;
        }
        FidoDogPark other = (FidoDogPark) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.fido.FidoDogPark[ " + id + ", " + parkName + ", " + description + " ]";
    }
    
}
