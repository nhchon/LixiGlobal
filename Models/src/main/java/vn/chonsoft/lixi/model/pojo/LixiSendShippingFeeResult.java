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
public class LixiSendShippingFeeResult {
    
    private SendShippingFeeResult data;

    public SendShippingFeeResult getData() {
        return data;
    }

    public void setData(SendShippingFeeResult data) {
        this.data = data;
    }
    
    @Override
    public String toString(){
        
        return "[" + data + "]";
    }
}
