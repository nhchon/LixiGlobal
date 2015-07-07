/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.chonsoft.lixi.model.fido.FidoDogPark;

/**
 *
 * @author chonnh
 */
public interface FidoDogParkService {
    
    Page<FidoDogPark> findAll(Pageable page);
    void save(List<FidoDogPark> l);
}
