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

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "buy_card")
public class BuyCard implements Serializable {
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic(optional = false)
    @Column(name = "num_of_card")
    private int numOfCard;
    
    @Basic(optional = false)
    @Column(name = "value_of_card")
    private int valueOfCard;
    
    @Column(name = "is_submitted")
    private Integer isSubmitted;
    
    @Column(name = "response_code")
    private Integer responseCode;
    
    @Column(name = "response_message")
    @Lob
    private String responseMessage;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;
    
    @JoinColumn(name = "vtc_code", referencedColumnName = "code")
    @ManyToOne(optional = false)
    private VtcServiceCode vtcCode;
    
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private LixiOrder order;

    @JoinColumn(name = "recipient", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Recipient recipient;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "buyCard")
    private List<BuyCardResult> results;
    
    public BuyCard() {
    }

    public BuyCard(Long id) {
        this.id = id;
    }

    public BuyCard(Long id, int numOfCard, int valueOfCard, Date modifiedDate) {
        this.id = id;
        this.numOfCard = numOfCard;
        this.valueOfCard = valueOfCard;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getNumOfCard() {
        return numOfCard;
    }

    public void setNumOfCard(int numOfCard) {
        this.numOfCard = numOfCard;
    }

    public int getValueOfCard() {
        return valueOfCard;
    }

    public void setValueOfCard(int valueOfCard) {
        this.valueOfCard = valueOfCard;
    }

    /**
     *  for calculate total USD
     * 
     * @param exchange
     * @return 
     */
    public double getValueInUSD(double exchange){
        
        double inUsd = getValueOfCard()/exchange +0.005;
        
        return Math.round(inUsd * 100.0) / 100.0;
    }
    
    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Integer getIsSubmitted() {
        return isSubmitted;
    }

    public void setIsSubmitted(Integer isSubmitted) {
        this.isSubmitted = isSubmitted;
    }

    public Integer getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(Integer responseCode) {
        this.responseCode = responseCode;
    }

    public String getResponseMessage() {
        return responseMessage;
    }

    public void setResponseMessage(String responseMessage) {
        this.responseMessage = responseMessage;
    }

    public VtcServiceCode getVtcCode() {
        return vtcCode;
    }

    public void setVtcCode(VtcServiceCode vtcCode) {
        this.vtcCode = vtcCode;
    }

    public LixiOrder getOrder() {
        return order;
    }

    public void setOrder(LixiOrder order) {
        this.order = order;
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
        if (!(object instanceof BuyCard)) {
            return false;
        }
        BuyCard other = (BuyCard) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.BuyPhoneCard[ id=" + id + " ]";
    }

    public List<BuyCardResult> getResults() {
        return results;
    }

    public void setResults(List<BuyCardResult> results) {
        this.results = results;
    }
    
}
