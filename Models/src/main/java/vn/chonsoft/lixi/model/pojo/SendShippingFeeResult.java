/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public class SendShippingFeeResult {
    
    private String error_code;
    
    private String message;
    
    private String lixi_order_id;
    
    private String receiver_email;
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getLixi_order_id() {
        return lixi_order_id;
    }

    public void setLixi_order_id(String lixi_order_id) {
        this.lixi_order_id = lixi_order_id;
    }

    public String getError_code() {
        return error_code;
    }

    public void setError_code(String error_code) {
        this.error_code = error_code;
    }

    public String getReceiver_email() {
        return receiver_email;
    }

    public void setReceiver_email(String receiver_email) {
        this.receiver_email = receiver_email;
    }
    
    
    @Override
    public String toString(){
        
        return "[" + error_code + ", " + lixi_order_id + ", " + receiver_email + ", "  + message + "]";
    }
}
