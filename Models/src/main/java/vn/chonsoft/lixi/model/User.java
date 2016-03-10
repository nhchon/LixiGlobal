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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlRootElement;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "users")
@XmlRootElement
public class User implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private Long id;
    private String authorizeProfileId;
    private String firstName;
    private String middleName;
    private String lastName;
    private String email;
    private String password;
    private String phone;
    private boolean accountNonExpired;
    private boolean accountNonLocked;
    private boolean credentialsNonExpired;
    private boolean enabled;
    private boolean activated;
    private Date createdDate;
    private String createdBy;
    private Date modifiedDate;
    private String modifiedBy;

    //private double sumGift;
    
    //private double sumTopUp;
    
    private Double sumInvoice;
    
    private Double sumInvoiceVnd;
    
    private Long graders;
    
    private List<Recipient> recipients;
    
    private UserMoneyLevel userMoneyLevel;
    
    private List<UserCard> userCards;
    
    private List<UserBankAccount> userBankAccounts;
    
    private List<BillingAddress> addresses;
    
    public User() {
    }

    public User(Long id) {
        this.id = id;
    }

    public User(Long id, String authorizeProfileId, String firstName, String middleName, String lastName, String email, String password, boolean accountNonExpired, boolean accountNonLocked, boolean credentialsNonExpired, boolean enabled, boolean activated, Date createdDate, String createdBy, Date modifiedDate, String modifiedBy) {
        this.id = id;
        this.authorizeProfileId = authorizeProfileId;
        this.firstName = firstName;
        this.middleName = middleName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.accountNonExpired = accountNonExpired;
        this.accountNonLocked = accountNonLocked;
        this.credentialsNonExpired = credentialsNonExpired;
        this.enabled = enabled;
        this.activated = activated;
        this.createdDate = createdDate;
        this.createdBy = createdBy;
        this.modifiedDate = modifiedDate;
        this.modifiedBy = modifiedBy;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "authorize_profile_id")
    public String getAuthorizeProfileId() {
        return authorizeProfileId;
    }

    public void setAuthorizeProfileId(String authorizeProfileId) {
        this.authorizeProfileId = authorizeProfileId;
    }
    
    @Basic(optional = false)
    @Column(name = "first_name")
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Basic
    @Column(name = "middle_name")
    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    @Basic(optional = false)
    @Column(name = "last_name")
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
    
    @Basic(optional = false)
    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic(optional = false)
    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    
    @Basic(optional = false)
    @Column(name = "account_non_expired")
    public boolean getAccountNonExpired() {
        return accountNonExpired;
    }

    public void setAccountNonExpired(boolean accountNonExpired) {
        this.accountNonExpired = accountNonExpired;
    }

    @Basic(optional = false)
    @Column(name = "account_non_locked")
    public boolean getAccountNonLocked() {
        return accountNonLocked;
    }

    public void setAccountNonLocked(boolean accountNonLocked) {
        this.accountNonLocked = accountNonLocked;
    }

    @Basic(optional = false)
    @Column(name = "credentials_non_expired")
    public boolean getCredentialsNonExpired() {
        return credentialsNonExpired;
    }

    public void setCredentialsNonExpired(boolean credentialsNonExpired) {
        this.credentialsNonExpired = credentialsNonExpired;
    }

    @Basic(optional = false)
    @Column(name = "enabled")
    public boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    @Basic(optional = false)
    @Column(name = "activated")
    public boolean getActivated() {
        return activated;
    }

    public void setActivated(boolean activated) {
        this.activated = activated;
    }

    @Basic(optional = false)
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Basic(optional = false)
    @Column(name = "created_by")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Basic
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    @Basic
    @Column(name = "modified_by")
    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    //@Transient
    //public double getSumGift() {
        //return sumGift;
    //}

    //public void setSumGift(double sumGift) {
        //this.sumGift = sumGift;
    //}

    //@Transient
    //public double getSumTopUp() {
        //return sumTopUp;
    //}

    //public void setSumTopUp(double sumTopUp) {
        //this.sumTopUp = sumTopUp;
    //}

    //@Transient
    //public Double getSumAll(){
        
        //return new Double(this.getSumGift() + this.getSumTopUp());
    //}
    
    @Transient
    public String getBeautyId(){
        
        return LiXiGlobalUtils.getBeautySId(id);
    }
    

    @Transient
    public Double getSumInvoice() {
        return sumInvoice;
    }

    public void setSumInvoice(Double sumInvoice) {
        this.sumInvoice = sumInvoice;
    }

    @Transient
    public Double getSumInvoiceVnd() {
        return sumInvoiceVnd;
    }

    public void setSumInvoiceVnd(Double sumInvoiceVnd) {
        this.sumInvoiceVnd = sumInvoiceVnd;
    }

    @Transient
    public Long getGraders() {
        return graders;
    }

    public void setGraders(Long graders) {
        this.graders = graders;
    }
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "user")
    public List<UserCard> getUserCards() {
        return userCards;
    }

    public void setUserCards(List<UserCard> userCards) {
        this.userCards = userCards;
    }

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "sender")
    public List<Recipient> getRecipients() {
        return recipients;
    }

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "user")
    public List<UserBankAccount> getUserBankAccounts() {
        return userBankAccounts;
    }

    public void setUserBankAccounts(List<UserBankAccount> userBankAccounts) {
        this.userBankAccounts = userBankAccounts;
    }

    public void setRecipients(List<Recipient> recipients) {
        this.recipients = recipients;
    }


    @OneToOne(cascade = CascadeType.ALL, mappedBy = "user")
    public UserMoneyLevel getUserMoneyLevel() {
        return userMoneyLevel;
    }

    public void setUserMoneyLevel(UserMoneyLevel userMoneyLevel) {
        this.userMoneyLevel = userMoneyLevel;
    }

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "user")
    public List<BillingAddress> getAddresses() {
        return addresses;
    }

    public void setAddresses(List<BillingAddress> addresses) {
        this.addresses = addresses;
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
        if (!(object instanceof User)) {
            return false;
        }
        User other = (User) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.User[ " + id + ", " + firstName + ", " + lastName + ", " + email + " ]";
    }
    
}
