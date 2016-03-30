/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
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
    @Transactional
    public LixiInvoice findById(long id) {
        
        LixiInvoice invoice = this.invoiceRepository.findOne(id);
        if(invoice != null){
            invoice.getOrder();
        }
        
        return invoice;
    }

    @Override
    @Transactional
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
    @Transactional
    public LixiInvoice findByNetTransId(String transId){
        
        return this.invoiceRepository.findByNetTransId(transId);
        
    }
    /**
     * 
     * @param code
     * @return 
     */
    @Override
    @Transactional
    public List<LixiInvoice> findByNetResponseCode(Iterable<String> code){
        
        return this.invoiceRepository.findByNetResponseCodeIn(code);
        
    }
    
    /**
     * 
     * @param status
     * @return 
     */
    @Override
    @Transactional
    public List<LixiInvoice> findByNetTransStatusIn(Iterable<String> status){
        
        List<LixiInvoice> invs = this.invoiceRepository.findByNetTransStatusIn(status);
        invs.forEach(i -> {i.getOrder();});
        
        return invs;
        
    }
    
    /**
     * 
     * @return 
     */
    @Override
    @Transactional
    public List<LixiInvoice> findAll(){
        
        List<LixiInvoice> invs = this.invoiceRepository.findAll();
        invs.forEach(i -> {i.getOrder();});
        
        return invs;
        
    }
    
    /**
     * 
     * @param payer
     * @param invStatus
     * @return 
     */
    @Override
    @Transactional
    public List<LixiInvoice> findByPayerAndInvoiceStatus(Long payer, String invStatus){
        
        List<LixiInvoice> invs = this.invoiceRepository.findByPayerAndInvoiceStatus(payer, invStatus);
        invs.forEach(i -> {i.getOrder();});
        
        return invs;
    }
    
    /**
     * 
     * @param payer
     * @param invStatus
     * @return 
     */
    @Override
    @Transactional
    public List<LixiInvoice> findByPayerAndInvoiceStatusIn(Long payer, Iterable<String> invStatus){
        
        List<LixiInvoice> invs = this.invoiceRepository.findByPayerAndInvoiceStatusIn(payer, invStatus);
        invs.forEach(i -> {i.getOrder();});
        
        return invs;
    }
}
