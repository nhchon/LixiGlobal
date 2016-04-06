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
public class CashRun {
    
    private String code;
    private String message;
    
    private CashRunResult result;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public CashRunResult getResult() {
        return result;
    }

    public void setResult(CashRunResult result) {
        this.result = result;
    }
    
    @Override
    public String toString(){
        
        return "[" + code + ", " + message + ", " + result + "]";
        
    }
}
