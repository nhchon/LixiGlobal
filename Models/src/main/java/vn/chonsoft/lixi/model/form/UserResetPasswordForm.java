/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.NotNull;
import vn.chonsoft.lixi.validations.FieldMatch;
import vn.chonsoft.lixi.validations.Password;

/**
 *
 * @author chonnh
 */
@FieldMatch(first = "password", second = "confPassword", message = "{validate.user.passwordConf}")
public class UserResetPasswordForm{

    @NotNull(message = "{validate.not_null}")
    private String code;
    
    @Password(message = "{validate.user.password}")
    private String password;

    @Password(message = "{validate.user.password}")
    private String confPassword;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

}
