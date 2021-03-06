/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.DauSo;
import vn.chonsoft.lixi.model.Network;

/**
 *
 * @author chonnh
 */
public interface DauSoRepository  extends  JpaRepository<DauSo, Long>{
    
    List<DauSo> findByCode(String code);
    
    List<DauSo> findByNetwork(Network network);
}
