/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import vn.chonsoft.lixi.validations.FieldMatch;
import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author chonnh
 */
@FieldMatch(first = "checkingAccount", second = "confCheckingAccount", message = "{validate.checking_acount_conf}")
public class BankAccountAddForm {
    
    private Integer id;
    
    @NotBlank(message = "{validate.not_null}")
    private String name;
    
    @NotBlank(message = "{validate.not_null}")
    private String bankRounting;
    
    @NotBlank(message = "{validate.not_null}")
    private String checkingAccount;
    
    @NotBlank(message = "{validate.not_null}")
    private String confCheckingAccount;
    
    @NotBlank(message = "{validate.not_null}")
    private String driverLicense;
    
    @NotBlank(message = "{validate.not_null}")
    private String state;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBankRounting() {
        return bankRounting;
    }

    public void setBankRounting(String bankRounting) {
        this.bankRounting = bankRounting;
    }

    public String getCheckingAccount() {
        return checkingAccount;
    }

    public void setCheckingAccount(String checkingAccount) {
        this.checkingAccount = checkingAccount;
    }

    public String getConfCheckingAccount() {
        return confCheckingAccount;
    }

    public void setConfCheckingAccount(String confCheckingAccount) {
        this.confCheckingAccount = confCheckingAccount;
    }

    public String getDriverLicense() {
        return driverLicense;
    }

    public void setDriverLicense(String driverLicense) {
        this.driverLicense = driverLicense;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
    

    
}
