/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Currency;

/**
 *
 * @author chonnh
 */
public final class MoneyCalculation {

    /**
     * Simple test harness.
     *
     * Takes two numeric arguments, representing monetary values, in a form
     * which can be passed successfully to the <tt>BigDecimal(String)</tt>
     * constructor (<tt>25.00, 25.0, 25</tt>, etc).
     *
     * Note that the <tt>String</tt> constructor is preferred for
     * <tt>BigDecimal</tt>.
     */
    //public static void main(String... aArgs) {
    //    BigDecimal amountOne = new BigDecimal(aArgs[0]);
    //    BigDecimal amountTwo = new BigDecimal(aArgs[1]);
    //    MoneyCalculation calc = new MoneyCalculation(amountOne, amountTwo);
    //    calc.doCalculations();
    //}
    /**
     * 
     * @param aAmountOne
     * @param aAmountTwo 
     */
    public MoneyCalculation(BigDecimal aAmountOne, BigDecimal aAmountTwo) {
        fAmountOne = rounded(aAmountOne);
        fAmountTwo = rounded(aAmountTwo);
    }

    public void doCalculations() {
        log("Amount One: " + fAmountOne);
        log("Amount Two: " + fAmountTwo);
        log("Sum : " + getSum());
        log("Difference : " + getDifference());
        log("Average : " + getAverage());
        log("5.25% of Amount One: " + getPercentage());
        log("Percent Change From Amount One to Two: " + getPercentageChange());
    }

  // PRIVATE
    private final BigDecimal fAmountOne;
    private final BigDecimal fAmountTwo;

    /**
     * Defined centrally, to allow for easy changes to the rounding mode.
     */
    public final static RoundingMode ROUNDING_MODE = RoundingMode.CEILING;

    /**
     * Number of decimals to retain. Also referred to as "scale".
     */
    public final static int DECIMALS = 2;
  //An alternate style for this value :
    //private static int DECIMAL_PLACES =
    //  Currency.getInstance("USD").getDefaultFractionDigits()
    //;

    public final static int EXTRA_DECIMALS = 4;
    private static final BigDecimal TWO = new BigDecimal("2");
    private static BigDecimal HUNDRED = new BigDecimal("100");
    private static BigDecimal PERCENTAGE = new BigDecimal("5.25");

    public static BigDecimal divide(BigDecimal a, BigDecimal b){
        
        return round(a.divide(b, EXTRA_DECIMALS , ROUNDING_MODE));
    }
    
    public static BigDecimal multiply(BigDecimal a, BigDecimal b){
        
        return round(a.multiply(b));
    }
    
    public static BigDecimal round(BigDecimal aNumber) {
        return aNumber.setScale(DECIMALS, ROUNDING_MODE);
    }
    
    private void log(String aText) {
        System.out.println(aText);
    }

    private BigDecimal getSum() {
        return fAmountOne.add(fAmountTwo);
    }

    private BigDecimal getDifference() {
        return fAmountTwo.subtract(fAmountOne);
    }

    private BigDecimal getAverage() {
        return getSum().divide(TWO, ROUNDING_MODE);
    }

    private BigDecimal getPercentage() {
        BigDecimal result = fAmountOne.multiply(PERCENTAGE);
        result = result.divide(HUNDRED, ROUNDING_MODE);
        return rounded(result);
    }

    private BigDecimal getPercentageChange() {
        BigDecimal fractionalChange = getDifference().divide(
                fAmountOne, EXTRA_DECIMALS, ROUNDING_MODE
        );
        return rounded(fractionalChange.multiply(HUNDRED));
    }

    private BigDecimal rounded(BigDecimal aNumber) {
        return aNumber.setScale(DECIMALS, ROUNDING_MODE);
    }
}
