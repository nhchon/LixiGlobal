/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.inject.Inject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.LixiExchangeRate;
import vn.chonsoft.lixi.pojo.BankExchangeRate;
import vn.chonsoft.lixi.pojo.Exrate;
import vn.chonsoft.lixi.repositories.LixiExchangeRateRepository;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
@Service
public class LixiExchangeRateServiceImpl implements LixiExchangeRateService{

    private static final Logger log = LogManager.getLogger(LixiExchangeRateServiceImpl.class);
    
    @Autowired
    private LixiExchangeRateRepository lxrRepository;
    
    @Autowired
    private CurrencyTypeService currencyService;
    
    /**
     * 
     */
    @Override
    @Scheduled(fixedDelay=1*60*60*1000, initialDelay=60*1000)
    public void autoUpdateExFromVCB(){
        
        log.info("========== Auto Update VCB Exchange Rate ====================");
        BankExchangeRate vcb = LiXiGlobalUtils.getVCBExchangeRates();
        
        // get usd
        Exrate usdEx = null;
        if(vcb != null){
            if(vcb.getExrates() != null && !vcb.getExrates().isEmpty()){
            
                for(Exrate ex : vcb.getExrates()){
                    if(LiXiGlobalConstants.USD.equalsIgnoreCase(ex.getCode())){
                        usdEx = ex;
                        break;
                    }
                }
            }
            /**/
            if(usdEx != null){

                /* show log */
                log.info(vcb.getBankName());
                log.info(vcb.getTime());
                log.info(usdEx.getName() + " - " + usdEx.getCode());
                log.info("Buy: " + usdEx.getBuy());
                log.info("Sell: " + usdEx.getSell());
                
                /* */
                LixiExchangeRate lxExch = this.findLastRecord(LiXiGlobalConstants.USD);
                
                if(usdEx.getBuy() != lxExch.getBuy() || usdEx.getSell() != lxExch.getSell()){
                    
                    /* create new lixi exchange rate */
                    double newBuyRate = usdEx.getBuy() + (usdEx.getBuy() * LiXiGlobalConstants.LIXI_DEFAULT_BUY_RATE / 100.0);
                    double roundNewBuyRate = Math.floor(newBuyRate/100.0) * 100;
                    
                    double newSellRate = usdEx.getSell() + (usdEx.getSell() * LiXiGlobalConstants.LIXI_DEFAULT_SELL_RATE / 100.0);
                    double roundNewSellRate = Math.floor(newSellRate/100.0) * 100;
                    
                    LixiExchangeRate lixiexr = new LixiExchangeRate();
                    Date cDate = Calendar.getInstance().getTime();
                    lixiexr.setDateInput(cDate);
                    lixiexr.setTimeInput(cDate);
                    lixiexr.setBuy(roundNewBuyRate);
                    lixiexr.setSell(roundNewSellRate);
                    lixiexr.setBuyPercentage(LiXiGlobalConstants.LIXI_DEFAULT_BUY_RATE);
                    lixiexr.setSellPercentage(LiXiGlobalConstants.LIXI_DEFAULT_SELL_RATE);
                    lixiexr.setCurrency(this.currencyService.findByCode(LiXiGlobalConstants.USD));
                    lixiexr.setCreatedBy(LiXiGlobalConstants.AUTO_SYSTEM);
                    lixiexr.setCreatedDate(cDate);

                    this.save(lixiexr);
                    
                }
                else{
                    /* reference information*/
                }
            }
        }
        
        log.info("=============================================================");
    }
    /**
     * 
     * @param lx 
     */
    @Override
    @Transactional
    public void save(LixiExchangeRate lx) {
        
        this.lxrRepository.save(lx);
        
    }

    @Override
    public LixiExchangeRate findById(Long id){
        
        return this.lxrRepository.findOne(id);
        
    }
    /**
     * 
     * @return 
     */
    @Override
    public List<LixiExchangeRate> findAll() {

        return LiXiGlobalUtils.toList(this.lxrRepository.findAll(new Sort(new Sort.Order(Sort.Direction.DESC, "id"))));
        
    }
    
    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public LixiExchangeRate findLastRecord(String code){
        
        Pageable just1rec = new PageRequest(0, 1, new Sort(new Sort.Order(Sort.Direction.DESC, "id")));
        
        Page<LixiExchangeRate> p1 = this.lxrRepository.findByCurrency_Code(code, just1rec);
        
        if(p1 != null){
            
            List<LixiExchangeRate> l1 = p1.getContent();
            
            if(l1 != null && !l1.isEmpty()){
                
                return l1.get(0);
                
            }
        }
        //
        return null;
    }
}
