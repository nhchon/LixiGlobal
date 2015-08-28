/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "vatgia_category")
public class VatgiaCategory implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    
    @Basic(optional = false)
    @Column(name = "title")
    private String title;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "vatgiaId", fetch = FetchType.EAGER)
    private List<LixiCategory> lixiCategories;

    public VatgiaCategory() {
    }

    public VatgiaCategory(Integer id) {
        this.id = id;
    }

    public VatgiaCategory(Integer id, String title) {
        this.id = id;
        this.title = title;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<LixiCategory> getLixiCategories() {
        return lixiCategories;
    }

    public void setLixiCategories(List<LixiCategory> lixiCategories) {
        this.lixiCategories = lixiCategories;
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
        if (!(object instanceof VatgiaCategory)) {
            return false;
        }
        VatgiaCategory other = (VatgiaCategory) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.VatgiaCategory[ id=" + id + " ]";
    }
    
}
