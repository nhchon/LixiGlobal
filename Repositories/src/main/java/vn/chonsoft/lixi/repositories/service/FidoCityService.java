/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.chonsoft.lixi.model.fido.FidoCity;

/**
 *
 * @author chonnh
 */
public interface FidoCityService {
    
    Page<FidoCity> findAll(Pageable page);
    void getDogParks();
    void getDetailDogParkAddress();
}
