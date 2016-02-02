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
    
    UNFINISHED("-2"),
    NOT_YET_SUBMITTED("-1"),
    SENT_INFO("0"),
    SENT_MONEY("1"),
    COMPLETED("2"),
    CANCELED("99")
    ;

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
    
}
