/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.Comparator;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
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
    
    @Column(name = "activated")
    private Integer activated;

    @Column(name = "sort_order")
    private Integer sortOrder;
    
    @OneToOne(mappedBy = "vatgiaId")
    private LixiCategory lixiCategory;

    public VatgiaCategory() {
    }

    public VatgiaCategory(Integer id) {
        this.id = id;
    }

    public VatgiaCategory(Integer id, String title, Integer activated, Integer sortOrder) {
        this.id = id;
        this.title = title;
        this.activated = activated;
        this.sortOrder = sortOrder;
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

    public Integer getActivated() {
        return activated;
    }

    public void setActivated(Integer activated) {
        this.activated = activated;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public LixiCategory getLixiCategory() {
        return lixiCategory;
    }

    public void setLixiCategory(LixiCategory lixiCategory) {
        this.lixiCategory = lixiCategory;
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
    
    /**
     * 
     */
    public static Comparator<VatgiaCategory> VatgiaCategoryComparator = new Comparator<VatgiaCategory>(){
        
        @Override
        public int compare(VatgiaCategory v1, VatgiaCategory v2){
            
            // order by activated desc and sort_order asc
            if(v2.getActivated().compareTo(v1.getActivated()) == 0){
                return v1.getSortOrder().compareTo(v2.getSortOrder());
            }
            else{
                return v2.getActivated().compareTo(v1.getActivated());
            }
        }
    };
}
