/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author chonnh
 */
public class BillingAddressForm{
    
    @NotBlank(message = "{validate.not_null}")
    private String fullName;
    
    @NotBlank(message = "{validate.not_null}")
    private String add1;
    
    private String add2;
    
    @NotBlank(message = "{validate.not_null}")
    private String city;
    
    @NotBlank(message = "{validate.not_null}")
    private String state;
    
    @NotBlank(message = "{validate.not_null}")
    private String zipCode;
    
    @NotBlank(message = "{validate.not_null}")
    private String phone;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAdd1() {
        return add1;
    }

    public void setAdd1(String add1) {
        this.add1 = add1;
    }

    public String getAdd2() {
        return add2;
    }

    public void setAdd2(String add2) {
        this.add2 = add2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

}
