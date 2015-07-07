/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.util;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author chonnh
 */
public abstract class LiXiRepoUtils {
    
    /**
     * 
     * @param <E>
     * @param i
     * @return 
     */
    public static <E> List<E> toList(Iterable<E> i)
    {
        List<E> list = new ArrayList<>();
        i.forEach(list::add);
        return list;
    }
    
}
