/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.Network;
import vn.chonsoft.lixi.model.VtcServiceCode;

/**
 *
 * @author chonnh
 */
public interface VtcServiceCodeRepository  extends  JpaRepository<VtcServiceCode, Long>{
    
    VtcServiceCode findByCode(String code);
    
    VtcServiceCode findByNetworkAndLxChucNang(Network network, String lxChucNang);
}
