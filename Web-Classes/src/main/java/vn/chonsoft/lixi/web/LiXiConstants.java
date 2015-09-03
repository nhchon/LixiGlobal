/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web;

/**
 *
 * @author chonnh
 */
public abstract class LiXiConstants {
    
    public static final String SYSTEM_AUTO = "SYSTEM_AUTO";
    
    public static final int LIXI_ORDER_UNFINISHED = -2;
    public static final int LIXI_ORDER_NOT_YET_SUBMITTED = -1;
    public static final int LIXI_ORDER_SUBMITTED = 0;
    public static final int LIXI_ORDER_GIFT_NOT_SUBMITTED = -1;
    // FEE
    public static final String LIXI_HANDLING_FEE_TOTAL = "LIXI_HANDLING_FEE_TOTAL";
    public static final String LIXI_HANDLING_FEE = "LIXI_HANDLING_FEE";
    public static final String CARD_PROCESSING_FEE_THIRD_PARTY = "CARD_PROCESSING_FEE_THIRD_PARTY";
    public static final String LIXI_CARD_PROCESSING_FEE_ADD_ON = "LIXI_CARD_PROCESSING_FEE_ADD_ON";
    public static final String LIXI_ECHECK_FEE_GIFT_ONLY = "LIXI_ECHECK_FEE_GIFT_ONLY";
    public static final String LIXI_ECHECK_FEE_ALLOW_REFUND = "LIXI_ECHECK_FEE_ALLOW_REFUND";
    public static final String LIXI_FINAL_TOTAL = "LIXI_FINAL_TOTAL";
    
    public static final String VND = "VND";
    public static final String USD = "USD";
    public static final double VND_100K = 100000;
    public static final double VND_200K = 200000;
    public static final String EXCEEDED_VND = "EXCEEDED_VND";
    public static final String EXCEEDED_USD = "EXCEEDED_USD";
    public static final String CURRENT_PAYMENT = "CURRENT_PAYMENT";
    public static final String CURRENT_PAYMENT_VND = "CURRENT_PAYMENT_VND";
    public static final String CURRENT_PAYMENT_USD = "CURRENT_PAYMENT_USD";
    
    // current recipient
    public static final String SELECTED_RECIPIENT_ID = "SELECTED_RECIPIENT_ID";
    public static final String SELECTED_RECIPIENT_IDS = "SELECTED_RECIPIENT_IDS";
    public static final String SELECTED_RECIPIENT_NAME = "SELECTED_RECIPIENT_NAME";
    public static final String SELECTED_AMOUNT = "SELECTED_AMOUNT";
    public static final String SELECTED_AMOUNT_IN_VND = "SELECTED_AMOUNT_IN_VND";
    public static final String SELECTED_AMOUNT_CURRENCY = "SELECTED_AMOUNT_CURRENCY";
    public static final String SELECTED_LIXI_CATEGORY_ID = "SELECTED_LIXI_CATEGORY";
    public static final String SELECTED_LIXI_CATEGORY_NAME = "SELECTED_LIXI_CATEGORY_NAME";
    
    public static final String CURRENCIES = "CURRENCIES";
    public static final String LIXI_EXCHANGE_RATE = "LIXI_EXCHANGE_RATE";
    public static final String LIXI_CATEGORIES = "LIXI_CATEGORIES";
    public static final String LIXI_ORDERS = "LIXI_ORDERS";
    public static final String LIXI_ORDER = "LIXI_ORDER";
    public static final String LIXI_ORDER_ID = "LIXI_ORDER_ID";
    public static final String LIXI_ORDER_GIFT_ID = "LIXI_ORDER_GIFT_ID";
    public static final String LIXI_ORDER_GIFT_PRODUCT_ID = "LIXI_ORDER_GIFT_PRODUCT_ID";
    public static final String LIXI_ORDER_GIFT_PRODUCT_QUANTITY = "LIXI_ORDER_GIFT_PRODUCT_QUANTITY";
    public static final String REC_GIFTS = "REC_GIFTS";

    public static final String USER_LOGIN_ID = "USER_LOGIN_ID";
    public static final String USER_LOGIN_EMAIL = "USER_LOGIN_EMAIL";
    public static final String USER_LOGIN_FIRST_NAME = "USER_LOGIN_FIRST_NAME";
    public static final String USER_MAXIMUM_PAYMENT = "USER_MAXIMUM_PAYMENT";
    public static final String CURRENT_CARD = "CURRENT_CARD";
    public static final String CARD_TYPE_NAME = "CARD_TYPE_NAME";
    public static final String CARD_ENDING_WITH = "CARD_ENDING_WITH";
    public static final String BILLING_ADDRESS = "BILLING_ADDRESS";
    public static final String BILLING_ADDRESS_ES = "BILLING_ADDRESS_ES";
    public static final String CARD_ID = "CARD_ID";
    public static final String SELECTED_CARD_ID = "SELECTED_CARD_ID";
    public static final String CARDS = "CARDS";
    public static final String ACCOUNTS = "ACCOUNTS";
    public static final String PRODUCTS = "PRODUCTS";
    public static final String LIXI_TOTAL_AMOUNT = "LIXI_TOTAL_AMOUNT";
    
    public static final String YHANNART_GMAIL = "yhannart@gmail.com";
    
    public static final String WEB_INF_FOLDER = "WEB-INF";
    // folder that contains category icon
    public static final String CATEGORY_ICON_FOLDER = "uploads";
    public static final String NO_IMAGE_JPG = "no_image.jpg";
    
    public static final String ADMIN_USER_CHANGE_PASSWORD_PAGE = "/Administration/changePassword";
    //
    public static final String VCB_EXCHANGE_RATES_PAGE = "http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx";
    
    //
    public static final String BAOKIM_HOST = "kiemthu.baokim.vn";
    //
    public static final String BAOKIM_USERNAME = "test_only";
    //
    public static final String BAOKIM_PASSWORD = "1234";
    //
    public static final String BAOKIM_LIST_CATEGORY_PAGE = "http://kiemthu.baokim.vn/promotion/categories/list";
}
