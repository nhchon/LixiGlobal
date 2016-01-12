/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author chonnh
 */
@XmlRootElement(name = "account")
public class BaoKimStatusForm {
    
    private Long orderId;
    private String status;
    private String message;
    private String receiveMethod;
    private String updatedOn;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getReceiveMethod() {
        return receiveMethod;
    }

    public void setReceiveMethod(String receiveMethod) {
        this.receiveMethod = receiveMethod;
    }

    public String getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(String updatedOn) {
        this.updatedOn = updatedOn;
    }
    
    
}
