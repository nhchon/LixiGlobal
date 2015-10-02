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
@Table(name = "vtc_service_code")
public class VtcServiceCode implements Serializable {
    
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

    @Column(name = "menh_gia")
    private String menhGia;

    @Column(name = "lx_chuc_nang")
    private String lxChucNang;
    
    @Column(name = "chuc_nang")
    private String chucNang;
    
    @Column(name = "description")
    private String description;
    
    @JoinColumn(name = "network", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Network network;
    
    public VtcServiceCode() {
    }

    public VtcServiceCode(Long id) {
        this.id = id;
    }

    public VtcServiceCode(Long id, String code, String name) {
        this.id = id;
        this.code = code;
        this.name = name;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
        if (!(object instanceof VtcServiceCode)) {
            return false;
        }
        VtcServiceCode other = (VtcServiceCode) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.VtcServiceCode[ id=" + id + " ]";
    }

    public Network getNetwork() {
        return network;
    }

    public void setNetwork(Network network) {
        this.network = network;
    }

    public String getMenhGia() {
        return menhGia;
    }

    public void setMenhGia(String menhGia) {
        this.menhGia = menhGia;
    }

    public String getChucNang() {
        return chucNang;
    }

    public void setChucNang(String chucNang) {
        this.chucNang = chucNang;
    }

    public String getLxChucNang() {
        return lxChucNang;
    }

    public void setLxChucNang(String lxChucNang) {
        this.lxChucNang = lxChucNang;
    }
    
}
