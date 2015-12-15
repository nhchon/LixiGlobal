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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "lixi_invoices")
public class LixiInvoice implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Column(name = "invoice_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date invoiceDate;
    
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "gift_price")
    private Double giftPrice;
    
    @Column(name = "card_fee")
    private Double cardFee;
    
    @Column(name = "lixi_fee")
    private Double lixiFee;
    
    @Column(name = "total_amount")
    private Double totalAmount;
    
    @Column(name = "net_trans_id")
    private String netTransId;
    
    @Column(name = "net_response_code")
    private String netResponseCode;
    
    @Column(name = "net_trans_status")
    private String netTransStatus;
    
    @Column(name = "last_check_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastCheckDate;
    
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @JoinColumn(name = "order_id", referencedColumnName = "id")
    @OneToOne
    private LixiOrder order;
    
    public LixiInvoice() {
    }

    public LixiInvoice(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public Double getGiftPrice() {
        return giftPrice;
    }

    public void setGiftPrice(Double giftPrice) {
        this.giftPrice = giftPrice;
    }

    public Double getCardFee() {
        return cardFee;
    }

    public void setCardFee(Double cardFee) {
        this.cardFee = cardFee;
    }

    public Double getLixiFee() {
        return lixiFee;
    }

    public void setLixiFee(Double lixiFee) {
        this.lixiFee = lixiFee;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getNetTransId() {
        return netTransId;
    }

    public void setNetTransId(String netTransId) {
        this.netTransId = netTransId;
    }

    public String getNetResponseCode() {
        return netResponseCode;
    }

    public void setNetResponseCode(String netResponseCode) {
        this.netResponseCode = netResponseCode;
    }

    public String getNetTransStatus() {
        return netTransStatus;
    }

    public void setNetTransStatus(String netTransStatus) {
        this.netTransStatus = netTransStatus;
    }

    public Date getLastCheckDate() {
        return lastCheckDate;
    }

    public void setLastCheckDate(Date lastCheckDate) {
        this.lastCheckDate = lastCheckDate;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public LixiOrder getOrder() {
        return order;
    }

    public void setOrder(LixiOrder order) {
        this.order = order;
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
        if (!(object instanceof LixiInvoice)) {
            return false;
        }
        LixiInvoice other = (LixiInvoice) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.LixiInvoice[ id=" + id + " ]";
    }
    
}
