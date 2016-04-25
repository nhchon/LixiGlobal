/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.namespace.QName;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import vn.chonsoft.lixi.EnumTransactionStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.pojo.BankExchangeRate;
import vn.chonsoft.lixi.pojo.Exrate;

/**
 *
 * @author chonnh
 */
public abstract class LiXiGlobalUtils {
    
    private static final Logger log = LogManager.getLogger(LiXiGlobalUtils.class);
    
    /**
     *
     * @param file
     * @return
     * @throws IOException
     */
    public static byte[] readKeyBytesFromFile(File file) throws IOException {
        InputStream is = new FileInputStream(file);

        // Get the size of the file
        long length = file.length();

        // You cannot create an array using a long type.
        // It needs to be an int type.
        // Before converting to an int type, check
        // to ensure that file is not larger than Integer.MAX_VALUE.
        if (length > Integer.MAX_VALUE) {
            // File is too large
        }

        // Create the byte array to hold the data
        byte[] bytes = new byte[(int) length];

        // Read in the bytes
        int offset = 0;
        int numRead = 0;
        while (offset < bytes.length
                && (numRead = is.read(bytes, offset, bytes.length - offset)) >= 0) {
            offset += numRead;
        }

        // Ensure all the bytes have been read in
        if (offset < bytes.length) {
            throw new IOException("Key File Error: Could not completely read file " + file.getName());
        }

        // Close the input stream and return bytes
        is.close();
        return bytes;

    }
    
    public static String getClientIp(HttpServletRequest request){
        
        /*
        String ipAddress = request.getRemoteAddr();
        if (ipAddress == null) {  
            //is client behind something?
            ipAddress = request.getHeader("X-FORWARDED-FOR");
        }
        
        return ipAddress;
        */
        
        /*
         * http://stackoverflow.com/questions/4678797/how-do-i-get-the-remote-address-of-a-client-in-servlet
         */
        String ip = request.getHeader("X-Forwarded-For");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }
        
        return ip;          
    }
    
    public static double round2Decimal(double a) {

        return Math.round(a * 100.0) / 100.0;
    }

    /**
     * 
     * @param total
     * @return 
     */
    public static double getTestTotalAmount(double total){
        
        if(total < 10) return 1.0;
        
        return round2Decimal(total/10.0);
    }
    
    
    /**
     * 
     * @param netTransStatus
     * @return 
     */
    public static String translateNetTransStatus(String netTransStatus){
    
        if(EnumTransactionStatus.authorizedPendingCapture.getValue().equals(netTransStatus)||
           EnumTransactionStatus.capturedPendingSettlement.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.refundPendingSettlement.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.approvedReview.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.underReview.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.FDSPendingReview.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.FDSAuthorizedPendingReview.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.inProgress.getValue().equals(netTransStatus)){
            
            return LiXiGlobalConstants.TRANS_STATUS_IN_PROGRESS;
            
        }
        
        if(EnumTransactionStatus.communicationError.getValue().equals(netTransStatus)||
           EnumTransactionStatus.declined.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.expired.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.generalError.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.failedReview.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.settlementError.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.returnedItem.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.voidedByUser.getValue().equals(netTransStatus) ||
           EnumTransactionStatus.voided.getValue().equals(netTransStatus)){
            
            return LiXiGlobalConstants.TRANS_STATUS_DECLINED;
            
        }
        
        if(EnumTransactionStatus.refundSettledSuccessfully.getValue().equals(netTransStatus)){
            
            return LiXiGlobalConstants.TRANS_STATUS_REFUNED;
            
        }
        
        if(EnumTransactionStatus.settledSuccessfully.getValue().equals(netTransStatus) || EnumTransactionStatus.couldNotVoid.getValue().equals(netTransStatus)){
            
            return LiXiGlobalConstants.TRANS_STATUS_PROCESSED;
            
        }
        
        return netTransStatus;
    
    }
    
    
    /**
     *
     * @param object
     * @return
     */
    public static <T> String marshal(T object) {
        try {
            StringWriter stringWriter = new StringWriter();
            JAXBContext context = JAXBContext.newInstance(object.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(object, stringWriter);
            //marshaller.marshal( new JAXBElement(new QName("uri","local"), object.getClass(), object ), stringWriter);
            return stringWriter.toString();
        } catch (JAXBException e) {
            //
            //log.info(e.getMessage(), e);
            //
            return (String.format("Exception while marshalling: %s", e.getMessage()));
        }
    }

    /**
     * 
     * @param <T>
     * @param object
     * @return 
     */
    public static <T> String marshalWithoutRootElement(T object) {
        try {
            StringWriter stringWriter = new StringWriter();
            JAXBContext context = JAXBContext.newInstance(object.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            //marshaller.marshal(object, stringWriter);
            marshaller.marshal( new JAXBElement(new QName("uri","local"), object.getClass(), object ), stringWriter);
            return stringWriter.toString();
        } catch (JAXBException e) {
            //
            //log.info(e.getMessage(), e);
            //
            return (String.format("Exception while marshalling: %s", e.getMessage()));
        }
    }
    
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
    
    /**
     * 
     * @param phone
     * @return 
     */
    public static String checkZeroAtBeginOfPhoneNumber(String phone){
        
        if(phone == null) return phone;
        
        if(!phone.startsWith("0")){
            
            return "0" + phone;
        }
        else{
            return phone;
        }
    }
    
    /**
     * 
     * @param rId
     * @return 
     */
    public static String getBeautyRId(Long rId){
        
        if(rId == null) return "";
        
        String r = rId.toString();
        
        r = StringUtils.leftPad(r, 8, "0");
        
        StringBuilder br = new StringBuilder();
        
        br.append(LiXiGlobalConstants.R);
        br.append(r);
        
        br.insert(4, '-');
        br.insert(7, '-');
        
        return br.toString();
    }
    
    /**
     * 
     * @param rId
     * @return 
     */
    public static String getBeautySId(Long rId){
        
        if(rId == null) return "";
        
        String r = rId.toString();
        
        r = StringUtils.leftPad(r, 8, "0");
        
        StringBuilder br = new StringBuilder();
        
        br.append(LiXiGlobalConstants.S);
        br.append(r);
        
        br.insert(4, '-');
        br.insert(7, '-');
        
        return br.toString();
    }
 
    /**
     *
     * @return
     */
    public static BankExchangeRate getVCBExchangeRates() {

        try {

            // get page: http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx
            Document doc = Jsoup.connect(LiXiGlobalConstants.VCB_EXCHANGE_RATES_PAGE)
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
