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
public class RecBankForm {

    @NotBlank(message = "{validate.not_null}")
    private String tenNguoiHuong;
    
    @NotBlank(message = "{validate.not_null}")
    private String soTaiKhoan;
    
    @NotBlank(message = "{validate.not_null}")
    private String bankName;
    
    @NotNull(message = "{validate.not_null}")
    private Integer recProvince;
    
    @NotBlank(message = "{validate.not_null}")
    private String chiNhanh;

    @NotNull(message = "{validate.not_null}")
    private Long oId;
    
    public String getTenNguoiHuong() {
        return tenNguoiHuong;
    }

    public void setTenNguoiHuong(String tenNguoiHuong) {
        this.tenNguoiHuong = tenNguoiHuong;
    }

    public String getSoTaiKhoan() {
        return soTaiKhoan;
    }

    public void setSoTaiKhoan(String soTaiKhoan) {
        this.soTaiKhoan = soTaiKhoan;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public Integer getRecProvince() {
        return recProvince;
    }

    public void setRecProvince(Integer recProvince) {
        this.recProvince = recProvince;
    }

    public String getChiNhanh() {
        return chiNhanh;
    }

    public void setChiNhanh(String chiNhanh) {
        this.chiNhanh = chiNhanh;
    }

    public Long getOId() {
        return oId;
    }

    public void setOId(Long oId) {
        this.oId = oId;
    }
    
}
