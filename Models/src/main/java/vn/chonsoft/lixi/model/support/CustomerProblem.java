/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.support;

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
@Table(name = "customer_problem")
public class CustomerProblem implements Serializable {
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Lob
    @Column(name = "content")
    private String content;
    
    @Column(name = "order_id")
    private Long orderId;
    
    @Column(name = "contact_method")
    private String contactMethod;
    
    @Column(name = "contact_data")
    private String contactData;
    
    @Column(name = "created_by")
    private String createdBy;
    
    @Basic(optional = false)
    @Column(name = "created_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    
    @Column(name = "handled_by")
    private String handledBy;
    
    @Column(name = "handled_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date handledDate;
    
    @Column(name = "closed_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date closedDate;
    
    @JoinColumn(name = "subject_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private CustomerSubject subject;

    @JoinColumn(name = "status", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private CustomerProblemStatus status;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "problem")
    private List<CustomerComment> comments;

    public CustomerProblem() {
    }

    public CustomerProblem(Long id) {
        this.id = id;
    }

    public CustomerProblem(Long id, Date createdDate, CustomerProblemStatus status) {
        this.id = id;
        this.createdDate = createdDate;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getContactMethod() {
        return contactMethod;
    }

    public void setContactMethod(String contactMethod) {
        this.contactMethod = contactMethod;
    }

    public String getContactData() {
        return contactData;
    }

    public void setContactData(String contactData) {
        this.contactData = contactData;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public CustomerProblemStatus getStatus() {
        return status;
    }

    public void setStatus(CustomerProblemStatus status) {
        this.status = status;
    }

    public String getHandledBy() {
        return handledBy;
    }

    public void setHandledBy(String handledBy) {
        this.handledBy = handledBy;
    }

    public Date getHandledDate() {
        return handledDate;
    }

    public void setHandledDate(Date handledDate) {
        this.handledDate = handledDate;
    }

    public Date getClosedDate() {
        return closedDate;
    }

    public void setClosedDate(Date closedDate) {
        this.closedDate = closedDate;
    }

    public CustomerSubject getSubject() {
        return subject;
    }

    public void setSubject(CustomerSubject subject) {
        this.subject = subject;
    }

    public List<CustomerComment> getComments() {
        return comments;
    }

    public void setComments(List<CustomerComment> comments) {
        this.comments = comments;
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
        if (!(object instanceof CustomerProblem)) {
            return false;
        }
        CustomerProblem other = (CustomerProblem) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.support.CustomerProblem[ id=" + id + " ]";
    }
    
}
