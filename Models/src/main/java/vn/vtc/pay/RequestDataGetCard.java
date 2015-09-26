/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.vtc.pay;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

/**
 *
 * @author chonnh
 */
@JacksonXmlRootElement(localName = "RequestData")
public class RequestDataGetCard {
    
    @JacksonXmlProperty(localName = "ServiceCode")
    private String serviceCode;
    
    //@JacksonXmlProperty(localName = "Account")
    //private String account;
    
    @JacksonXmlProperty(localName = "Amount")
    private String amount;
    
    //@JacksonXmlProperty(localName = "TransDate")
    //private String transDate;
    
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

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
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
