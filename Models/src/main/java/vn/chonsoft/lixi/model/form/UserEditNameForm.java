/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.form;

import vn.chonsoft.lixi.validations.NotBlank;
import vn.chonsoft.lixi.validations.NotBlankButNullable;

/**
 *
 * @author chonnh
 */
public class UserEditNameForm{
    
    @NotBlank(message = "{validate.user.firstName}")
    private String firstName;
    
    @NotBlankButNullable(message = "{validate.user.middleName}")
    private String middleName;
    
    @NotBlank(message = "{validate.user.lastName}")
    private String lastName;
    
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

}
