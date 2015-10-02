/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.Network;
import vn.chonsoft.lixi.model.VtcServiceCode;
import vn.chonsoft.lixi.repositories.VtcServiceCodeRepository;

/**
 *
 * @author chonnh
 */
@Service
public class VtcServiceCodeServiceImpl implements VtcServiceCodeService{
    
    @Inject
    private VtcServiceCodeRepository vtcServiceCodeService;

    /**
     * 
     * @param code
     * @return 
     */
    @Override
    public VtcServiceCode findByCode(String code) {
        
        return this.vtcServiceCodeService.findByCode(code);
    }
    
    /**
     * 
     * @param network
     * @param lxChucNang
     * @return 
     */
    @Override
    public VtcServiceCode findByNetworkAndLxChucNang(Network network, String lxChucNang){
        
        return this.vtcServiceCodeService.findByNetworkAndLxChucNang(network, lxChucNang);
    }
    
    /**
     * 
     * @return 
     */
    @Override
    public List<VtcServiceCode> findAll() {
        
        return this.vtcServiceCodeService.findAll();
        
    }
}
