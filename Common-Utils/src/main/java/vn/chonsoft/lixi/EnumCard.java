/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi;

/**
 *
 * @author chonnh
 */
public enum EnumCard {

    VISA(1),
    MASTER(2),
    DISCOVER(3),
    AMEX(4);

    private final int value;

    private EnumCard(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static EnumCard findByValue(int value){
        
        for(EnumCard c : values()){
            
            if (c.getValue() == value) return c;
        }
        return null;
    }
    
}
