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
@FieldMatch(first = "email", second = "confEmail", message = "{validate.user.emailConf}")
public class UserSignUpForm{
    
    @NotBlank(message = "{validate.user.firstName}")
    private String firstName;
    
    @NotBlankButNullable(message = "{validate.user.middleName}")
    private String middleName;
    
    @NotBlank(message = "{validate.user.lastName}")
    private String lastName;
    
    @NotNull(message = "{validate.user.email}")
    @Email(message = "{validate.user.email}")
    private String email;
    
    //@NotNull(message = "{validate.user.email}")
    //@Email(message = "{validate.user.email}")
    //private String confEmail;

    @Password(message = "{message.password_format}")
    private String password;

    @Password(message = "{message.password_format}")
    private String confPassword;
    
    private String phone;

    @NotNull(message ="validate.not_null")
    private String agree;
    
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
    /*
    public String getConfEmail() {
        return confEmail;
    }

    public void setConfEmail(String confEmail) {
        this.confEmail = confEmail;
    }
    */
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAgree() {
        return agree;
    }

    public void setAgree(String agree) {
        this.agree = agree;
    }
    
    
}
