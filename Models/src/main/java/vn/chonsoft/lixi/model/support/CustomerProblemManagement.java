/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.support;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "customer_problem_management")
public class CustomerProblemManagement implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    
    @Basic
    @Column(name = "handled_by")
    private String handledBy;
    
    @Basic
    @Column(name = "handled_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date handledDate;

    @JoinColumn(name = "prob_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private CustomerProblem problem;

    
    public CustomerProblemManagement() {
    }

    public CustomerProblemManagement(Long id) {
        this.id = id;
    }

    public CustomerProblemManagement(Long id, String handledBy, Date handledDate, CustomerProblem problem) {
        this.id = id;
        this.handledBy = handledBy;
        this.handledDate = handledDate;
        this.problem = problem;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public CustomerProblem getProblem() {
        return problem;
    }

    public void setProblem(CustomerProblem problem) {
        this.problem = problem;
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
        if (!(object instanceof CustomerProblemManagement)) {
            return false;
        }
        CustomerProblemManagement other = (CustomerProblemManagement) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.support.CustomerProblemManagement[ id=" + id + " ]";
    }
    
}
