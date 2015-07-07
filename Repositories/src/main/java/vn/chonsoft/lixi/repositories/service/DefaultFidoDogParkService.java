/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.chonsoft.lixi.model.fido.FidoDogPark;
import vn.chonsoft.lixi.repositories.FidoDogParkRepository;

/**
 *
 * @author chonnh
 */
@Service
public class DefaultFidoDogParkService  implements FidoDogParkService{
    
    @Inject FidoDogParkRepository fidoDogParkRepository;

    @Override
    @Transactional
    public void save(List<FidoDogPark> l) {
        
        this.fidoDogParkRepository.save(l);
    }
    
    @Override
    public Page<FidoDogPark> findAll(Pageable page){
        
        Page<FidoDogPark> entities = this.fidoDogParkRepository.findAll(page);
        
        return new PageImpl<>(entities.getContent(), page, entities.getTotalElements());
    }
}
