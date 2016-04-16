/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
    public LixiInvoice findFirstPurchase(Long payer, String invStatus){
        
        Pageable just1rec = new PageRequest(0, 1, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        
        Page<LixiInvoice> pInv = this.invoiceRepository.findByPayerAndInvoiceStatus(payer, invStatus, just1rec);
        
        if(pInv != null){
            List<LixiInvoice> ls = pInv.getContent();
            if(ls != null && !ls.isEmpty()){
                return ls.get(0);
            }
        }
        
        return null;
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
    
    /**
     * 
     * @param invStatus
     * @return 
     */
    @Override
    @Transactional
    public List<LixiInvoice> findByInvoiceStatus(String invStatus){
        List<LixiInvoice> invs = this.invoiceRepository.findByInvoiceStatus(invStatus);
        invs.forEach(i -> {i.getOrder();});
        
        return invs;
    }
    
    /**
     * 
     * @param invStatus
     * @return 
     */
    @Override
    @Transactional
    public List<LixiInvoice> findByInvoiceStatusIn(Iterable<String> invStatus){
        List<LixiInvoice> invs = this.invoiceRepository.findByInvoiceStatusIn(invStatus);
        invs.forEach(i -> {i.getOrder();});
        
        return invs;
    }

    /**
     * 
     * @param monitored
     * @return 
     */
    @Override
    public List<LixiInvoice> findByMonitored(Integer monitored) {
        
        List<LixiInvoice> invs = this.invoiceRepository.findByMonitored(monitored);
        invs.forEach(i -> {i.getOrder();});
        
        return invs;    
    }
    
}
