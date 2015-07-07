/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
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
import javax.xml.bind.annotation.XmlRootElement;
import org.springframework.security.core.GrantedAuthority;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "admin_users_authority")
@XmlRootElement
public class AdminUserAuthority implements GrantedAuthority, Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "authority")
    private String authority;
    
    @JoinColumn(name = "admin_user_id")
    @ManyToOne
    private AdminUser adminUserId;

    public AdminUserAuthority() {
    }

    public AdminUserAuthority(Long id) {
        this.id = id;
    }

    public AdminUserAuthority(Long id, String authority) {
        this.id = id;
        this.authority = authority;
    }

    public AdminUserAuthority(String authority, AdminUser adminUserId) {
        this.adminUserId = adminUserId;
        this.authority = authority;
    }

    public AdminUserAuthority(Long id, String authority, AdminUser adminUserId) {
        this.id = id;
        this.adminUserId = adminUserId;
        this.authority = authority;
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public String getAuthority() {
        return authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }

    public AdminUser getAdminUserId() {
        return adminUserId;
    }

    public void setAdminUserId(AdminUser adminUserId) {
        this.adminUserId = adminUserId;
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
        if (!(object instanceof AdminUserAuthority)) {
            return false;
        }
        AdminUserAuthority other = (AdminUserAuthority) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.AdminUserAuthority[ " + id + ", " + adminUserId + ", " + authority + "]";
    }
    
}
