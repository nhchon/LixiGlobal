/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi;

/**
 *
 * @author chonnh
 */
public enum EnumLixiOrderSetting {

    GIFT_ONLY(0),
    ALLOW_REFUND(1);

    private final int value;

    private EnumLixiOrderSetting(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static EnumLixiOrderSetting findByValue(int value){
        
        for(EnumLixiOrderSetting c : values()){
            
            if (c.getValue() == value) return c;
        }
        return null;
    }
    
}
