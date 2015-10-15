/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
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
import org.apache.commons.lang3.text.WordUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import vn.chonsoft.lixi.model.BuyCard;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderGift;
import vn.chonsoft.lixi.model.Recipient;
import vn.chonsoft.lixi.model.TopUpMobilePhone;
import vn.chonsoft.lixi.model.pojo.BankExchangeRate;
import vn.chonsoft.lixi.model.pojo.Exrate;
import vn.chonsoft.lixi.model.pojo.RecipientInOrder;
import vn.chonsoft.lixi.model.pojo.SumVndUsd;
import vn.chonsoft.lixi.web.LiXiConstants;
import org.mozilla.universalchardet.UniversalDetector;
/**
 *
 * @author chonnh
 */
public class LiXiUtils {

    //
    private static final Logger log = LogManager.getLogger(LiXiUtils.class);

    // always use Locale.US for  number format
    private static DecimalFormat df = (DecimalFormat) NumberFormat.getNumberInstance(Locale.US);

    static {
        df.applyPattern("###,###.##");
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
            if (month < cmonth) {
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
     * @param price, in VND
     * @param quantity
     * @param exchange
     * @return
     */
    public static double roundPriceQuantity2USD(double price, int quantity, double exchange) {

        double rsl = ((price * quantity) / exchange) + (quantity * 0.005);

        return Math.round(rsl * 100.0) / 100.0;
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
        
        double totalVND = 0;
        double totalUSD = 0;
        //
        // get exchange rate
        double buy = order.getLxExchangeRate().getBuy();
        // gift type
        double sumGiftVND = 0;
        double sumGiftUSD = 0;
        if (order.getGifts() != null) {
            for (LixiOrderGift gift : order.getGifts()) {

                if (LiXiConstants.LIXI_GIFT_TYPE.equals(type) && gift.getId() == excludeId) {
                    // Nothing
                } else {
                    sumGiftVND += (gift.getProductPrice() * gift.getProductQuantity());
                    sumGiftUSD += (gift.getPriceInUSD(buy) * gift.getProductQuantity());
                }

            }
        }
        // plus to total
        totalVND += sumGiftVND;
        totalUSD += sumGiftUSD;
        
        // index 1
        returnAllSum[1] = new SumVndUsd(LiXiConstants.LIXI_GIFT_TYPE, sumGiftVND, sumGiftUSD);
        
        // top up mobile phone
        double sumTopUpVND = 0;
        double sumTopUpUSD = 0;
        if (order.getTopUpMobilePhones() != null) {
            for (TopUpMobilePhone topUp : order.getTopUpMobilePhones()) {

                if (LiXiConstants.LIXI_TOP_UP_TYPE.equals(type) && topUp.getId() == excludeId) {
                } else {
                    sumTopUpVND += (topUp.getAmount() * buy);
                    sumTopUpUSD += topUp.getAmount();
                }

            }
        }
        // plus to total
        totalVND += sumTopUpVND;
        totalUSD += sumTopUpUSD;
        // index 2
        returnAllSum[2] = new SumVndUsd(LiXiConstants.LIXI_TOP_UP_TYPE, sumGiftVND, sumGiftUSD);
        
        // buy phone card
        double sumBuyCardVND = 0;
        double sumBuyCardUSD = 0;
        if (order.getBuyCards() != null) {
            for (BuyCard card : order.getBuyCards()) {

                if (LiXiConstants.LIXI_PHONE_CARD_TYPE.equals(type) && card.getId() == excludeId) {
                    // nothing
                } else {
                    sumBuyCardVND += (card.getNumOfCard() * card.getValueOfCard());
                    sumBuyCardUSD += (card.getValueInUSD(buy) * card.getNumOfCard());
                }

            }
        }
        // plus to total
        totalVND += sumBuyCardVND;
        totalUSD += sumBuyCardUSD;
        
        // index 3
        returnAllSum[3] = new SumVndUsd(LiXiConstants.LIXI_PHONE_CARD_TYPE, sumGiftVND, sumGiftUSD);

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
     * @return
     */
    public static SumVndUsd[] calculateCurrentPayment(LixiOrder order) {

        return calculateCurrentPayment(order, -1);

    }

    /**
     *
     *
     * @param order
     * @return
     */
    public static List<RecipientInOrder> genMapRecGifts(LixiOrder order) {

        Map<Recipient, List<LixiOrderGift>> recGifts = new HashMap<>();
        Map<Recipient, List<BuyCard>> recPhoneCards = new HashMap<>();
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
        // phone card
        for (BuyCard phoneCard : order.getBuyCards()) {

            if (recPhoneCards.containsKey(phoneCard.getRecipient())) {

                recPhoneCards.get(phoneCard.getRecipient()).add(phoneCard);

            } else {

                List<BuyCard> phoneCards = new ArrayList<>();
                phoneCards.add(phoneCard);

                recPhoneCards.put(phoneCard.getRecipient(), phoneCards);
            }
            //
            recSet.add(phoneCard.getRecipient());
        }
        // create RecipientInOrder
        List<RecipientInOrder> recs = new ArrayList<>();
        for (Recipient rec : recSet) {

            RecipientInOrder recInOrder = new RecipientInOrder();
            recInOrder.setOrderId(order.getId());
            recInOrder.setRecipient(rec);

            if (recGifts.containsKey(rec)) {

                recInOrder.setGifts(recGifts.get(rec));

            }
            if (recPhoneCards.containsKey(rec)) {

                recInOrder.setBuyPhoneCards(recPhoneCards.get(rec));

            }
            if (recTopUps.containsKey(rec)) {

                recInOrder.setTopUpMobilePhones(recTopUps.get(rec));

            }
            //
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
     * @param bytes
     * @return 
     */
    public static String guessEncoding(byte[] bytes) {
        String DEFAULT_ENCODING = "UTF-8";
        UniversalDetector detector =
            new UniversalDetector(null);
        detector.handleData(bytes, 0, bytes.length);
        detector.dataEnd();
        String encoding = detector.getDetectedCharset();
        detector.reset();
        if (encoding == null) {
            encoding = DEFAULT_ENCODING;
        }
        return encoding;
    }
    
    /**
     * the system is set default encode iso-8859-1 Convert to UTF-8
     *
     * @param str
     * @return
     */
    public static String fixEncode(String str) {

        if (str == null || "".equals(str)) {
            return str;
        }
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
