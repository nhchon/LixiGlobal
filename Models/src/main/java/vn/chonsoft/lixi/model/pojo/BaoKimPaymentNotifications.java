/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author chonnh
 */
public class BaoKimPaymentNotifications implements Serializable{
    
    private List<BaoKimPaymentNotification> data;

    public List<BaoKimPaymentNotification> getData() {
        return data;
    }

    public void setData(List<BaoKimPaymentNotification> data) {
        this.data = data;
    }
}
