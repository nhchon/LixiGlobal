/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.pojo.EnumTransactionStatus;
import vn.chonsoft.lixi.repositories.LixiInvoiceRepository;

/**
 *
 * @author chonnh
 */
@Service
public class LixiInvoiceServiceImpl implements LixiInvoiceService{
    
    private static final Logger log = LogManager.getLogger(LixiInvoiceServiceImpl.class);
            
    @Autowired
    private LixiInvoiceRepository invoiceRepository;

    /**
     * 
     * @param invoice
     * @return 
     */
    @Override
    @Transactional
    public LixiInvoice save(LixiInvoice invoice) {
        
        return this.invoiceRepository.save(invoice);
        
    }

    @Override
    public LixiInvoice findById(long id) {
        
        LixiInvoice invoice = this.invoiceRepository.findOne(id);
        if(invoice != null){
            invoice.getOrder();
        }
        
        return invoice;
    }

    @Override
    public LixiInvoice findByOrder(LixiOrder order) {
        
        LixiInvoice invoice = this.invoiceRepository.findByOrder(order);
        if(invoice != null){
            invoice.getOrder();
        }
        
        return invoice;
    }
    
    /**
     * 
     * @param transId
     * @return 
     */
    @Override
    public LixiInvoice findByNetTransId(String transId){
        
        return this.invoiceRepository.findByNetTransId(transId);
        
    }
    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public List<LixiInvoice> findByNetResponseCode(Iterable<String> code){
        
        return this.invoiceRepository.findByNetResponseCodeIn(code);
        
    }
    
    /**
     * 
     * @param status
     * @return 
     */
    @Override
    public List<LixiInvoice> findByNetTransStatusIn(Iterable<String> status){
        
        return this.invoiceRepository.findByNetTransStatusIn(status);
        
    }
    
    /**
     * 
     * @return 
     */
    @Override
    public List<LixiInvoice> findAll(){
        
        List<LixiInvoice> invs = this.invoiceRepository.findAll();
        invs.forEach(i -> {i.getOrder();});
        
        return invs;
        
    }
}
