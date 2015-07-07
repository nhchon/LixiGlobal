/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.chonsoft.lixi.model.AdminUser;

/**
 *
 * @author chonnh
 */
public interface AdminUserRepository  extends JpaRepository<AdminUser, Long>{
    
    AdminUser findByEmail(String email);
    
}
