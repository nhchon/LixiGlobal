/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
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

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "money_level")
public class MoneyLevel implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "amount")
    private float amount;
    
    @Basic(optional = false)
    @Column(name = "code")
    private String code;
    
    @Basic(optional = false)
    @Column(name = "is_default")
    private boolean isDefault;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;
    
    @Basic(optional = false)
    @Column(name = "modified_by")
    private String modifiedBy;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "moneyLevel")
    private List<UserMoneyLevel> userMoneyLevel;

    public MoneyLevel() {
    }

    public MoneyLevel(Long id) {
        this.id = id;
    }

    public MoneyLevel(Long id, float amount, String code, Date modifiedDate, String modifiedBy) {
        this.id = id;
        this.amount = amount;
        this.code = code;
        this.modifiedDate = modifiedDate;
        this.modifiedBy = modifiedBy;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public boolean isIsDefault() {
        return isDefault;
    }

    public void setIsDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    
    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public List<UserMoneyLevel> getUserMoneyLevel() {
        return userMoneyLevel;
    }

    public void setUserMoneyLevel(List<UserMoneyLevel> userMoneyLevel) {
        this.userMoneyLevel = userMoneyLevel;
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
        if (!(object instanceof MoneyLevel)) {
            return false;
        }
        MoneyLevel other = (MoneyLevel) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.MoneyLevel[ id=" + id + " ]";
    }
    
}
