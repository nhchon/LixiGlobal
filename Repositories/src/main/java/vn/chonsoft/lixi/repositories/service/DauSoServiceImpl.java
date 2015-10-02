/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.DauSo;
import vn.chonsoft.lixi.model.Network;
import vn.chonsoft.lixi.repositories.DauSoRepository;

/**
 *
 * @author chonnh
 */
@Service
public class DauSoServiceImpl implements DauSoService{
    
    @Inject
    private DauSoRepository dauSoRepository;

    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public List<DauSo> findByCode(String code) {
        
        return this.dauSoRepository.findByCode(code);
        
    }

    /**
     * 
     * @param network
     * @return 
     */
    @Override
    public List<DauSo> findByNetwork(Network network) {
        
        return this.dauSoRepository.findByNetwork(network);
    }
    
    
}
