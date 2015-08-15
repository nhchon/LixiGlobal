/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import vn.chonsoft.lixi.model.trader.CurrencyType;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "lixi_order_gifts")
public class LixiOrderGift implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "amount")
    private float amount;
    
    @Basic(optional = false)
    @Column(name = "exchange_rate")
    private float exchangeRate;
    
    @Basic(optional = false)
    @Column(name = "giftin")
    private float giftin;
    
    @Basic
    @Column(name = "product_id")
    private int productId;
    
    @Basic
    @Column(name = "product_price")
    private float productPrice;
    
    @Basic
    @Lob
    @Column(name = "note")
    private String note;
    
    @Basic
    @Column(name = "bk_status")
    private int bkStatus;
    
    @Basic
    @Column(name = "bk_message")
    private String bkMessage;
    
    @Basic
    @Column(name = "bk_receive_method")
    private String bkReceiveMethod;
    
    @Basic
    @Column(name = "bk_updated")
    @Temporal(TemporalType.TIMESTAMP)
    private Date bkUpdated;

    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;
    
    @JoinColumn(name = "category", referencedColumnName = "id")
    @ManyToOne(optional = true)
    private LixiCategory category;
    
    @JoinColumn(name = "recipient", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Recipient recipient;
    
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private LixiOrder order;
    
    @JoinColumn(name = "lx_exchange_rate_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private LixiExchangeRate lxExchangeRate;
    
    @JoinColumn(name = "amount_currency", referencedColumnName = "code")
    @ManyToOne(optional = false)
    private CurrencyType amountCurrency;
    
    @JoinColumn(name = "giftin_currency", referencedColumnName = "code")
    @ManyToOne(optional = false)
    private CurrencyType giftinCurrency;

    public LixiOrderGift() {
    }

    public LixiOrderGift(Long id) {
        this.id = id;
    }

    public LixiOrderGift(Long id, float amount, float exchangeRate, float giftin, int productId, float productPrice, String note, Date modifiedDate) {
        this.id = id;
        this.amount = amount;
        this.exchangeRate = exchangeRate;
        this.giftin = giftin;
        this.productId = productId;
        this.productPrice = productPrice;
        this.note = note;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public float getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(float exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public float getGiftin() {
        return giftin;
    }

    public void setGiftin(float giftin) {
        this.giftin = giftin;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(float productPrice) {
        this.productPrice = productPrice;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public LixiExchangeRate getLxExchangeRate() {
        return lxExchangeRate;
    }

    public void setLxExchangeRate(LixiExchangeRate lxExchangeRate) {
        this.lxExchangeRate = lxExchangeRate;
    }

    public LixiCategory getCategory() {
        return category;
    }

    public void setCategory(LixiCategory category) {
        this.category = category;
    }

    public Recipient getRecipient() {
        return recipient;
    }

    public void setRecipient(Recipient recipient) {
        this.recipient = recipient;
    }

    public LixiOrder getOrder() {
        return order;
    }

    public void setOrder(LixiOrder order) {
        this.order = order;
    }

    public CurrencyType getAmountCurrency() {
        return amountCurrency;
    }

    public void setAmountCurrency(CurrencyType amountCurrency) {
        this.amountCurrency = amountCurrency;
    }

    public CurrencyType getGiftinCurrency() {
        return giftinCurrency;
    }

    public void setGiftinCurrency(CurrencyType giftinCurrency) {
        this.giftinCurrency = giftinCurrency;
    }

    public int getBkStatus() {
        return bkStatus;
    }

    public void setBkStatus(int bkStatus) {
        this.bkStatus = bkStatus;
    }

    public String getBkMessage() {
        return bkMessage;
    }

    public void setBkMessage(String bkMessage) {
        this.bkMessage = bkMessage;
    }

    public String getBkReceiveMethod() {
        return bkReceiveMethod;
    }

    public void setBkReceiveMethod(String bkReceiveMethod) {
        this.bkReceiveMethod = bkReceiveMethod;
    }

    public Date getBkUpdated() {
        return bkUpdated;
    }

    public void setBkUpdated(Date bkUpdated) {
        this.bkUpdated = bkUpdated;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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
        if (!(object instanceof LixiOrderGift)) {
            return false;
        }
        LixiOrderGift other = (LixiOrderGift) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiOrder[ id=" + id + " ]";
    }
    
}
