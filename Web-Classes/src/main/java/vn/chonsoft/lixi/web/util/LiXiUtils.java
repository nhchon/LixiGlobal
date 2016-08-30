/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.StringWriter;
import java.net.URI;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.namespace.QName;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.text.WordUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jsoup.Jsoup;
import vn.chonsoft.lixi.model.BillingAddress;
import vn.chonsoft.lixi.model.BuyCard;
import vn.chonsoft.lixi.model.LixiConfig;
import vn.chonsoft.lixi.model.LixiGlobalFee;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderCard;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.model.VatgiaProduct;
import vn.chonsoft.lixi.EnumLixiOrderSetting;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.ShippingCharged;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.pojo.CashRun;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.beans.LoginedUser;
/**
 *
 * @author chonnh
 */
public class LiXiUtils {

    //
    private static final Logger log = LogManager.getLogger(LiXiUtils.class);

    // always use Locale.US for  number format
    private final static DecimalFormat df = (DecimalFormat) NumberFormat.getNumberInstance(Locale.US);

    static {
        df.applyPattern("###,###.##");
    }
    
    /**
     * 
     * Prevent urls as https://www.google.com/gifts/detail/1517
     * 
     * @param uri
     * @return 
     */
    public static String getPathOfNextUrl(String uri){
        
        if(StringUtils.isBlank(uri)){
            return "/";
        }
        
        try {
            // remove html
            uri = Jsoup.parse(uri).text();
            
            URI url = new URI(uri);
            
            String path = url.getPath();
            
            if(StringUtils.isBlank(path))
                return "/";
            
            String query = url.getQuery();
            
            if(StringUtils.isBlank(query))
                return path;
            else
                return path + "?" + query;
            
        } catch (Exception e) {
            return "/";
        }
    }
    /**
     * 
     * @param value
     * @return 
     */
    public static double getBaoKimPercent(String value){
        
        double percent = LiXiGlobalConstants.LIXI_BAOKIM_DEFAULT_PERCENT;
        try {
            percent = Double.parseDouble(value);
        } catch (Exception e) {}
        
        return percent;
    }
    
    /**
     * 
     * @param mm
     * @param yy
     * @return 
     */
    public static String getCardExpiryDateMMYY(int mm, int yy){
        String expireMonth = StringUtils.leftPad(mm + "", 2, "0");
        String expireYear = "";
        //4 digits
        if(yy > 999){
            expireYear = StringUtils.left(yy+"", 2);
        }
        else{
            expireYear = StringUtils.leftPad(yy + "", 2, "0");
        }
        
        return expireMonth + expireYear;
    }
    /**
     * 
     * @param result
     * @return 
     */
    public static CashRun parseCashRunResult(String result){
        
        log.info("cash run result: " + result);
        try {
            ObjectMapper mapper = new ObjectMapper();
            mapper.configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true); 
            CashRun cashRun = mapper.readValue(result, CashRun.class);
            
            return cashRun;
        } catch (Exception e) {
            
            log.info("parse cash run: ", e);
        }
        
