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
    
    UNFINISHED("-9"),
    NOT_YET_SUBMITTED("-8"),
    SENT_INFO("-7"),
    SENT_MONEY("-6"),
    /* BaoKim status */
    PROCESSING("0"),
    COMPLETED("1"),
    CANCELED("2")
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
