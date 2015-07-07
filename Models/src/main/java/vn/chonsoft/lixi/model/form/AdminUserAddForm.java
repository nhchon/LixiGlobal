/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import java.util.List;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.NumberFormat;
import vn.chonsoft.lixi.model.AdminUser;
import vn.chonsoft.lixi.validations.Email;
import vn.chonsoft.lixi.validations.FieldMatch;
import vn.chonsoft.lixi.validations.NotBlank;
import vn.chonsoft.lixi.validations.NotBlankButNullable;
import vn.chonsoft.lixi.validations.Password;

/**
 *
 * @author chonnh
 */
@FieldMatch(first = "password", second = "confPassword", message = "{validate.user.passwordConf}")
public class AdminUserAddForm {
    
    @NumberFormat()
    private Long id;
    
    @NotBlank(message = "{validate.user.firstName}")
    private String firstName;
    
    @NotBlankButNullable(message = "{validate.user.middleName}")
    private String middleName;
    
    @NotBlank(message = "{validate.user.lastName}")
    private String lastName;
    
    @NotNull(message = "{validate.user.email}")
    @Email(message = "{validate.user.email}")
    private String email;
    
    private String phone;

    @Password(message = "{validate.user.password}")
    private String password;

    @Password(message = "{validate.user.password}")
    private String confPassword;
    
    private boolean enabled;
    
    /* force user to change password next time login*/
    private boolean changePasswordNextTime;

    List<String> authorities;
            
    public AdminUserAddForm(){}
    
    public AdminUserAddForm(AdminUser au){
        
        this.id = au.getId();
        this.firstName = au.getFirstName();
        this.middleName = au.getMiddleName();
        this.lastName = au.getLastName();
        this.email = au.getEmail();
        this.phone = au.getPhone();
        this.enabled = au.getEnabled();
        this.changePasswordNextTime = au.isPasswordNextTime();
        
    }
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfPassword() {
        return confPassword;
    }

    public void setConfPassword(String confPassword) {
        this.confPassword = confPassword;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public boolean isChangePasswordNextTime() {
        return changePasswordNextTime;
    }

    public void setChangePasswordNextTime(boolean changePasswordNextTime) {
        this.changePasswordNextTime = changePasswordNextTime;
    }

    public List<String> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<String> authorities) {
        this.authorities = authorities;
    }
    
}
