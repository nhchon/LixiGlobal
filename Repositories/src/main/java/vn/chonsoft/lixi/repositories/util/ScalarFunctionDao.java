/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.util;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import org.springframework.stereotype.Service;

/**
 *
 * @author chonnh
 */
@Service
public class ScalarFunctionDao<T> {

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * 
     * @param sql
     * @return 
     */
    public T singleResult(String sql) {
        return singleResult(sql, null);
    }

    /**
     * 
     * @param sql
     * @return 
     */
    public List<T> list(String sql) {
        return list(sql, null);
    }
    
    /**
     * 
     * @param sql
     * @param parms
     * @return 
     */
    public T singleResult(String sql, Object... parms) {
        List<T> result = null;
        result = list(sql, parms);
        return result.isEmpty() ? null : result.get(0);
    }

    /**
     * 
     * @param sql
     * @param parms
     * @return 
     */
    public List<T> list(String sql, Object... parms) {
        if (parms == null || parms.length == 0) {
            return entityManager.createNativeQuery(sql).getResultList();
        }
        Query query = entityManager.createNativeQuery(sql);
        for (int i = 0; i < parms.length; i++) {
            query.setParameter(i + 1, parms[i]);
        }
        return query.getResultList();
    }
}
