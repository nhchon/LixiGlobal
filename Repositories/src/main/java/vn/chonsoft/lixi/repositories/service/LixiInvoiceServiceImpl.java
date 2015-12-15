/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

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
    
    
}
