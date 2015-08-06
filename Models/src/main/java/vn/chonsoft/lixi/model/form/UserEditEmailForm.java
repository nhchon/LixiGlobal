/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.NotNull;
import vn.chonsoft.lixi.validations.Email;
import vn.chonsoft.lixi.validations.FieldMatch;
import vn.chonsoft.lixi.validations.Password;

/**
 *
 * @author chonnh
 */
@FieldMatch(first = "email", second = "confEmail", message = "{validate.user.emailConf}")
public class UserEditEmailForm{
    
    @NotNull(message = "{validate.user.email}")
    @Email(message = "{validate.user.email}")
    private String email;
    
    @NotNull(message = "{validate.user.email}")
    @Email(message = "{validate.user.email}")
    private String confEmail;

    @Password(message = "{validate.user.password}")
    private String password;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getConfEmail() {
        return confEmail;
    }

    public void setConfEmail(String confEmail) {
        this.confEmail = confEmail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
