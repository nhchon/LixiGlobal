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
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.web.client.RestTemplate;
import vn.chonsoft.lixi.model.VatgiaCategory;
import vn.chonsoft.lixi.model.pojo.BankExchangeRate;
import vn.chonsoft.lixi.model.pojo.Exrate;
import vn.chonsoft.lixi.model.pojo.ListVatGiaCategoryPojo;
import vn.chonsoft.lixi.model.pojo.VatGiaCategoryPojo;
import vn.chonsoft.lixi.web.LiXiConstants;

/**
 *
 * @author chonnh
 */
public abstract class LiXiUtils {

    //
    private static final Logger log = LogManager.getLogger(LiXiUtils.class);

    /**
     * the system is set default encode iso-8859-1
     * Convert to UTF-8
     * 
     * @param str
     * @return 
     */
    public static String fixEncode(String str){
        
        if(str == null || "".equals(str)) return str;
        //
        try {
            
            return new String(str.getBytes("ISO-8859-1"), "UTF-8");
            
        } catch (Exception e) {
            
            log.info(e.getMessage(), e);
        }
        
        return str;
    }
    /**
     * 
     * @param vgcpojo
     * @return 
     */
    public static VatgiaCategory convertFromPojo2Model(VatGiaCategoryPojo vgcpojo){
        
        return new VatgiaCategory(vgcpojo.getId(), vgcpojo.getTitle());
        
    }
    /**
     * 
     * @param vgcpojos
     * @return 
     */
    public static List<VatgiaCategory> convertFromPojo2Model(ListVatGiaCategoryPojo vgcpojos){
        
        List<VatgiaCategory> vgcs = new ArrayList<>();
        
        if(vgcpojos == null) return vgcs;
        
        for(VatGiaCategoryPojo vgcpojo : vgcpojos.getData()){
            
            VatgiaCategory vgc = new VatgiaCategory(vgcpojo.getId(), vgcpojo.getTitle());
            
            vgcs.add(vgc);
            
        }
        
        return vgcs;
        
    }
    /**
     *
     * @return
     */
    public static ListVatGiaCategoryPojo getVatGiaCategory() {

        try {

            /* Load baokim properties */
            Resource resource = new ClassPathResource("/baokim.properties");
            Properties props = PropertiesLoaderUtils.loadProperties(resource);
            
            //
            final AuthHttpComponentsClientHttpRequestFactory requestFactory
                    = new AuthHttpComponentsClientHttpRequestFactory(
                            HttpClients.createDefault(), HttpHost.create(props.getProperty("baokim.host")), props.getProperty("baokim.username"), props.getProperty("baokim.password"));
            //
            final RestTemplate restTemplate = new RestTemplate(requestFactory);
            //
            return restTemplate.getForObject(props.getProperty("baokim.list_category_page"), ListVatGiaCategoryPojo.class);

        } catch (Exception e) {

            log.info(e.getMessage(), e);

        }

        return null;
    }

    /**
     *
     * @return
     */
    public static BankExchangeRate getVCBExchangeRates() {

        try {

            // get page: http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx
            Document doc = Jsoup.connect(LiXiConstants.VCB_EXCHANGE_RATES_PAGE)
                    .timeout(0)
                    .maxBodySize(0)
                    .userAgent("Mozilla")
                    .parser(Parser.xmlParser())
                    .get();

            //
            BankExchangeRate ber = new BankExchangeRate();
            ber.setTime(doc.select("DateTime").first().text().trim());
            // name
            String source = doc.select("Source").first().text().trim();
            String[] ns = source.split(" - ");
            ber.setBankName(ns[0]);
            ber.setBankShortName(ns[1]);

            /* */
            Elements exrates = doc.select("Exrate");
            if (exrates.size() > 0) {

                List<Exrate> exs = new ArrayList<>();
                for (Element e : exrates) {

                    Exrate ex = new Exrate();
                    ex.setCode(e.attr("CurrencyCode"));
                    ex.setName(e.attr("CurrencyName"));
                    ex.setBuy(Double.parseDouble(e.attr("Buy")));
                    ex.setTransfer(Double.parseDouble(e.attr("Transfer")));
                    ex.setSell(Double.parseDouble(e.attr("Sell")));

                    exs.add(ex);
                    //log.debug(e.attr("CurrencyCode") + " : " + e.attr("Buy") + " : " + e.attr("Transfer") + " : " + e.attr("Sell"));
                }

                ber.setExrates(exs);

                return ber;
            }
        } catch (Exception e) {

            log.error("getVCBExchangeRates error:", e);

        }

        return null;
    }
}
