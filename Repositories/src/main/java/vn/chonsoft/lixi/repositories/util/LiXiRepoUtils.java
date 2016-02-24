/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.util;

import java.util.ArrayList;
import java.util.List;
import vn.chonsoft.lixi.model.LixiOrder;

/**
 *
 * @author chonnh
 */
public abstract class LiXiRepoUtils {
    
    /**
     * 
     * @param order 
     */
    public static void loadOrder(LixiOrder order){
        
        if(order != null){
            
            // make sure load gifts
            order.getGifts().size();
            
            // top up
            order.getTopUpMobilePhones().size();
            
            // phone card
            order.getBuyCards().size();
            
            // exchange rate
            order.getLxExchangeRate();
            
            //
            order.getCard();
            
            //
            order.getBankAccount();
            
            // invoice
            order.getInvoice();
        }
        
    }
    
    
    /**
     * 
     * @param <E>
     * @param i
     * @return 
     */
    public static <E> List<E> toList(Iterable<E> i)
    {
        List<E> list = new ArrayList<>();
        i.forEach(list::add);
        return list;
    }
    
}
