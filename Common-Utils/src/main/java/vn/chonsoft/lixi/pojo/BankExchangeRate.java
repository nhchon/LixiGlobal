/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.pojo;

import java.util.List;
import vn.chonsoft.lixi.pojo.Exrate;

/**
 *
 * @author chonnh
 */
public class BankExchangeRate {
    
    /* ex: Joint Stock Commercial Bank for Foreign Trade of Vietnam */
    private String bankName;
    /* ex: Vietcombank*/
    private String bankShortName;
    /* */
    private String time;
    /* */
    private List<Exrate> exrates;

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getBankShortName() {
        return bankShortName;
    }

    public void setBankShortName(String bankShortName) {
        this.bankShortName = bankShortName;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public List<Exrate> getExrates() {
        return exrates;
    }

    public void setExrates(List<Exrate> exrates) {
        this.exrates = exrates;
    }
    
    
}
