/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author Asus
 */
public class CheckStatusResult {
    
    private String message;
    private String order_id;
    private String status;
    private String receive_method;
    private String updated_on;

    @Override
    public String toString(){
        
        return "[" + order_id+", " + status + ", " + receive_method + ", " + message + ", " + updated_on + "]";
    }
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReceive_method() {
        return receive_method;
    }

    public void setReceive_method(String receive_method) {
        this.receive_method = receive_method;
    }

    public String getUpdated_on() {
        return updated_on;
    }

    public void setUpdated_on(String updated_on) {
        this.updated_on = updated_on;
    }
    
    
    
}
