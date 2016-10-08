/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author Asus
 */
public class RecipientAddressForm {
    
    @NotBlank(message = "{validate.not_null}")
    private String recAddress;
    
    @NotBlank(message = "{validate.not_null}")
    private String recProvince;

    public RecipientAddressForm(){};
    
    public RecipientAddressForm(String add, String province){
        this.recAddress = add;
        this.recProvince = province;
    };
    
    public String getRecAddress() {
        return recAddress;
    }

    public void setRecAddress(String recAddress) {
        this.recAddress = recAddress;
    }

    public String getRecProvince() {
        return recProvince;
    }

    public void setRecProvince(String recProvince) {
        this.recProvince = recProvince;
    }
    
    
}
