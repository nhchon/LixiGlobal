/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.util;

import java.util.ArrayList;
import java.util.Calendar;
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
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.model.pojo.ListVatGiaCategory;
import vn.chonsoft.lixi.model.pojo.ListVatGiaProduct;
import vn.chonsoft.lixi.model.pojo.VatGiaCategoryPj;
import vn.chonsoft.lixi.model.pojo.VatGiaProductPj;

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
    public VatgiaCategory convertFromPojo2Model(VatGiaCategoryPj vgcpojo){
        
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
        
        for(VatGiaCategoryPj vgcpojo : vgcpojos.getData()){
            
            VatgiaCategory vgc = new VatgiaCategory(vgcpojo.getId(), vgcpojo.getTitle());
            
            vgcs.add(vgc);
            
        }
        
        return vgcs;
        
    }
    /**
     * 
     * @param pj
     * @return 
     */
    public VatgiaProduct convertVatGiaProduct2Model(VatGiaProductPj pj){
        
        if(pj == null) return null;
        //
        VatgiaProduct p = new VatgiaProduct();
        p.setId(pj.getId());
        p.setCategoryId(pj.getCategory_id());
        p.setCategoryName(pj.getCategory_name());
        p.setName(pj.getName());
        p.setPrice(pj.getPrice());
        p.setImageUrl(pj.getImage_url());
        p.setLinkDetail(pj.getLink_detail());
        p.setModifiedDate(Calendar.getInstance().getTime());
        
        return p;
    }

    /**
     * 
     * @param pjs
     * @return 
     */
    public List<VatgiaProduct> convertVatGiaProduct2Model(ListVatGiaProduct pjs){
        
        if(pjs == null || pjs.getData() == null) return null;
        //
        List<VatgiaProduct> ps = new ArrayList<>();
        for(VatGiaProductPj p : pjs.getData()){
            
            ps.add(convertVatGiaProduct2Model(p));
            
        }
        //
        return ps;
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
    public ListVatGiaProduct getVatGiaProducts(int categoryId, double price){
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
