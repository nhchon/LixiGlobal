/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Asus
 */
@Entity
@Table(name = "rec_bank")
public class RecBank implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "rec_email")
    private String recEmail;
    
    @Basic(optional = false)
    @Column(name = "ten_nguoi_huong")
    private String tenNguoiHuong;
    
    @Basic(optional = false)
    @Column(name = "so_tai_khoan")
    private String soTaiKhoan;
    
    @Basic(optional = false)
    @Column(name = "bank_name")
    private String bankName;
    
    @Basic(optional = false)
    @Column(name = "chi_nhanh")
    private String chiNhanh;

    @JoinColumn(name = "province", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Province province;

    @JoinColumn(name = "rec_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Recipient recipient;
    
    public RecBank() {
    }

    public RecBank(Long id) {
        this.id = id;
    }

    public RecBank(Long id, String recEmail, String tenNguoiHuong, String soTaiKhoan, String bankName, String chiNhanh) {
        this.id = id;
        this.recEmail = recEmail;
        this.tenNguoiHuong = tenNguoiHuong;
        this.soTaiKhoan = soTaiKhoan;
        this.bankName = bankName;
        this.chiNhanh = chiNhanh;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRecEmail() {
        return recEmail;
    }

    public void setRecEmail(String recEmail) {
        this.recEmail = recEmail;
    }

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

    public String getChiNhanh() {
        return chiNhanh;
    }

    public void setChiNhanh(String chiNhanh) {
        this.chiNhanh = chiNhanh;
    }

    public Province getProvince() {
        return province;
    }

    public void setProvince(Province province) {
        this.province = province;
    }

    public Recipient getRecipient() {
        return recipient;
    }

    public void setRecipient(Recipient recipient) {
        this.recipient = recipient;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RecBank)) {
            return false;
        }
        RecBank other = (RecBank) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.RecBank[ id=" + id + " ]";
    }
    
}
