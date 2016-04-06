/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.pojo;

/**
 *
 * @author Asus
 */
public class CashRunResult {
    
    private String AMOUNT;
    private String CURRENCY;
    private String ORDER_ID;
    private String PROTECTION;
    private String RISK_SCORE;
    private String RISK_STATUS;
    private String SITE_ID;
    private String TEST_FLAG;
    @Override
    public String toString(){
        
        return "[" + AMOUNT + ", "  + CURRENCY + ", "  + ORDER_ID + ", "  + PROTECTION + ", "  + RISK_SCORE + ", "  + RISK_STATUS + ", "  + SITE_ID + ", "  + TEST_FLAG +"]";
    }

    public String getAMOUNT() {
        return AMOUNT;
    }

    public void setAMOUNT(String AMOUNT) {
        this.AMOUNT = AMOUNT;
    }

    public String getCURRENCY() {
        return CURRENCY;
    }

    public void setCURRENCY(String CURRENCY) {
        this.CURRENCY = CURRENCY;
    }

    public String getORDER_ID() {
        return ORDER_ID;
    }

    public void setORDER_ID(String ORDER_ID) {
        this.ORDER_ID = ORDER_ID;
    }

    public String getPROTECTION() {
        return PROTECTION;
    }

    public void setPROTECTION(String PROTECTION) {
        this.PROTECTION = PROTECTION;
    }

    public String getRISK_SCORE() {
        return RISK_SCORE;
    }

    public void setRISK_SCORE(String RISK_SCORE) {
        this.RISK_SCORE = RISK_SCORE;
    }

    public String getRISK_STATUS() {
        return RISK_STATUS;
    }

    public void setRISK_STATUS(String RISK_STATUS) {
        this.RISK_STATUS = RISK_STATUS;
    }

    public String getSITE_ID() {
        return SITE_ID;
    }

    public void setSITE_ID(String SITE_ID) {
        this.SITE_ID = SITE_ID;
    }

    public String getTEST_FLAG() {
        return TEST_FLAG;
    }

    public void setTEST_FLAG(String TEST_FLAG) {
        this.TEST_FLAG = TEST_FLAG;
    }
    
}
