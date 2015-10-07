/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
import vn.chonsoft.lixi.model.pojo.EnumLixiOrderSetting;
import vn.chonsoft.lixi.model.pojo.EnumLixiOrderStatus;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "lixi_orders")
public class LixiOrder implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Column(name = "lixi_status")
    private Integer lixiStatus;
    
    @Lob
    @Column(name = "lixi_message")
    private String lixiMessage;
    
    @Column(name = "setting")
    private Integer setting;
    
    @Basic
    @Column(name = "total_amount")
    private BigDecimal totalAmount;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;
    
    @JoinColumn(name = "sender", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private User sender;

    @JoinColumn(name = "lx_exchange_rate_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private LixiExchangeRate lxExchangeRate;

    @JoinColumn(name = "card_id", referencedColumnName = "id")
    @ManyToOne
    private UserCard card;

    @JoinColumn(name = "bank_account_id", referencedColumnName = "id")
    @ManyToOne
    private UserBankAccount bankAccount;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "order")
    private List<LixiOrderGift> gifts;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "order")
    private List<BuyCard> buyCards;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "order")
    private List<TopUpMobilePhone> topUpMobilePhones;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "order")
    private List<LixiOrderPayment> lixiOrderPayments;
    
    public LixiOrder() {
    }

    public LixiOrder(Long id) {
        this.id = id;
    }

    public LixiOrder(Long id, Date modifiedDate) {
        this.id = id;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getLixiStatus() {
        return lixiStatus;
    }

    public void setLixiStatus(Integer lixiStatus) {
        this.lixiStatus = lixiStatus;
    }

    public String getLixiStatusName(){
        
        return EnumLixiOrderStatus.findByValue(lixiStatus).toString();
    }
    
    public String getLixiMessage() {
        return lixiMessage;
    }

    public void setLixiMessage(String lixiMessage) {
        this.lixiMessage = lixiMessage;
    }

    public Integer getSetting() {
        return setting;
    }

    public void setSetting(Integer setting) {
        this.setting = setting;
    }

    public String getSettingName(){
        
        return EnumLixiOrderSetting.findByValue(setting).toString();
        
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
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

    public LixiExchangeRate getLxExchangeRate() {
        return lxExchangeRate;
    }

    public void setLxExchangeRate(LixiExchangeRate lxExchangeRate) {
        this.lxExchangeRate = lxExchangeRate;
    }

    public UserCard getCard() {
        return card;
    }

    public void setCard(UserCard card) {
        this.card = card;
    }

    public UserBankAccount getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(UserBankAccount bankAccount) {
        this.bankAccount = bankAccount;
    }

    public List<LixiOrderGift> getGifts() {
        return gifts;
    }

    public void setGifts(List<LixiOrderGift> gifts) {
        this.gifts = gifts;
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
        if (!(object instanceof LixiOrder)) {
            return false;
        }
        LixiOrder other = (LixiOrder) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiOrder[ id=" + id + " ]";
    }

    public List<BuyCard> getBuyCards() {
        return buyCards;
    }

    public void setBuyCards(List<BuyCard> buyCards) {
        this.buyCards = buyCards;
    }

    public List<TopUpMobilePhone> getTopUpMobilePhones() {
        return topUpMobilePhones;
    }

    public void setTopUpMobilePhones(List<TopUpMobilePhone> topUpMobilePhones) {
        this.topUpMobilePhones = topUpMobilePhones;
    }

    public List<LixiOrderPayment> getLixiOrderPayments() {
        return lixiOrderPayments;
    }

    public void setLixiOrderPayments(List<LixiOrderPayment> lixiOrderPayments) {
        this.lixiOrderPayments = lixiOrderPayments;
    }
    
}
