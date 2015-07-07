/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.inject.Inject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.model.fido.FidoCity;
import vn.chonsoft.lixi.model.fido.FidoDogPark;
import vn.chonsoft.lixi.repositories.FidoCityRepository;
import vn.chonsoft.lixi.repositories.FidoDogParkRepository;
import vn.chonsoft.lixi.repositories.service.util.FidoUtils;

/**
 *
 * @author chonnh
 */
@Service
public class DefaultFidoCityService implements FidoCityService {

    private static final Logger log = LogManager.getLogger();

    @Inject
    FidoCityRepository fidoCityRepository;
    @Inject
    FidoDogParkRepository fidoDogParkRepository;

    @Override
    public Page<FidoCity> findAll(Pageable page) {

        Page<FidoCity> entities = this.fidoCityRepository.findAll(page);

        return new PageImpl<>(entities.getContent(), page, entities.getTotalElements());
    }

    @Override
    //@Scheduled(fixedDelay = 1_000L*60*1, initialDelay = 15_000L)
    public void getDogParks() {
        Pageable just2rec = new PageRequest(0, 2, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        //
        Page<FidoCity> p = this.fidoCityRepository.findByCompletedIs((short) 0, just2rec);
        for (FidoCity fc : p.getContent()) {
            //
            log.info(fc.getCityName() + " : " + fc.getCityUrl());
            //
            for (String city : FidoUtils.getDogParkPages(fc.getCityUrl())) {
                List<FidoDogPark> fdps = FidoUtils.getDogParks(city);
                for (FidoDogPark fdp : fdps) {
                    fdp.setCityId(fc);
                }
                //
                this.fidoDogParkRepository.save(fdps);
            }
            // completed
            fc.setCompleted((short) 1);
            this.fidoCityRepository.save(fc);
        }
    }

    @Override
    //@Scheduled(fixedDelay = 1_000L*60*2, initialDelay = 15_000L)
    public void getDetailDogParkAddress() {
        Pageable just5rec = new PageRequest(0, 5, new Sort(new Sort.Order(Sort.Direction.ASC, "id")));
        //
        Page<FidoDogPark> page = this.fidoDogParkRepository.findByAddress1Is(null, just5rec);
        for (FidoDogPark p : page.getContent()) {
            List<String> add = FidoUtils.getDetailDogParkAddress(p.getAddressDetailUrl());
            if (add != null && add.size() > 0) {
                if (add.size() >= 1) {
                    p.setAddress1(add.get(0));
                }
                if (add.size() >= 2) {
                    p.setAddress2(add.get(1));
                }
                if (add.size() >= 3) {
                    p.setAddress3(add.get(2));
                }
                //
                this.fidoDogParkRepository.save(p);
            } else {
                
                log.info(p.getParkName() + " has no address.");
            }
        }
    }
}
