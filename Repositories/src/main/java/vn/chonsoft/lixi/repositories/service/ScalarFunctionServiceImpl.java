/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.repositories.util.ScalarFunctionDao;

/**
 *
 * @author chonnh
 */
@Service
public class ScalarFunctionServiceImpl implements ScalarFunctionService{
    
    @Autowired
    ScalarFunctionDao<Double> scalarDao;
    
    /**
     * 
     * @param invoiceStatus 
     * @param id
     * @return 
     */
    @Override
    public double sumGiftOfRecipient(String invoiceStatus, Long id){
        
        String sql = "select sum(g.product_price)from  lixi_order_gifts g , lixi_invoices i where g.recipient=? and g.order_id = i.order_id and i.invoice_status=?";
        
        Double rs = scalarDao.singleResult(sql, id, invoiceStatus);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }
    
    /**
     * 
     * @param invoiceStatus 
     * @param id
     * @return 
     */
    @Override
    public double sumTopUpOfRecipient(String invoiceStatus, Long id){
        
        String sql = "select sum(t.amount)from top_up_mobile_phone t, lixi_invoices i where t.recipient=? and t.order_id = i.order_id and i.invoice_status=?";
        Double rs = scalarDao.singleResult(sql, id, invoiceStatus);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }

    /**
     * 
     * @param invoiceStatus 
     * @param sender
     * @return 
     */
    @Override
    public double sumInvoiceOfSender(String invoiceStatus, Long sender){
        
        String sql = "SELECT sum(i.total_amount) FROM lixi_invoices i WHERE i.invoice_status = ? and i.payer = ?";
        
        Double rs = scalarDao.singleResult(sql, invoiceStatus, sender);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }
    
    /**
     * 
     * @param invoiceStatus 
     * @param sender
     * @return 
     */
    @Override
    public double sumTopUpOfSender(String invoiceStatus, Long sender){
        
        String sql = "SELECT sum(t.amount_usd) FROM top_up_mobile_phone t , lixi_invoices i WHERE  t.order_id = i.order_id and i.invoice_status = ? and i.payer = ?";
        Double rs = scalarDao.singleResult(sql, invoiceStatus, sender);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }

}
