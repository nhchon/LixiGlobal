/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.text.WordUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import vn.chonsoft.lixi.model.BuyPhoneCard;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.pojo.BankExchangeRate;
import vn.chonsoft.lixi.model.pojo.Exrate;
import vn.chonsoft.lixi.web.LiXiConstants;

/**
 *
 * @author chonnh
 */
public abstract class LiXiUtils {

    //
    private static final Logger log = LogManager.getLogger(LiXiUtils.class);

    // always use Locale.US for  number format
    private static DecimalFormat df = (DecimalFormat)NumberFormat.getNumberInstance(Locale.US);
    static{
        df.applyPattern("###,###.##");
    }
    /**
     * 
     * Check user is loggined or not
     * 
     * @param request
     * @return 
     */
    public static boolean isLoggined(HttpServletRequest request){
        
        return request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL) != null;
        
    }
    
    /**
     * 
     * fix encode and capitalize fully
     * 
     * @param name
     * @return 
     */
    public static String correctName(String name){
        
        return WordUtils.capitalizeFully(fixEncode(name));
        
    }
    /**
     * 
     * @param month
     * @param year
     * @return 
     */
    public static boolean checkMonthYearGreaterThanCurrent(int month, int year){
        
        Calendar cal = Calendar.getInstance();
        int cyear = cal.get(cal.YEAR);
        int cmonth = cal.get(cal.MONTH)+1; //zero-based
        
        if(year < cyear){
            return false;
        }
        else{
            if(month < cmonth)
                return false;
        }
        //
        return true;
    }
    /**
     * 
     * @return 
     */
    public static DecimalFormat getNumberFormat(){
        return df;
    }
    
    /**
     * 
     * @param alreadyGift
     * @return 
     */
    public static Long getOrderGiftId(LixiOrderGift alreadyGift){
        
        if(alreadyGift == null) return -1L;
        else
            return alreadyGift.getId();
    }

    /**
     * 
     * Calculate total money, in VND, exclude specific id of the type of gift (gift,top up, card)
     * 
     * @param order
     * @param excludeId
     * @param type
     * @return 
     */
    public static double calculateCurrentPayment(LixiOrder order, long excludeId, String type){
        
        if(order == null) return 0;
        
        double sum = 0;
        // gift type
        if(order.getGifts() != null){
            for(LixiOrderGift gift : order.getGifts()){

                if(LiXiConstants.LIXI_GIFT_TYPE.equals(type) && gift.getId() == excludeId){
                    // Nothing
                }
                else{
                    sum += (gift.getProductPrice() * gift.getProductQuantity());
                }

            }
        }
        // get exchange rate
        double buy = order.getLxExchangeRate().getBuy();
        
        // top up mobile phone
        if(order.getTopUpMobilePhones() != null){
            for(TopUpMobilePhone topUp : order.getTopUpMobilePhones()){

                if(LiXiConstants.LIXI_TOP_UP_TYPE.equals(type) && topUp.getId() == excludeId){
                }
                else{
                    sum += (topUp.getAmount() * buy);
                }

            }
        }
        // buy phone card
        if(order.getBuyPhoneCards() != null){
            for(BuyPhoneCard card : order.getBuyPhoneCards()){

                if(LiXiConstants.LIXI_PHONE_CARD_TYPE.equals(type) && card.getId() == excludeId){
                    // nothing
                }
                else{
                    sum += (card.getNumOfCard() * card.getValueOfCard());
                }

            }
        }
        // return total
        return sum;
                
    }
    
    /**
     * 
     * sum order, in VND
     * 
     * @param order
     * @param excludeOrderGift Exclude this order gift id
     * @return 
     */
    public static double calculateCurrentPayment(LixiOrder order, long excludeOrderGift){
        
        return calculateCurrentPayment(order, excludeOrderGift, LiXiConstants.LIXI_GIFT_TYPE);
                
    }
    
    /**
     * 
     * @param order
     * @return 
     */
    public static double calculateCurrentPayment(LixiOrder order){
        
        return calculateCurrentPayment(order, -1);
                
    }
    /**
     * 
     * 
     * @param order
     * @return 
     */
    public static Map<Recipient, List<LixiOrderGift>> genMapRecGifts(LixiOrder order){
        
        Map<Recipient, List<LixiOrderGift>> recGifts = new HashMap<>();
        
        for(LixiOrderGift lxogift : order.getGifts()){
            
            if(recGifts.containsKey(lxogift.getRecipient())){
                
                recGifts.get(lxogift.getRecipient()).add(lxogift);
                
            }
            else{
                
                List<LixiOrderGift> gifts = new ArrayList<>();
                gifts.add(lxogift);
                
                recGifts.put(lxogift.getRecipient(), gifts);
            }
        }
        
        return recGifts;
    }
    /**
     * 
     * @param amountCode
     * @param amount
     * @param giftInValue
     * @return 
     */
    public static String getAmountInVnd(String amountCode, String amount, String giftInValue){
        
        return LiXiConstants.VND.equals(amountCode)?amount:giftInValue;
        
    }
    
    /**
     * 
     * remove part ":8080" in path, but not "localhost:8080"
     * 
     * @param path
     * @return 
     */
    public static String remove8080(String path){
        
        if(path == null || "".equals(path) || path.contains("localhost:8080"))
            return path;
        
        return path.replaceFirst(":8080", "");
    }
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
