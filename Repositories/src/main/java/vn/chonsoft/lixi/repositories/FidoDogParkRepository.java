/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.fido.FidoDogPark;

/**
 *
 * @author chonnh
 */
public interface FidoDogParkRepository extends JpaRepository<FidoDogPark, Long>{
    
    Page<FidoDogPark> findByAddress1Is(String address1, Pageable p);
}
