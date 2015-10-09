/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public class SumVndUsd {
    
    private String type;
    
    private double vnd;
    
    private double usd;
    
    public SumVndUsd(){
     
        this.type = "";
        this.vnd = 0;
        this.usd = 0;
        
    }
    
    public SumVndUsd(String type, double vnd, double usd){
        
        this.type = type;
        this.vnd = vnd;
        this.usd = usd;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getVnd() {
        return vnd;
    }

    public void setVnd(double vnd) {
        this.vnd = vnd;
    }

    public double getUsd() {
        return usd;
    }

    public void setUsd(double usd) {
        this.usd = usd;
    }
    
    
}
