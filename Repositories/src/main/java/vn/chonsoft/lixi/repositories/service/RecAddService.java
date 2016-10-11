/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.util.List;
import vn.chonsoft.lixi.model.RecAdd;

/**
 *
 * @author Asus
 */
public interface RecAddService {
    
    List<RecAdd> findByEmail(String email);
    RecAdd save(RecAdd recAdd);
}
