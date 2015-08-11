/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;
import org.springframework.validation.annotation.Validated;
import vn.chonsoft.lixi.model.trader.Trader;

/**
 *
 * @author chonnh
 */
@Validated
public interface TraderService {
    
    void save(@NotNull(message = "{validate.traderService.save.notnull}") Trader trader);
    
    @Null(message = "{validate.email.inuse}")
    Trader checkUniqueEmail(@NotNull(message = "{validate.user.email}") String email);
    
    @Null(message = "{validate.username.inuse}")
    Trader checkUniqueUsername(@NotNull(message = "{validate.username_required}") String username);
    
    @Null(message = "{validate.phone_in_use}")
    Trader checkUniquePhone(@NotNull(message = "{validate.email_required}") String phone);
    
    @NotNull(message = "{validate.cannot_login}")
    Trader findByUsername(@NotNull(message = "{validate.username_required}") String username);

    @NotNull(message = "{validate.cannot_login}")
    Trader findById(@NotNull(message = "{validate.username_required}") Long id);

    List<Trader> findAll();
}
