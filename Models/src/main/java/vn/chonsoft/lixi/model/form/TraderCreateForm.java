/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import vn.chonsoft.lixi.validations.Email;
import vn.chonsoft.lixi.validations.NotBlank;
import vn.chonsoft.lixi.validations.Password;

/**
 *
 * @author chonnh
 */
public class TraderCreateForm {
    
    @NotBlank(message = "{validate.trader.name}")
    private String name;

    @NotNull(message = "{validate.email_required}")
    @Email(message = "{validate.email_required}")
    private String email;

    @NotBlank(message = "{validate.phone_required}")
    private String phone;

    //@NotBlank(message = "{validate.username_required}")
    @Size(min = 6, message = "{validate.username_required}")
    private String username;

    @Password(message = "{validate.password_required}")
    private String password;
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
}
