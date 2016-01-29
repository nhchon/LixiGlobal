/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi;

/**
 *
 * @author chonnh
 */
public enum EnumTransactionResponseCode {

    APPROVED("1"),
    DECLINED("2"),
    ERROR("3"),
    HELD_FOR_REVIEW("4");

    private final String value;

    private EnumTransactionResponseCode(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
    
}
