/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.NotNull;
import vn.chonsoft.lixi.validations.Email;
import vn.chonsoft.lixi.validations.Password;

/**
 *
 * @author chonnh
 */
public class UserSignInForm {

    @NotNull(message = "{validate.user.email}")
    @Email(message = "{validate.user.email}")
    private String email;

    @Password(message = "{validate.user.password}")
    private String password;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
