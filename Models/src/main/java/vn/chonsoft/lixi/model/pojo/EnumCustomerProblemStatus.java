/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public enum EnumCustomerProblemStatus {

    OPEN(0),
    IN_PROCESS(1),
    CANCEL(2),
    RE_OPEN(3),
    MANAGEMENT(4),
    CLOSED(5),
    ;

    private final int value;

    private EnumCustomerProblemStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static EnumCustomerProblemStatus findByValue(int value){
        
        for(EnumCustomerProblemStatus c : values()){
            
            if (c.getValue() == value) return c;
        }
        return null;
    }
    
}
