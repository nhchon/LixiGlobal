/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi;

/**
 *
 * @author chonnh
 */
public enum EnumTopUpStatus {
    
    ORDER_UNFINISHED(-2),
    SEND_FAILED(-1),
    NOT_YET_SEND(0),
    SENT(1),
    CANCEL_BY_ADMIN(2);
    
    private final int value;
    
    private EnumTopUpStatus(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }    
}
