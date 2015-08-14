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
    
    // current recipient
    public static final String SELECTED_RECIPIENT_ID = "SELECTED_RECIPIENT_ID";
    public static final String SELECTED_RECIPIENT_IDS = "SELECTED_RECIPIENT_IDS";
    public static final String SELECTED_RECIPIENT_NAME = "SELECTED_RECIPIENT_NAME";
    public static final String SELECTED_AMOUNT = "SELECTED_AMOUNT";
    public static final String SELECTED_AMOUNT_CURRENCY = "SELECTED_AMOUNT_CURRENCY";
    
    public static final String CURRENCIES = "CURRENCIES";
    public static final String LIXI_EXCHANGE_RATE = "LIXI_EXCHANGE_RATE";
    public static final String LIXI_CATEGORIES = "LIXI_CATEGORIES";
    public static final String LIXI_ORDER_ID = "LIXI_ORDER_ID";
    
    public static final String USER_LOGIN_EMAIL = "USER_LOGIN_EMAIL";
    public static final String USER_LOGIN_FIRST_NAME = "USER_LOGIN_FIRST_NAME";
    
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
