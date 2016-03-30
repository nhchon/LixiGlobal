/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.LixiMonitor;
import vn.chonsoft.lixi.repositories.LixiMonitorRepository;

/**
 *
 * @author Asus
 */
@Service
public class LixiMonitorServiceImpl implements LixiMonitorService{

    @Autowired
    private LixiMonitorRepository monitorRepository;
    
    /**
     * 
     * @param m
     * @return 
     */
    @Override
    public LixiMonitor save(LixiMonitor m) {
        
        return this.monitorRepository.save(m);
        
    }

    /**
     * 
     * @param id
     * @return 
     */
    @Override
    public LixiMonitor find(Long id){
        
        return this.monitorRepository.findOne(id);
    }
    /**
     * s
     * @param processed
     * @return 
     */
    @Override
    @Transactional
    public List<LixiMonitor> findByProcessed(Integer processed) {
        
        List<LixiMonitor> ms = this.monitorRepository.findByProcessed(processed);
        if(ms != null){
            ms.forEach(m ->{
                m.getUser().getEmail();
            });
        }
        
        return ms;
    }
    
}
