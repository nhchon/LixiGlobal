/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "networks")
public class Network implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    
    @OneToMany(mappedBy = "network")
    private List<DauSo> dauSos;
    
    @OneToMany(mappedBy = "network")
    private List<VtcServiceCode> vtcServiceCodes;

    public Network() {
    }

    public Network(Long id) {
        this.id = id;
    }

    public Network(Long id, String name) {
        this.id = id;
        this.name = name;
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

    public List<DauSo> getDauSos() {
        return dauSos;
    }

    public void setDauSos(List<DauSo> dauSos) {
        this.dauSos = dauSos;
    }

    public List<VtcServiceCode> getVtcServiceCodes() {
        return vtcServiceCodes;
    }

    public void setVtcServiceCodes(List<VtcServiceCode> vtcServiceCodes) {
        this.vtcServiceCodes = vtcServiceCodes;
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
        if (!(object instanceof Network)) {
            return false;
        }
        Network other = (Network) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.Network[ id=" + id + " ]";
    }
    
}
