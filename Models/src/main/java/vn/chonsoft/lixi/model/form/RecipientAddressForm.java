/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import javax.validation.constraints.NotNull;
import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author Asus
 */
public class RecipientAddressForm {
    
    @NotBlank(message = "{validate.not_null}")
    private String recName;
    
    @NotBlank(message = "{validate.not_null}")
    private String recAddress;
    
    @NotBlank(message = "{validate.not_null}")
    private String recDist;
    
    @NotBlank(message = "{validate.not_null}")
    private String recWard;
    
    @NotNull(message = "{validate.not_null}")
    private Integer recProvince;
    
    @NotBlank(message = "{validate.not_null}")
    private String recPhone;

    @NotNull
    private Long oId;
    
    public RecipientAddressForm(){};

    public String getRecName() {
        return recName;
    }

    public void setRecName(String recName) {
        this.recName = recName;
    }

    public String getRecDist() {
        return recDist;
    }

    public void setRecDist(String recDist) {
        this.recDist = recDist;
    }

    public String getRecWard() {
        return recWard;
    }

    public void setRecWard(String recWard) {
        this.recWard = recWard;
    }

    public String getRecPhone() {
        return recPhone;
    }

    public void setRecPhone(String recPhone) {
        this.recPhone = recPhone;
    }
    
    public String getRecAddress() {
        return recAddress;
    }

    public void setRecAddress(String recAddress) {
        this.recAddress = recAddress;
    }

    public Integer getRecProvince() {
        return recProvince;
    }

    public void setRecProvince(Integer recProvince) {
        this.recProvince = recProvince;
    }

    public Long getOId() {
        return oId;
    }

    public void setOId(Long oId) {
        this.oId = oId;
    }
    
    
}
