/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.User;

/**
 *
 * @author chonnh
 */
@Validated
public interface UserService {
    void save(@NotNull(message = "{validate.userService.save.user}") User user);
    
    @Null(message = "{validate.email.inuse}")
    User checkUniqueEmail(@NotNull(message = "{validate.user.email}") String email);
    
    @NotNull(message = "{validate.userService.login.cannot}")
    User findByEmail(@NotNull(message = "{validate.user.email}") String email);
}
