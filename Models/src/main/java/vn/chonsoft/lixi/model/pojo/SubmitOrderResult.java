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
public class SubmitOrderResult {
    
    private String message;
    
    private String order_id;

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
    
    @Override
    public String toString(){
        
        return "[" + order_id + ", " + message + "]";
    }
}
