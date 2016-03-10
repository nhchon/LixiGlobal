/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
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
    
    @Autowired
    ScalarFunctionDao<BigInteger> scalarDaoL;
    
    /**
     * 
     * @param status
     * @param id
     * @return 
     */
    @Override
    public List<Long> getOrdersOfRecipient(String status, Long id){
        
        String sql = "select distinct order_id from lixi_order_gifts g where g.recipient=? and g.bk_status=?";
        
        List<BigInteger> rs = scalarDaoL.list(sql, id, status);
        if(rs != null)
        {
            List<Long> rsL = new ArrayList<>();
            rs.forEach(x -> {
                
                rsL.add(x.longValue());
                
            });
            
            return rsL;
        }
        
        return new ArrayList<>();
    }
    /**
     * 
     * @param invoiceStatus 
     * @param id
     * @return 
     */
    @Override
    public double sumGiftOfRecipient(String invoiceStatus, Long id){
        
        String sql = "select sum(g.product_price) from  lixi_order_gifts g , lixi_invoices i where g.recipient=? and g.order_id = i.order_id and i.invoice_status=?";
        
        Double rs = scalarDao.singleResult(sql, id, invoiceStatus);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }
    
    @Override
    public double sumGiftOfRecipientByOrderStatus(String oStatus, Long id){
        
        String sql = "select sum(g.product_price)from  lixi_order_gifts g , lixi_orders o where g.recipient=? and g.order_id = o.id and o.lixi_status=?";
        
        Double rs = scalarDao.singleResult(sql, id, oStatus);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }
    
    /**
     * 
     * @param oStatus 
     * @param id
     * @return 
     */
    @Override
    public double sumTopUpOfRecipientByOrderStatus(String oStatus, Long id){
        
        String sql = "select sum(t.amount)from top_up_mobile_phone t, lixi_orders o where t.recipient=? and t.order_id = o.id and o.lixi_status=?";
        Double rs = scalarDao.singleResult(sql, id, oStatus);
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
     * @param oStatus 
     * @param sender
     * @return 
     */
    @Override
    public long countOrdersOfSender(String oStatus, Long sender){
        
        String sql = "SELECT count(*) FROM lixi_orders o WHERE o.lixi_status = ? and o.sender = ?";
        
        BigInteger rs = scalarDaoL.singleResult(sql, oStatus, sender);
        if(rs != null){
            return rs.longValue();
        }
        else{
            return 0;
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
    
    @Override
    public double sumInvoiceByOrderStatus(String status, long sender){
        String sql = "SELECT sum(i.total_amount) FROM lixi_orders o, lixi_invoices i WHERE o.lixi_status = ? and o.id = i.order_id and i.payer = ?";
        
        Double rs = scalarDao.singleResult(sql, status, sender);
        if(rs != null){
            return rs;
        }
        else{
            return 0d;
        }
    }
    
    /**
     * 
     * @param status
     * @param sender
     * @return 
     */
    @Override
    public double sumInvoiceVndByOrderStatus(String status, long sender){
        String sql = "SELECT sum(i.total_amount_vnd) FROM lixi_orders o, lixi_invoices i WHERE o.lixi_status = ? and o.id = i.order_id and i.payer = ?";
        
        Double rs = scalarDao.singleResult(sql, status, sender);
        if(rs != null){
            return rs;
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
