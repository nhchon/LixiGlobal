/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web;

import org.springframework.ws.WebServiceMessage;
import org.springframework.ws.client.core.support.WebServiceGatewaySupport;
import org.springframework.ws.soap.SoapMessage;
import org.springframework.ws.soap.client.core.SoapActionCallback;
import vn.vtc.pay.RequestTransaction;
import vn.vtc.pay.RequestTransactionResponse;

/**
 *
 * @author chonnh
 */
public class VtcPayClient extends WebServiceGatewaySupport {

    /**
     * 
     * @param requestData
     * @return 
     */
    public RequestTransactionResponse topupTelco(String requestData) {

        RequestTransaction requestTransaction = new RequestTransaction();
        requestTransaction.setRequesData(requestData);
        requestTransaction.setPartnerCode("yhannart");
        requestTransaction.setCommandType("TopupTelco");
        requestTransaction.setVersion("1.0");
        
        /* It's OK*/
        RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
                requestTransaction,
                new SoapActionCallback("https://pay.vtc.vn/WS/GoodsPaygate.asmx?op=RequestTransaction") {
                    public void doWithMessage(WebServiceMessage message) {
                        ((SoapMessage) message).setSoapAction("http://tempuri.org/RequestTransaction");
                    }
                });
        //RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
                //requestTransaction, new SoapActionCallback("http://tempuri.org/RequestTransaction"));

        return response;
    }
    
    /**
     * 
     * @param requestData
     * @return 
     */
    public RequestTransactionResponse buyCard(String requestData) {

        RequestTransaction requestTransaction = new RequestTransaction();
        requestTransaction.setRequesData(requestData);
        requestTransaction.setPartnerCode("yhannart");
        requestTransaction.setCommandType("BuyCard");
        requestTransaction.setVersion("1.0");
        
        /* It's OK*/
        RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
                requestTransaction,
                new SoapActionCallback("https://pay.vtc.vn/WS/GoodsPaygate.asmx?op=RequestTransaction") {
                    public void doWithMessage(WebServiceMessage message) {
                        ((SoapMessage) message).setSoapAction("http://tempuri.org/RequestTransaction");
                    }
                });
        //RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
                //requestTransaction, new SoapActionCallback("http://tempuri.org/RequestTransaction"));

        return response;
    }
    
    /**
     * 
     * @param requestData
     * @return 
     */
    public RequestTransactionResponse getCard(String requestData) {
        //
        RequestTransaction requestTransaction = new RequestTransaction();
        requestTransaction.setRequesData(requestData);
        requestTransaction.setPartnerCode("yhannart");
        requestTransaction.setCommandType("GetCard");
        requestTransaction.setVersion("1.0");
        
        /* It's OK*/
        RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
                requestTransaction,
                new SoapActionCallback("https://pay.vtc.vn/WS/GoodsPaygate.asmx?op=RequestTransaction") {
                    public void doWithMessage(WebServiceMessage message) {
                        ((SoapMessage) message).setSoapAction("http://tempuri.org/RequestTransaction");
                    }
                });
        //getWebServiceTemplate().m
        //RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
                //requestTransaction, new SoapActionCallback("http://tempuri.org/RequestTransaction"));

        return response;
    }
}
