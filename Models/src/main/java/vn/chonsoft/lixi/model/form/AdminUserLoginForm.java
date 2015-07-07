/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.NotNull;
import vn.chonsoft.lixi.validations.Email;
import vn.chonsoft.lixi.validations.Password;

/**
 *
 * @author chonnh
 */
public class AdminUserLoginForm {

    @NotNull(message = "{validate.user.email}")
    @Email(message = "{validate.user.email}")
    private String username;
    
    @Password(message = "{validate.user.password}")
    private String password;

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
