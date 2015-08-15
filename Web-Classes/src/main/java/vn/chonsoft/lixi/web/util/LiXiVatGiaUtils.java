/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import org.apache.http.HttpHost;
import org.apache.http.impl.client.HttpClients;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.web.client.RestTemplate;
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.model.pojo.ListVatGiaCategory;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.pojo.VatGiaCategory;

/**
 *
 * (Singleton pattern)
 * @author chonnh
 */
public class LiXiVatGiaUtils {
    
    private static final Logger log = LogManager.getLogger(LiXiVatGiaUtils.class);
    
    private static LiXiVatGiaUtils instance;
    
    private Properties baokimProp = null;
    /**
     * 
     */
    private LiXiVatGiaUtils(){
        
        try {
            
            /* Load baokim properties */
            Resource resource = new ClassPathResource("/baokim.properties");
            baokimProp = PropertiesLoaderUtils.loadProperties(resource);
            
        } catch (Exception e) {
            
            log.info("Load baokim.properties is failed", e);
            
        }
        
    }
    
    /**
     * 
     * @return 
     */
    public static LiXiVatGiaUtils getInstance(){
        
        if(instance == null){
            //synchronized (LiXiVatGiaUtils.class) {
                if(instance == null){
                    
                    instance = new LiXiVatGiaUtils();
                }
            //}
        }
        
        return instance;
    }
    
    /* business methods */
    /**
     * 
     * @param vgcpojo
     * @return 
     */
    public VatgiaCategory convertFromPojo2Model(VatGiaCategory vgcpojo){
        
        return new VatgiaCategory(vgcpojo.getId(), vgcpojo.getTitle());
        
    }
    /**
     * 
     * @param vgcpojos
     * @return 
     */
    public List<VatgiaCategory> convertFromPojo2Model(ListVatGiaCategory vgcpojos){
        
        List<VatgiaCategory> vgcs = new ArrayList<>();
        
        if(vgcpojos == null) return vgcs;
        
        for(VatGiaCategory vgcpojo : vgcpojos.getData()){
            
            VatgiaCategory vgc = new VatgiaCategory(vgcpojo.getId(), vgcpojo.getTitle());
            
            vgcs.add(vgc);
            
        }
        
        return vgcs;
        
    }
    /**
     *
     * @return
     */
    public ListVatGiaCategory getVatGiaCategory() {
        
        // check properties is null
        if(baokimProp == null) return null;
        //
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));
            //
            final RestTemplate restTemplate = new RestTemplate(requestFactory);
            //
            return restTemplate.getForObject(baokimProp.getProperty("baokim.list_category_page"), ListVatGiaCategory.class);

        } catch (Exception e) {

            log.info(e.getMessage(), e);

        }

        return null;
    }
    
    /**
     * 
     * get product list returned by categorory id and price
     * 
     * @param categoryId
     * @param price
     * @return 
     */
    public ListVatGiaProduct getVatGiaProducts(int categoryId, float price){
        // check properties is null
        if(baokimProp == null) return null;
        //
        try {

            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(baokimProp.getProperty("baokim.host")), baokimProp.getProperty("baokim.username"), baokimProp.getProperty("baokim.password"));

            final RestTemplate restTemplate = new RestTemplate(requestFactory);
            
            String genUrl = baokimProp.getProperty("baokim.list_product_page") + "?category_id=" + categoryId +"&price=" + price;
            
            log.info(genUrl);
            
            return restTemplate.getForObject(genUrl, ListVatGiaProduct.class);

        } catch (Exception e) {

            log.info(e.getMessage(), e);

        }

        return null;
    }
}
