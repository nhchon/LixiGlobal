/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.NotNull;
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
//@FieldMatch(first = "email", second = "confEmail", message = "{validate.user.emailConf}")
public class LixiContactForm{
    
    @NotBlank(message = "{validate.not_null}")
    private String name;
    
    @NotNull(message = "{validate.user.email}")
    @Email(message = "{validate.user.email}")
    private String email;
    
    //@NotNull(message ="validate.not_null")
    private String phone;

    @NotBlank(message ="{validate.not_null}")
    private String message;
    
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
