/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import vn.chonsoft.lixi.validations.FieldMatch;
import vn.chonsoft.lixi.validations.FieldNotMatch;
import vn.chonsoft.lixi.validations.Password;

/**
 *
 * @author chonnh
 */
@FieldNotMatch(first = "currentPassword", second = "password", message = "{validate.user.newpassword_isnot_currentpassword}")
@FieldMatch(first = "password", second = "confPassword", message = "{validate.user.passwordConf}")
public class UserEditPasswordForm{

    @Password(message = "{validate.user.password}")
    private String currentPassword;
    
    @Password(message = "{validate.user.password}")
    private String password;

    @Password(message = "{validate.user.password}")
    private String confPassword;

    public String getCurrentPassword() {
        return currentPassword;
    }

    public void setCurrentPassword(String currentPassword) {
        this.currentPassword = currentPassword;
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