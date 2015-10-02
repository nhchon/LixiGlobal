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
@Table(name = "buy_card_result")
public class BuyCardResult implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Column(name = "buy_request")
    @Lob
    private String buyRequest;
    
    @Column(name = "buy_response")
    @Lob
    private String buyResponse;
    
    @Column(name = "get_request")
    @Lob
    private String getRequest;
    
    @Column(name = "get_response")
    @Lob
    private String getResponse;
    
    @Column(name = "get_response_decrypt")
    @Lob
    private String getResponseDecrypt;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;
    
    @JoinColumn(name = "buy_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private BuyCard buyCard;

    public BuyCardResult() {
    }

    public BuyCardResult(Long id) {
        this.id = id;
    }

    public BuyCardResult(Long id, Date modifiedDate) {
        this.id = id;
        this.modifiedDate = modifiedDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBuyRequest() {
        return buyRequest;
    }

    public void setBuyRequest(String buyRequest) {
        this.buyRequest = buyRequest;
    }

    public String getBuyResponse() {
        return buyResponse;
    }

    public void setBuyResponse(String buyResponse) {
        this.buyResponse = buyResponse;
    }

    public String getGetRequest() {
        return getRequest;
    }

    public void setGetRequest(String getRequest) {
        this.getRequest = getRequest;
    }

    public String getGetResponse() {
        return getResponse;
    }

    public void setGetResponse(String getResponse) {
        this.getResponse = getResponse;
    }

    public String getGetResponseDecrypt() {
        return getResponseDecrypt;
    }

    public void setGetResponseDecrypt(String getResponseDecrypt) {
        this.getResponseDecrypt = getResponseDecrypt;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public BuyCard getBuyCard() {
        return buyCard;
    }

    public void setBuyCard(BuyCard buyCard) {
        this.buyCard = buyCard;
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
        if (!(object instanceof BuyCardResult)) {
            return false;
        }
        BuyCardResult other = (BuyCardResult) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.BuyCardResult[ id=" + id + " ]";
    }
    
}
