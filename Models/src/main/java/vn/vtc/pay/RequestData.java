/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.vtc.pay;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author chonnh
 */
@XmlRootElement
public class RequestData {
    
    @JacksonXmlProperty(localName = "ServiceCode")
    private String serviceCode;
    
    @JacksonXmlProperty(localName = "Account")
    private String account;
    
    @JacksonXmlProperty(localName = "Amount")
    private String amount;
    
    @JacksonXmlProperty(localName = "Quantity")
    private String quantity;
    
    @JacksonXmlProperty(localName = "TransDate")
    private String transDate;
    
    @JacksonXmlProperty(localName = "OrgTransID")
    private String orgTransID;
    
    @JacksonXmlProperty(localName = "DataSign")
    private String dataSign;

    public String getServiceCode() {
        return serviceCode;
    }

    public void setServiceCode(String serviceCode) {
        this.serviceCode = serviceCode;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getTransDate() {
        return transDate;
    }

    public void setTransDate(String transDate) {
        this.transDate = transDate;
    }

    public String getOrgTransID() {
        return orgTransID;
    }

    public void setOrgTransID(String orgTransID) {
        this.orgTransID = orgTransID;
    }

    public String getDataSign() {
        return dataSign;
    }

    public void setDataSign(String dataSign) {
        this.dataSign = dataSign;
    }
    
    
}
