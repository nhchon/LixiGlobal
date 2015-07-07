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

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "admin_user_password_history")
public class AdminUserPasswordHistory implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @JoinColumn(name = "admin_user_id")
    @ManyToOne
    private AdminUser adminUserId;
    
    @Basic(optional = false)
    @Column(name = "password")
    private String password;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;

    public AdminUserPasswordHistory() {
    }

    public AdminUserPasswordHistory(Long id) {
        this.id = id;
    }

    public AdminUserPasswordHistory(Long id, String password, Date modifiedDate) {
        this.id = id;
        this.password = password;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public AdminUser getAdminUserId() {
        return adminUserId;
    }

    public void setAdminUserId(AdminUser adminUserId) {
        this.adminUserId = adminUserId;
    }

    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
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
        if (!(object instanceof AdminUserPasswordHistory)) {
            return false;
        }
        AdminUserPasswordHistory other = (AdminUserPasswordHistory) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.AdminUserPasswordHistory[ id=" + id + " ]";
    }
    
}
