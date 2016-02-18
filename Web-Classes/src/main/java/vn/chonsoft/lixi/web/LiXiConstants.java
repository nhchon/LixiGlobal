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
    
    /* Category Code */
    public static final String CAT_FLOWER = "FLOWER";
    public static final String CAT_COSMETICS = "COSMETICS";
    public static final String CAT_PERFUME = "PERFUME";
    public static final String CAT_CHILDREN_TOY = "CHILDREN_TOY";
    public static final String CAT_JEWELRIES = "JEWELRIES";
    public static final String CAT_CANDIES = "CANDIES";
    
    ////////////////////////////////////////////////////////////////////////////
    public static final String SYSTEM_AUTO = "SYSTEM_AUTO";
    public static final String OK = "OK";
    public static final String YES = "YES";
    public static final String NO = "NO";
    public static final String LG = "LG";
    
    public static final String VTC_OK = "1";
    public static final String VTC_AUTO = "VTC_AUTO";
    public static final String LIXI_GLOBAL_TOP_UP_CODE = "LG-TU-";
    public static final String LIXI_GLOBAL_BUY_CARD_CODE = "LG-BC-";
    
    public static final String LIXI_IN_USE_EMAIL = "LIXI_IN_USE_EMAIL";
    
    public static final String LIXI_IN_USE_EMAIL_SECRET_CODE = "LIXI_IN_USE_EMAIL_SECRET_CODE";
    
    public static final int LIXI_NON_ACTIVATED = 0;
    public static final int LIXI_ACTIVATED = 1;
    
    //public static final int LIXI_ORDER_UNFINISHED = -2;
    //public static final int LIXI_ORDER_NOT_YET_SUBMITTED = -1;
    //public static final int LIXI_ORDER_SUBMITTED = 0;
    //public static final String LIXI_ORDER_GIFT_NOT_SUBMITTED = "-1";
    // TYPE
    public static final String TOTAL_ALL_TYPE = "TOTAL_ALL_TYPE";
    public static final String LIXI_GIFT_TYPE = "LIXI_GIFT_TYPE";
    public static final String LIXI_TOP_UP_TYPE = "LIXI_TOP_UP_TYPE";
    public static final String LIXI_PHONE_CARD_TYPE = "LIXI_PHONE_CARD_TYPE";
    //
    public static final String KEEP_SHOPPING_ACTION = "KEEP_SHOPPING_ACTION";
    public static final String BUY_NOW_ACTION = "BUY_NOW_ACTION";
    // MOBILE TOP UP
    public static final String PHONE_COMPANIES = "PHONE_COMPANIES";
    public static final String TOP_UP_IN_VND = "TOP_UP_IN_VND";
    public static final String TOP_UP_IN_USD = "TOP_UP_IN_USD";
    public static final String TOP_UP_AMOUNT = "TOP_UP_AMOUNT";
    public static final String NUM_OF_CARD = "NUM_OF_CARD";
    public static final String VALUE_OF_CARD = "VALUE_OF_CARD";
    public static final String BUY_PHONE_CARD_IN_VND = "BUY_PHONE_CARD_IN_VND";
    public static final String BUY_PHONE_CARD_IN_USD = "BUY_PHONE_CARD_IN_USD";
    public static final String NAP_TIEN_TRA_TRUOC = "NAP_TIEN_TRA_TRUOC";
    public static final String MUA_LAY_THE_CAO = "MUA_LAY_THE_CAO";
    // FEE
    public static final String LIXI_HANDLING_FEE_TOTAL = "LIXI_HANDLING_FEE_TOTAL";
    public static final String LIXI_HANDLING_FEE = "LIXI_HANDLING_FEE";
    public static final String CARD_PROCESSING_FEE_THIRD_PARTY = "CARD_PROCESSING_FEE_THIRD_PARTY";
    public static final String LIXI_CARD_PROCESSING_FEE_ADD_ON = "LIXI_CARD_PROCESSING_FEE_ADD_ON";
    public static final String LIXI_ECHECK_FEE_GIFT_ONLY = "LIXI_ECHECK_FEE_GIFT_ONLY";
    public static final String LIXI_ECHECK_FEE_ALLOW_REFUND = "LIXI_ECHECK_FEE_ALLOW_REFUND";
    public static final String LIXI_GIFT_PRICE = "LIXI_GIFT_PRICE";
    public static final String LIXI_GIFT_PRICE_VND = "LIXI_GIFT_PRICE_VND";
    public static final String LIXI_FINAL_TOTAL = "LIXI_FINAL_TOTAL";
    public static final String LIXI_FINAL_TOTAL_VND = "LIXI_FINAL_TOTAL_VND";
    public static final String LIXI_ALL_TOTAL = "LIXI_ALL_TOTAL";
    
    public static final String VND = "VND";
    public static final String USD = "USD";
    public static final double VND_100K = 100000;
    public static final double VND_200K = 200000;
    public static final double MINIMUM_PRICE_USD = 10.0;
    public static final String EXCEEDED_VND = "EXCEEDED_VND";
    public static final String EXCEEDED_USD = "EXCEEDED_USD";
    public static final String CURRENT_PAYMENT = "CURRENT_PAYMENT";
    public static final String CURRENT_PAYMENT_VND = "CURRENT_PAYMENT_VND";
    public static final String CURRENT_PAYMENT_USD = "CURRENT_PAYMENT_USD";
    
    // current recipient
    public static final String RECIPIENTS = "RECIPIENTS";
    public static final String SELECTED_RECIPIENT = "SELECTED_RECIPIENT";
    public static final String SELECTED_RECIPIENT_ID = "SELECTED_RECIPIENT_ID";
    public static final String SELECTED_RECIPIENT_IDS = "SELECTED_RECIPIENT_IDS";
    public static final String SELECTED_RECIPIENT_NAME = "SELECTED_RECIPIENT_NAME";
    public static final String SELECTED_RECIPIENT_FIRST_NAME = "SELECTED_RECIPIENT_FIRST_NAME";
    public static final String SELECTED_AMOUNT = "SELECTED_AMOUNT";
    public static final String SELECTED_AMOUNT_IN_VND = "SELECTED_AMOUNT_IN_VND";
    public static final String SELECTED_AMOUNT_IN_USD = "SELECTED_AMOUNT_IN_USD";
    public static final String SELECTED_AMOUNT_CURRENCY = "SELECTED_AMOUNT_CURRENCY";
    public static final String SELECTED_LIXI_CATEGORY_ID = "SELECTED_LIXI_CATEGORY_ID";
    public static final String SELECTED_LIXI_CATEGORY_NAME = "SELECTED_LIXI_CATEGORY_NAME";
    public static final String SELECTED_PRODUCT_ID = "SELECTED_PRODUCT_ID";
    public static final String SELECTED_PRODUCT_QUANTITY = "SELECTED_PRODUCT_QUANTITY";
    public static final String RECIPIENT_IN_ORDER = "RECIPIENT_IN_ORDER";
    
    public static final String CURRENCIES = "CURRENCIES";
    public static final String LIXI_EXCHANGE_RATE = "LIXI_EXCHANGE_RATE";
    public static final String LIXI_EXCHANGE_RATE_ID = "LIXI_EXCHANGE_RATE_ID";
    public static final String LIXI_CATEGORIES = "LIXI_CATEGORIES";
    public static final String LIXI_ORDERS = "LIXI_ORDERS";
    public static final String LIXI_ORDER = "LIXI_ORDER";
    public static final String LIXI_ORDER_ID = "LIXI_ORDER_ID";
    public static final String LIXI_ORDER_GIFT_ID = "LIXI_ORDER_GIFT_ID";
    public static final String LIXI_ORDER_GIFT_PRODUCT_ID = "LIXI_ORDER_GIFT_PRODUCT_ID";
    public static final String LIXI_ORDER_GIFT_PRODUCT_QUANTITY = "LIXI_ORDER_GIFT_PRODUCT_QUANTITY";
    public static final String REC_GIFTS = "REC_GIFTS";

    public static final String LOGINED_USER = "LOGINED_USER";
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
    public static final String PAGES = "PAGES";
    public static final Integer NUM_PRODUCTS_PER_PAGE = 10;
    public static final String LIXI_TOTAL_AMOUNT = "LIXI_TOTAL_AMOUNT";
    
    public static final String WEB_INF_FOLDER = "WEB-INF";
    // folder that contains category icon
    public static final String CATEGORY_ICON_FOLDER = "uploads";
    public static final String NO_IMAGE_JPG = "no_image.jpg";
    
    public static final String ADMIN_USER_CHANGE_PASSWORD_PAGE = "/Administration/changePassword";
    
}
