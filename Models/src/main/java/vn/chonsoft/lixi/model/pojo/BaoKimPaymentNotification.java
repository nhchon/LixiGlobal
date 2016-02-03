/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public class BaoKimPaymentNotification {
    
    private String order_id;
    private String amount;
    private String date_transfer;

    public BaoKimPaymentNotification(String order_id, String amount, String date_transfer){
        
        this.order_id = order_id;
        this.amount = amount;
        this.date_transfer = date_transfer;
    }
    
    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getDate_transfer() {
        return date_transfer;
    }

    public void setDate_transfer(String date_transfer) {
        this.date_transfer = date_transfer;
    }
    
    @Override
    public String toString(){
        
        return "[" + order_id + ", " + amount + ", " + date_transfer + "]";
    }
}
