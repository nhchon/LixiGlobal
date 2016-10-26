/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi;

/**
 *
 * @author chonnh
 */
public enum EnumLixiOrderStatus {
    
    UN_FINISHED("UnFinished"),
    UN_PROCESSED("UnProcessed"), // with authorize.net
    PROCESSED("0"), // with authorize.net, = baokim processing
    /* BaoKim status */
    PROCESSING("0"), // send order info success
    COMPLETED("1"),
    CANCELED("2"),
    PURCHASED("5"),
    DELIVERED("7"),
    UNDELIVERABLE("9"),
    REFUNDED("11")
    ;
    
    /* gift status with baokim */
    public enum GiftStatus{
        
        UN_SUBMITTED("UnSubmitted"),
        SENT_INFO("SentInfo"),
        SENT_MONEY("SentMoney"),
        OUT_OF_STOCK("outOfStock");
        
        private final String value;
        
        private GiftStatus(String value){
            
            this.value = value;
        }
        
        public String getValue() {
            return value;
        }
    }
    
    /* topup can be submitted to VTC without wait the order precessed by authorize.net */
    public enum TopUpStatus{
        
        UN_SUBMITTED("UnSubmitted");
        
        private final String value;
        
        private TopUpStatus(String value){
            
            this.value = value;
        }
        
        public String getValue() {
            return value;
        }
    }
    
    private final String value;

    private EnumLixiOrderStatus(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static EnumLixiOrderStatus findByValue(String value){
        
        for(EnumLixiOrderStatus c : values()){
            
            if (value.equals(c.getValue())) return c;
        }
        return null;
    }
    
    @Override
    public String toString(){
        return this.value;
    }
}
