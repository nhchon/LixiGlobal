/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import vn.chonsoft.lixi.model.support.CustomerComment;

/**
 *
 * @author chonnh
 */
public interface CustomerCommentService {
    
    CustomerComment save(CustomerComment comment);
    
}
