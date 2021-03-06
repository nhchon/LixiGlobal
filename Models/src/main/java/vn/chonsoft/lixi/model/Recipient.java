/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "recipients")
public class Recipient implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "first_name")
    private String firstName;
    
    @Column(name = "middle_name")
    private String middleName;
    
    @Basic(optional = false)
    @Column(name = "last_name")
    private String lastName;
    
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Column(name = "email", unique = true)
    private String email;
    
    @Column(name = "dial_code")
    private String dialCode;
    
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Basic(optional = false)
    @Column(name = "phone")
    private String phone;
    
    @Basic
    @Column(name = "address")
    private String address;
    
    @Basic
    @Column(name = "province")
    private String province;
    
    @Basic(optional = false)
    @Column(name = "activated")
    private boolean activated;

    @Basic
    @Lob
    @Column(name = "note")
    private String note;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;
    
    @JoinColumn(name = "sender", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User sender;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "recipient")
    private List<RecAdd> recAdds;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "recipient")
    private List<RecBank> recBanks;

    @Transient
    private double sumGift;
    
    @Transient
    private double sumTopUp;
    
    @Transient
    private List<LixiOrder> processedOrders;
    
    @Transient
    private List<LixiOrder> completedOrders;
    
    
    public Recipient() {
    }

    public Recipient(Long id) {
        this.id = id;
    }

    public Recipient(Long id, String firstName, String lastName, String dialCode, String phone, String note, Date modifiedDate) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dialCode = dialCode;
        this.phone = phone;
        this.note = note;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        
        if(middleName == null) return "";
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

    @Transient
    public String getFullName(){
        
        return this.getFirstName()+ (this.getMiddleName()==null?" ":" " + this.getMiddleName() + " ") + this.getLastName();
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDialCode() {
        return dialCode;
    }

    public void setDialCode(String dialCode) {
        this.dialCode = dialCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public boolean isActivated() {
        return activated;
    }

    public void setActivated(boolean activated) {
        this.activated = activated;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public User getSender() {
        return sender;
    }

    public void setSender(User sender) {
        this.sender = sender;
    }

    public double getSumGift() {
        return sumGift;
    }

    public void setSumGift(double sumGift) {
        this.sumGift = sumGift;
    }

    public double getSumTopUp() {
        return sumTopUp;
    }

    public void setSumTopUp(double sumTopUp) {
        this.sumTopUp = sumTopUp;
    }

    @Transient
    public String getBeautyId(){
        
        return LiXiGlobalUtils.getBeautyRId(id);
    }
    
    @Transient
    public Double getSumAll(){
        
        return new Double(this.getSumGift() + this.getSumTopUp());
    }

    public List<LixiOrder> getProcessedOrders() {
        return processedOrders;
    }

    public void setProcessedOrders(List<LixiOrder> processedOrders) {
        this.processedOrders = processedOrders;
    }

    public List<LixiOrder> getCompletedOrders() {
        return completedOrders;
    }

    public void setCompletedOrders(List<LixiOrder> completedOrders) {
        this.completedOrders = completedOrders;
    }

    public List<RecAdd> getRecAdds() {
        return recAdds;
    }

    public void setRecAdds(List<RecAdd> recAdds) {
        this.recAdds = recAdds;
    }

    public List<RecBank> getRecBanks() {
        return recBanks;
    }

    public void setRecBanks(List<RecBank> recBanks) {
        this.recBanks = recBanks;
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
        if (!(object instanceof Recipient)) {
            return false;
        }
        Recipient other = (Recipient) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.Recipient[ id=" + id + " ]";
    }
    
}