        return null;
    }
    
    public static String getPaymentMethod4CashRun(int card){
        switch(card){
            case 2:
                return "Mastercard";
            case 3:
                return "Discover";
            default:
                return "Visa";
        }
    }
    
    public static void setLoginedUser(LoginedUser l, User u, List<LixiConfig> configs){
    
        l.setId(u.getId());
        l.setFirstName(u.getFirstName());
        l.setMiddleName(u.getMiddleName());
        l.setLastName(u.getLastName());
        l.setEmail(u.getEmail());
        l.setPhone(u.getPhone());
        l.setAccountNonExpired(u.getAccountNonExpired());
        l.setAccountNonLocked(u.getAccountNonLocked());
        l.setCredentialsNonExpired(u.getCredentialsNonExpired());
        l.setEnabled(u.getEnabled());
        l.setActivated(u.getActivated());
        // login date
        l.setLoginedDate(Calendar.getInstance().getTime());
        
        setConfigsLoginedUser(l, configs);
        
    }
    
    /**
     * 
     * @param l
     * @param configs 
     */
    public static void setConfigsLoginedUser(LoginedUser l, List<LixiConfig> configs){
    
        configs.forEach(c -> {l.addConfig(c.getName(), c.getValue());});
    }
    
    /**
     *
     * Check user is loggined or not
     *
     * @param request
     * @return
     */
    public static boolean isLoggined(HttpServletRequest request) {

        return request.getSession().getAttribute(LiXiConstants.USER_LOGIN_EMAIL) != null;

    }

    /**
     * 
     * @param card
     * @return 
     */
    public static LixiOrderCard toLxOrderCard(UserCard card){
        
        if(card == null)
            return null;
        //
        LixiOrderCard c = new LixiOrderCard();
        c.setId(card.getId());
        c.setUserId(card.getUser().getId());
        c.setAuthorizePaymentId(card.getAuthorizePaymentId());
        c.setCardType(card.getCardType());
        c.setCardName(card.getCardName());
        c.setCardBin(card.getCardBin());
        c.setCardNumber(card.getCardNumber());
        c.setExpMonth(card.getExpMonth());
        c.setExpYear(card.getExpYear());
        c.setCardCvv(card.getCardCvv());
        c.setModifiedDate(card.getModifiedDate());
        c.setBillingAddress(card.getBillingAddress());
        
        return c;
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
            log.info(e.getMessage(), e);
            //
            return (String.format("Exception while marshalling: %s", e.getMessage()));
        }
    }

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
            log.info(e.getMessage(), e);
            //
            return (String.format("Exception while marshalling: %s", e.getMessage()));
        }
    }
    
    /**
     *
     * fix encode and capitalize fully
     *
     * @param name
     * @return
     */
    public static String correctName(String name) {

        return WordUtils.capitalizeFully(name);

    }

    /**
     *
     * @param month
     * @param year
     * @return
     */
    public static boolean checkMonthYearGreaterThanCurrent(int month, int year) {

        Calendar cal = Calendar.getInstance();
        int cyear = cal.get(cal.YEAR);
        int cmonth = cal.get(cal.MONTH) + 1; //zero-based

        if (year < cyear) {
            return false;
        } else {
            if ((year == cyear) && (month < cmonth)) {
                return false;
            }
        }
        //
        return true;
    }

    /**
     *
     * @return
     */
    public static DecimalFormat getNumberFormat() {
        return df;
    }

    /**
     *
     * @param alreadyGift
     * @return
     */
    public static Long getOrderGiftId(LixiOrderGift alreadyGift) {

        if (alreadyGift == null) {
            return -1L;
        } else {
            return alreadyGift.getId();
        }
    }

    public static double round(double a) {

        return Math.round((a + 0.005) * 100.0) / 100.0;
    }

    /**
     * 
     * @param vnd
     * @param exchange
     * @return 
     */
    public static double toUsdPrice(double vnd, double exchange){
        
        double inUsd = vnd/exchange +0.005;
        
        return Math.round(inUsd * 100.0) / 100.0;
        
    }

    /**
     * 
     * @param order
     * @return 
     */
    public static SumVndUsd getTotalOrder(LixiOrder order) {
        return calculateCurrentPayment(order)[0];
    }
    
    /**
     * 
     * @param order
     * @return 
     */
    public static BillingAddress getBillingAddress(LixiOrder order){
        
        /* get billing address */
        if(order.getCard() != null){
            return order.getCard().getBillingAddress();
        }
        
        if(order.getBankAccount() != null) 
            return order.getBankAccount().getBillingAddress();
        
        return null;
    }
    /**
     * 
     * @param model
     * @param order 
     * @param fees
     */
    public static void calculateFee(Map<String, Object> model, LixiOrder order, List<LixiGlobalFee> fees, List<ShippingCharged> charged){
        
        /* get billing address */
        //BillingAddress bl = null;
        int paymentMethod = 0;// for Visa Card
        if(order.getBankAccount()!=null){
            paymentMethod = 1;// for Bank Account
        }
        
        double buy = order.getLxExchangeRate().getBuy();
        
        /* get lixi global fee */
        //List<LixiGlobalFee> fees = this.feeService.findByCountry(this.countryService.findByCode(bl.getCountry()));
        
        //log.info("fees.length : " + fees.size());
        
        List<RecipientInOrder> recGifts = LiXiUtils.genMapRecGifts(order);
        recGifts.forEach(r -> {r.setCharged(charged);});
        
        model.put(LiXiConstants.LIXI_ORDER, order);
        model.put(LiXiConstants.REC_GIFTS, recGifts);
        Long recId = (Long)model.get(LiXiConstants.SELECTED_RECIPIENT_ID);
        double totalShippingCharge = 0;
        for(RecipientInOrder r : recGifts){
            if(recId != null && recId.longValue() == r.getRecipient().getId()){
                SumVndUsd rTotal = r.getAllTotal();
                model.put(LiXiConstants.RECIPIENT_TOTAL_INC_SHIPPING_USD, rTotal.getUsd() + r.getShippingChargeAmount());
                model.put(LiXiConstants.RECIPIENT_TOTAL_INC_SHIPPING_VND, rTotal.getVnd() + (r.getShippingChargeAmount() * buy));
                model.put(LiXiConstants.RECIPIENT_SHIPPING_CHARGED, r.getShippingChargeAmount());
            }
            totalShippingCharge += r.getShippingChargeAmount();
        }
        model.put(LiXiConstants.TOTAL_SHIPPING_CHARGED, totalShippingCharge);
        model.put(LiXiConstants.TOTAL_SHIPPING_CHARGED_VND, LiXiGlobalUtils.round2Decimal(totalShippingCharge * buy));
        
        // calculate the total
        double finalTotal = 0;
        SumVndUsd[] totals = LiXiUtils.calculateCurrentPayment(order);
        double giftPrice = totals[0].getUsd();//usd
        double giftPriceVnd = totals[0].getVnd();

        //log.info("gift price : " + giftPrice);
        /* get lixi fee */
        LixiGlobalFee fee = LiXiUtils.getLixiGlobalFee(fees, paymentMethod, LiXiGlobalUtils.round2Decimal(giftPrice));
        
        //log.info("LixiGlobalFee == null:" + (fee == null));
        
        /* calculate card fee */
        double cardFee = 0.0;
        double feePercent = 0;
        if(fee != null){
            if (order.getSetting() == EnumLixiOrderSetting.ALLOW_REFUND.getValue()) {
                feePercent = fee.getAllowRefundFee();
            }
            else{
                feePercent = fee.getGiftOnlyFee();
            }
        }
        //log.info("feePercent: " + feePercent);
        
        cardFee = LiXiGlobalUtils.round2Decimal((feePercent * (giftPrice + totalShippingCharge))/100.0);
        if((fee != null) && (fee.getMaxFee() > 0) && (cardFee > fee.getMaxFee())){
            cardFee = fee.getMaxFee();
        }
        
        /* lixi handling fee */
        double lixiFee = 0.99;
        if(fee != null){
            lixiFee = fee.getLixiFee() * (recGifts.isEmpty() ? 0 : recGifts.size());
        }
        // final total 
        finalTotal = giftPrice + cardFee + lixiFee;

        model.put(LiXiConstants.LIXI_GIFT_PRICE, LiXiGlobalUtils.round2Decimal(giftPrice));
        model.put(LiXiConstants.LIXI_GIFT_PRICE_VND, giftPriceVnd);
        model.put(LiXiConstants.LIXI_FINAL_TOTAL, LiXiGlobalUtils.round2Decimal(finalTotal + totalShippingCharge));
        model.put(LiXiConstants.LIXI_FINAL_TOTAL_VND, LiXiGlobalUtils.round2Decimal(buy * (finalTotal+totalShippingCharge)));
        model.put(LiXiConstants.LIXI_HANDLING_FEE, (fee!=null?fee.getLixiFee():0.99));
        model.put(LiXiConstants.LIXI_HANDLING_FEE_TOTAL, LiXiGlobalUtils.round2Decimal(lixiFee));
        model.put(LiXiConstants.CARD_PROCESSING_FEE_THIRD_PARTY, cardFee);
        
    }
    
    /**
     *
     * Calculate total money, in VND, exclude specific id of the type of gift
     * (gift,top up, card)
     *
     * @param order
     * @param excludeId
     * @param type
     * @return
     */
    public static SumVndUsd[] calculateCurrentPayment(LixiOrder order, long excludeId, String type) {

        SumVndUsd[] returnAllSum = new SumVndUsd[]{new SumVndUsd(), new SumVndUsd(), new SumVndUsd(), new SumVndUsd()};
        if (order == null) {
            return returnAllSum;
        }
        /* */
        double buy = order.getLxExchangeRate().getBuy();
        
        double totalUSD = 0;
        double totalVND = 0;
        // gift type
        double sumGiftUSD = 0;
        double sumGiftVND = 0;
        if (order.getGifts() != null) {
            for (LixiOrderGift gift : order.getGifts()) {

                if (LiXiConstants.LIXI_GIFT_TYPE.equals(type) && gift.getId() == excludeId) {
                    // Nothing
                } else {
                    sumGiftVND += (gift.getProductPrice() * gift.getProductQuantity());
                    sumGiftUSD += (gift.getUsdPrice() * gift.getProductQuantity());
                    /* round up */
                    sumGiftUSD = Math.round(sumGiftUSD * 100.0) / 100.0;
                    sumGiftVND = Math.round(sumGiftVND * 100.0) / 100.0;
                }

            }
        }
        // plus to total
        totalUSD += sumGiftUSD;
        totalVND += sumGiftVND;
        // index 1
        returnAllSum[1] = new SumVndUsd(LiXiConstants.LIXI_GIFT_TYPE, sumGiftVND, sumGiftUSD);
        
        // top up mobile phone
        double sumTopUpUSD = 0;
        double sumTopUpVND = 0;
        if (order.getTopUpMobilePhones() != null) {
            for (TopUpMobilePhone topUp : order.getTopUpMobilePhones()) {

                if (LiXiConstants.LIXI_TOP_UP_TYPE.equals(type) && topUp.getId() == excludeId) {
                } else {
                    sumTopUpUSD += topUp.getAmountUsd();
                    sumTopUpVND += topUp.getAmount();
                }

            }
        }
        // plus to total
        totalUSD += sumTopUpUSD;
        totalVND += sumTopUpVND;
        
        // index 2
        returnAllSum[2] = new SumVndUsd(LiXiConstants.LIXI_TOP_UP_TYPE, sumTopUpVND, sumTopUpUSD);
        
        // buy phone card
        double sumBuyCardUSD = 0;
        if (order.getBuyCards() != null) {
            for (BuyCard card : order.getBuyCards()) {

                if (LiXiConstants.LIXI_PHONE_CARD_TYPE.equals(type) && card.getId() == excludeId) {
                    // nothing
                } else {
                    sumBuyCardUSD += (card.getValueInUSD(buy) * card.getNumOfCard());
                    /* round up */
                    sumBuyCardUSD = Math.round(sumBuyCardUSD * 100.0) / 100.0;
                }

            }
        }
        // plus to total
        totalUSD += sumBuyCardUSD;
        totalVND += sumBuyCardUSD * buy;
        // index 3
        returnAllSum[3] = new SumVndUsd(LiXiConstants.LIXI_PHONE_CARD_TYPE, sumBuyCardUSD * buy, sumBuyCardUSD);

        // index 0
        returnAllSum[0] = new SumVndUsd(LiXiConstants.TOTAL_ALL_TYPE, totalVND, totalUSD);
        
        // return total
        return returnAllSum;

    }

    /**
     *
     * sum order, in VND
     *
     * @param order
     * @param excludeOrderGift Exclude this order gift id
     * @return
     */
    public static SumVndUsd[] calculateCurrentPayment(LixiOrder order, long excludeOrderGift) {

        return calculateCurrentPayment(order, excludeOrderGift, LiXiConstants.LIXI_GIFT_TYPE);

    }

    /**
     * 
     * @param order
     * @param alreadyGift
     * @return 
     */
    public static SumVndUsd[] calculateCurrentPayment(LixiOrder order, LixiOrderGift alreadyGift) {

        if(alreadyGift != null){
            return calculateCurrentPayment(order, alreadyGift.getId(), LiXiConstants.LIXI_GIFT_TYPE);
        }
        /* */
        return calculateCurrentPayment(order, -1);
    }

    /**
     *
     * @param order
     * @return
     */
    public static SumVndUsd[] calculateCurrentPayment(LixiOrder order) {

        return calculateCurrentPayment(order, -1);

    }

    public static LixiGlobalFee getLixiGlobalFee(List<LixiGlobalFee> fees, int method, double totalCost){
       
        //log.info("fees: " + fees.size());
        //log.info("method: " + method);
        //log.info("totalCost: " + totalCost);
        
        for(LixiGlobalFee fee : fees){
            if((fee.getPaymentMethod() == method) && (totalCost <= fee.getAmount())) return fee;
        }
        
        return null;
    }
    /**
     * 
     * @param recGifts
     * @param recId
     * @return 
     */
    public static RecipientInOrder getRecipientInOrder(List<RecipientInOrder> recGifts, Long recId){
        
        for(RecipientInOrder rec : recGifts){
            if(rec.getRecipient().getId().longValue() == recId)
                return rec;
        }
        
        /**/
        return null;
    }
    /**
     *
     *
     * @param order
     * @return
     */
    public static List<RecipientInOrder> genMapRecGifts(LixiOrder order) {
        
        return genMapRecGifts(order, LiXiGlobalConstants.LIXI_BAOKIM_DEFAULT_PERCENT);
    }

    /**
     * 
     * @param order
     * @param baoKimTransferPercent
     * @return 
     */
    public static List<RecipientInOrder> genMapRecGifts(LixiOrder order, double baoKimTransferPercent) {
        
        if(order == null) return null;
        
        Map<Recipient, List<LixiOrderGift>> recGifts = new HashMap<>();
        //Map<Recipient, List<BuyCard>> recPhoneCards = new HashMap<>();
        Map<Recipient, List<TopUpMobilePhone>> recTopUps = new HashMap<>();

        Set<Recipient> recSet = new HashSet<>();
        List<RecipientInOrder> listRecInOrder = new ArrayList<>();
        // gifts
        for (LixiOrderGift lxogift : order.getGifts()) {

            if (recGifts.containsKey(lxogift.getRecipient())) {

                recGifts.get(lxogift.getRecipient()).add(lxogift);

            } else {

                List<LixiOrderGift> gifts = new ArrayList<>();
                gifts.add(lxogift);

                recGifts.put(lxogift.getRecipient(), gifts);
            }
            //
            recSet.add(lxogift.getRecipient());
        }
        // top up
        for (TopUpMobilePhone topUp : order.getTopUpMobilePhones()) {

            if (recTopUps.containsKey(topUp.getRecipient())) {

                recTopUps.get(topUp.getRecipient()).add(topUp);

            } else {

                List<TopUpMobilePhone> topUps = new ArrayList<>();
                topUps.add(topUp);

                recTopUps.put(topUp.getRecipient(), topUps);
            }
            //
            recSet.add(topUp.getRecipient());
        }
        // create RecipientInOrder
        List<RecipientInOrder> recs = new ArrayList<>();
        for (Recipient rec : recSet) {

            RecipientInOrder recInOrder = new RecipientInOrder();
            recInOrder.setOrderId(order.getId());
            recInOrder.setOrderSetting(order.getSetting());
            recInOrder.setBaoKimTransferPercent(baoKimTransferPercent);
            recInOrder.setLxExchangeRate(order.getLxExchangeRate());
            recInOrder.setRecipient(rec);

            if (recGifts.containsKey(rec)) {

                recInOrder.setGifts(recGifts.get(rec));

            }
            
            //if (recPhoneCards.containsKey(rec)) {

                //recInOrder.setBuyPhoneCards(recPhoneCards.get(rec));

            //}
            
            if (recTopUps.containsKey(rec)) {

                recInOrder.setTopUpMobilePhones(recTopUps.get(rec));

            }
            /* */
            recInOrder.getAllTotal();
            
            recs.add(recInOrder);
        }
        listRecInOrder.addAll(recs);
        return listRecInOrder;
    }
    /**
     *
     * @param amountCode
     * @param amount
     * @param giftInValue
     * @return
     */
    public static String getAmountInVnd(String amountCode, String amount, String giftInValue) {

        return LiXiConstants.VND.equals(amountCode) ? amount : giftInValue;

    }

    /**
     * 
     * @param id
     * @return 
     */
    public static String getBeautyOrderId(Long id){
        
        String newId = id.toString();
        
        newId = StringUtils.leftPad(newId, 9, '0');
        
        StringBuilder idBuffer = new StringBuilder();
        
        for(int i=0; i< newId.length();i++){
            idBuffer.append(newId.charAt(i));
            if(((i+1)%3) == 0 && ((i+1)<newId.length()))
                idBuffer.append('-');
        }
        
        return idBuffer.toString();
    }
    /**
     *
     * remove part ":8080" in path, but not "localhost:8080"
     *
     * @param path
     * @return
     */
    public static String remove8080(String path) {

        if (path == null || "".equals(path) || path.contains("localhost:8080")) {
            return path;
        }

        return path.replaceFirst(":8080", "");
    }

    /**
     * 
     * @param path
     * @return 
     */
    public static String replaceHttp8080(String path){
        
        if (path == null || "".equals(path) || path.contains("localhost")) {
            return path;
        }

        return path.replaceFirst("http://", "https://").replaceFirst(":8080", "");
    }
    /**
     * 
     * check if the product is already selected in current order
     * 
     * @param products
     * @param order 
     */
    public static void checkSelected(List<VatgiaProduct> products, LixiOrder order, Recipient rec){
        
        if(rec == null) return;
        if(order == null) return;
        if(order.getGifts() == null || order.getGifts().isEmpty())
            return;
        
        //
        for(VatgiaProduct p : products){
            /* default quantity */
            p.setQuantity(1);
            /* */
            for(LixiOrderGift gift : order.getGifts()){
                if(gift.getRecipient().equals(rec) && p.getId().intValue() == gift.getProductId()){
                    p.setSelected(Boolean.TRUE);
                    p.setQuantity(gift.getProductQuantity());
                    break;
                }
            }
        }
    }
    

}
