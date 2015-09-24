/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 *
 * @author chonnh
 */
public class TestEverything {

    public void testDouble2Str() {
        Double a = 2.34;

        System.err.println(a.toString());

        double dd = .35;
        BigDecimal d = new BigDecimal(dd);

        BigDecimal d2 = new BigDecimal(new Double(dd).toString());
        System.out.println(".35 = " + d);
        System.out.println(".35 = " + d2);
    }

    public void testBigDecimal(BigDecimal a, BigDecimal b) {

        //System.out.println(MoneyCalculation.divide(a, b));
        BigDecimal mul = MoneyCalculation.multiply(new BigDecimal("800000"), new BigDecimal("1"));

        System.out.println(MoneyCalculation.divide(mul, new BigDecimal("20500.0")));
    }

    public static void main(String[] args) {

        //TestEverything e = new TestEverything();
        //e.testBigDecimal(new BigDecimal("800000"), new BigDecimal("20500.0"));
        //e.testBigDecimal(new BigDecimal("1600000"), new BigDecimal("20500.0"));
        double a = 39.0244 + 0.005;
        double b = 78.0488 + 0.005*2;
        
        double roundOff = Math.round(a * 100.0) / 100.0;
        
        DecimalFormat df = new DecimalFormat("###,###.##");
        //System.out.println(roundOff);
        //System.out.println(df.format(a));
        //System.out.println(df.format(b));
        
        double rsl = ((700000 * 1) / 20500.0) + (1 * 0.005);
        
        System.out.println(Math.round(rsl * 100.0) / 100.0);
        
        double rsl1 = ((700000 * -1) / 20500.0) + (-1 * 0.005);
        
        System.out.println(Math.round(rsl1 * 100.0) / 100.0);
    }
}
