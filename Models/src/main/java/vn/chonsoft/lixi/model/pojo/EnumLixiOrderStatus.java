/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public enum EnumLixiOrderStatus {
    
    UNFINISHED(-2),
    NOT_YET_SUBMITTED(-1),
    PROCESSING(0),
    COMPLETED(1),
    CANCEL(2);

    private final int value;

    private EnumLixiOrderStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static EnumLixiOrderStatus findByValue(int value){
        
        for(EnumLixiOrderStatus c : values()){
            
            if (c.getValue() == value) return c;
        }
        return null;
    }
    
}
