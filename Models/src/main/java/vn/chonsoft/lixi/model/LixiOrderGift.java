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
    
    @Basic
    @Column(name = "recipient_email")
    private String recipientEmail;
    
    @Basic
    @Column(name = "product_id")
    private int productId;
    
    @Basic
    @Column(name = "product_price")
    private double productPrice;
    
    @Basic
    @Column(name = "usd_price")
    private double usdPrice;
    
    @Basic
    @Column(name = "product_name")
    private String productName;
    
    @Basic
    @Column(name = "product_image")
    private String productImage;
    
    @Basic
    @Column(name = "product_quantity")
    private int productQuantity;
    
    @Basic
    @Column(name = "product_source")
    private String productSource;
    
    @Basic
    @Column(name = "bk_status")
    private String bkStatus;
    
    @Column(name = "bk_sub_status")
    private String bkSubStatus;
    
    @Basic
    @Lob
    @Column(name = "bk_message")
    private String bkMessage;
    
    @Basic
    @Column(name = "bk_receive_method")
    private String bkReceiveMethod;
    
    @Basic
    @Column(name = "bk_updated")
    private String bkUpdated;

    @Basic
    @Column(name = "lixi_margined")
    private boolean lixiMargined;
    
    @Basic
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    
    @Basic
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
    
    public LixiOrderGift() {
    }

    public LixiOrderGift(Long id) {
        this.id = id;
    }

    public LixiOrderGift(Long id, int productId, double productPrice, Date modifiedDate) {
        this.id = id;
        //this.amount = amount;
        this.productId = productId;
        this.productPrice = productPrice;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRecipientEmail() {
        return recipientEmail;
    }

    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public double getPriceInUSD(double exchange){
        
        double inUsd = getProductPrice()/exchange +0.005;
        
        return Math.round(inUsd * 100.0) / 100.0;
    }

    public double getUsdPrice() {
        return usdPrice;
    }

    public void setUsdPrice(double usdPrice) {
        this.usdPrice = usdPrice;
    }
    
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public int getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(int productQuantity) {
        this.productQuantity = productQuantity;
    }

    public String getProductSource() {
        return productSource;
    }

    public void setProductSource(String productSource) {
        this.productSource = productSource;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
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
    /*
    public CurrencyType getAmountCurrency() {
        return amountCurrency;
    }

    public void setAmountCurrency(CurrencyType amountCurrency) {
        this.amountCurrency = amountCurrency;
    }
    */
    public String getBkStatus() {
        return bkStatus;
    }

    public void setBkStatus(String bkStatus) {
        this.bkStatus = bkStatus;
    }

    public String getBkSubStatus() {
        return bkSubStatus;
    }

    public void setBkSubStatus(String bkSubStatus) {
        this.bkSubStatus = bkSubStatus;
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

    public String getBkUpdated() {
        return bkUpdated;
    }

    public void setBkUpdated(String bkUpdated) {
        this.bkUpdated = bkUpdated;
    }

    public boolean isLixiMargined() {
        return lixiMargined;
    }

    public void setLixiMargined(boolean lixiMargined) {
        this.lixiMargined = lixiMargined;
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
