/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi;

/**
 *
 * @author chonnh
 */
public abstract class LiXiGlobalConstants {
    
    /* */
    public static final String LIXI_AUTHORITY_ORDER_MANAGEMENT = "NEW_ORDER_INFO/SEND_MONEY";
    
    public static final String MONEY_LEVEL = "MONEY_LEVEL";
    
    public static final String BAOKIM_GIFT_METHOD = "GIFT";
    public static final String BAOKIM_MONEY_METHOD = "MONEY";
    
    public static final String LIXI_ADMINISTRATOR_EMAIL = "LIXI_ADMINISTRATOR_EMAIL";
    public static final String LIXI_BAOKIM_TRANFER_PERCENT = "LIXI_BAOKIM_TRANFER_PERCENT";
    public static final String LIXI_TOPUP_BALANCE = "LIXI_TOPUP_BALANCE";
    
    public static final String LIXI_VTC_TRANFER_PERCENT = "LIXI_VTC_TRANFER_PERCENT";
    
    public static final String AUTO_SYSTEM = "AUTO_SYSTEM";
    
    public static final String USD = "USD";
    
    public static final String OK = "OK";
    
    public static final String R = "R";
    
    public static final String S = "S";
    
    public static final String ON = "On";
    
    public static final String OFF = "Off";
    
    public static final String YHANNART_GMAIL = "yhannart@gmail.com";
    
    public static final String CHONNH_GMAIL = "chonnh@gmail.com";
    
    public static final double LIXI_BAOKIM_DEFAULT_PERCENT = 95.0;
    
    /* Type */
    public static final String LIXI_GIFT_TYPE = "LIXI_GIFT_TYPE";
    public static final String LIXI_PHONE_CARD_TYPE = "LIXI_PHONE_CARD_TYPE";
    public static final String LIXI_TOP_UP_TYPE = "LIXI_TOP_UP_TYPE";
    public static final String LIXI_TOTAL_ALL_TYPE = "TOTAL_ALL_TYPE";
    
    /* */
    public static final String TRANS_REPORT_STATUS_ALL = "All";
    
    public static final String TRANS_REPORT_STATUS_PROCESSED = "Processed";
    
    public static final String TRANS_REPORT_STATUS_COMPLETED = "Completed";
    
    public static final String TRANS_REPORT_STATUS_CANCELLED = "Cancelled";
    
    /* */
    public static final String TRANS_STATUS_IN_PROGRESS = "In Progress";
    
    public static final String TRANS_STATUS_DECLINED = "Declined";
    public static final String TRANS_STATUS_USER_CANCELLED = "User Cancelled";
    
    public static final String TRANS_STATUS_REFUNED = "Refunded";
    
    public static final String TRANS_STATUS_PROCESSED = "Processed";
    
    public static final String TRANS_STATUS_SENT = "Sent";
    
    public static final String TRANS_STATUS_COMPLETED = "Completed";
    
    public static final String VCB_EXCHANGE_RATES_PAGE = "http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx";
    
    public static final String CASHRUN_SANDBOX_PAGE = "https://cashshield.cashrun.com/devtest/risk_score.php";
    
    public static final String CASHRUN_SANDBOX_PAGE_TRANSACTION_STATUS_UPDATE = "https://cashshield.cashrun.com/devtest/transaction_update.php";
    
    public static final String CASHRUN_PRODUCTION_PAGE = "https://cashshield.cashrun.com/live/risk_score.php";
    
    public static final String CASHRUN_PRODUCTION_PAGE_TRANSACTION_STATUS_UPDATE = "https://cashshieldasia.cashrun.com/live/transaction_update.php";
    
    public static final int LIXI_DEFAULT_BUY_RATE = -2;
    
    public static final int LIXI_DEFAULT_SELL_RATE = 3;
    
    public static final int LIXI_GIFT_ONLY_OPTION = 0;
    
    public static final int LIXI_ALLOW_REFUND_OPTION = 1;
    
    public static final int USER_MAX_NUM_OF_CARD = 5;
    
    public static final double LIXI_DEFAULT_INCREASE_PERCENT = 5.0;
}
