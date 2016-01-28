/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.math.BigDecimal;
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
     * @param id
     * @return 
     */
    @Override
    public double sumGiftOfRecipient(Long id){
        
        String sql = "select sum(product_price) from lixi_order_gifts where recipient = ?";
        
        Double rs = scalarDao.singleResult(sql, id);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public double sumTopUpOfRecipient(Long id){
        
        String sql = "select sum(amount) from top_up_mobile_phone where recipient = ?";
        Double rs = scalarDao.singleResult(sql, id);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public double sumGiftOfSender(Long id){
        
        String sql = "SELECT sum(g.usd_price) FROM lixi_order_gifts g, lixi_orders o, users u WHERE g.order_id = o.id and o.sender = u.id and u.id = ?";
        
        Double rs = scalarDao.singleResult(sql, id);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }
    
    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public double sumTopUpOfSender(Long id){
        
        String sql = "SELECT sum(t.amount_usd) FROM top_up_mobile_phone t, lixi_orders o, users u WHERE t.order_id = o.id and o.sender = u.id and u.id = ?";
        Double rs = scalarDao.singleResult(sql, id);
        if(rs != null){
            return rs.doubleValue();
        }
        else{
            return 0d;
        }
    }

}