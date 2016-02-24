/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.util.List;
import org.springframework.security.core.CredentialsContainer;
import org.springframework.security.core.userdetails.UserDetails;

/**
 *
 * @author chonnh
 */
public class SecurityAdminUser extends AdminUser implements UserDetails, CredentialsContainer, Cloneable {

    public SecurityAdminUser(AdminUser au) {
        if (au != null) {
            this.setId(au.getId());
            this.setFirstName(au.getFirstName());
            this.setMiddleName(au.getMiddleName());
            this.setLastName(au.getLastName());
            this.setEmail(au.getEmail());
            this.setPassword(au.getPassword());
            this.setPhone(au.getPhone());
            this.setAccountNonExpired(au.getAccountNonExpired());
            this.setAccountNonLocked(au.getAccountNonLocked());
            this.setCredentialsNonExpired(au.getCredentialsNonExpired());
            this.setEnabled(au.getEnabled());
            this.setAuthorities(au.getAuthorities());
            this.setCreatedDate(au.getCreatedDate());
            this.setCreatedBy(au.getCreatedBy());
            this.setModifiedDate(au.getModifiedDate());
            this.setModifiedBy(au.getModifiedBy());
            
            this.setConfigs(au.getConfigs());
        }
    }

    @Override
    public String getPassword() {
        return super.getPassword();
    }

    @Override
    public String getUsername() {
        return super.getEmail();
    }

    @Override
    public boolean isAccountNonExpired() {
        return super.getAccountNonExpired();
    }

    @Override
    public boolean isAccountNonLocked() {
        return super.getAccountNonLocked();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return super.getCredentialsNonExpired();
    }

    @Override
    public boolean isEnabled() {
        return super.getEnabled();
    }

    //public boolean isPasswordNextTime() {
        //return super.isPasswordNextTime();
    //}
    
    @Override
    public void eraseCredentials()
    {
        super.setPassword(null);
    }
    
    @Override
    public List<AdminUserAuthority> getAuthorities()
    {
        return super.getAuthorities();
    }
    
}
