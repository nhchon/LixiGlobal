/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form.support;

import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author chonnh
 */
public class CustomerProblemForm {
    
    private Long subject;
    
    private String otherSubject;
    
    @NotBlank(message = "{validate.support.content_require}")
    private String content;
    
    private Long orderId;
    
    @NotBlank(message = "{validate.not_null}")
    private String contactMethod;
    
    @NotBlank(message = "{validate.not_null}")
    private String contactData;

    public Long getSubject() {
        return subject;
    }

    public void setSubject(Long subject) {
        this.subject = subject;
    }

    public String getOtherSubject() {
        return otherSubject;
    }

    public void setOtherSubject(String otherSubject) {
        this.otherSubject = otherSubject;
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
    
    
}
