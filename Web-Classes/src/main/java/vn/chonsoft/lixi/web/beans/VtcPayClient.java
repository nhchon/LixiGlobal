/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.inject.Inject;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.ws.WebServiceMessage;
import org.springframework.ws.client.core.support.WebServiceGatewaySupport;
import org.springframework.ws.soap.SoapMessage;
import org.springframework.ws.soap.client.core.SoapActionCallback;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.vtc.pay.RequestData;
import vn.vtc.pay.RequestDataGetCard;
import vn.vtc.pay.RequestTransaction;
import vn.vtc.pay.RequestTransactionResponse;

/**
 *
 * @author chonnh
 */
public class VtcPayClient extends WebServiceGatewaySupport {

    private static final Logger log = LogManager.getLogger(VtcPayClient.class);

    public static final String TOPUP_VTC_CODE = "VTC0056";

    @Inject
    private LiXiSecurityManager securityManager;

    @Inject
    private TripleDES tripleDES;

    private final XmlMapper xmlMapper;

    private final SimpleDateFormat format;

    private String vtcPartnerCode;

    public VtcPayClient() {

        xmlMapper = new XmlMapper();
        format = new SimpleDateFormat("yyyyMMddHHmmss");
    }

    public String getVtcPartnerCode() {
        return vtcPartnerCode;
    }

    public void setVtcPartnerCode(String vtcPartnerCode) {
        this.vtcPartnerCode = vtcPartnerCode;
    }

    /**
     * 
     * @param myString
     * @return
     * @throws Exception 
     */
    public String decryptTripleDES(String myString) throws Exception{
        
        return tripleDES.decrypt(myString);
    }
    
    /**
     * 
     * @param buyCardId
     * @param serviceCode
     * @param amount
     * @param quantity
     * @return 
     */
    public String buyCardRequestData(Long buyCardId, String serviceCode, String amount, String quantity) {

        String transDate = format.format(Calendar.getInstance().getTime());//yyyyMMddHHmmss

        String orgTransID = LiXiConstants.LIXI_GLOBAL_BUY_CARD_CODE + StringUtils.leftPad(buyCardId.toString(), 9, '0');

        String dataSign = StringUtils.join(new String[]{serviceCode, amount, quantity, vtcPartnerCode, transDate, orgTransID}, '-');

        byte[] dataSigned = securityManager.signData(dataSign.getBytes());

        try {

            RequestData r = new RequestData();
            r.setAccount("");
            r.setAmount(amount);
            r.setOrgTransID(orgTransID);
            r.setQuantity(quantity);
            r.setServiceCode(serviceCode);
            r.setTransDate(transDate);
            r.setDataSign(Base64.encodeBase64String(dataSigned));//new String(dataSigned)

            String requestData = xmlMapper.writeValueAsString(r);

            requestData = requestData.replaceAll(" xmlns=\"\"", "");
            requestData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + requestData;

            return requestData;
        } catch (Exception e) {
            log.info(e.getMessage(), e);
        }

        return null;
    }

    /**
     * 
     * @param vtcTransId (string, required): Mã giao dịch do VTC đã gửi trả về trong hàm BuyCard
     * @param serviceCode
     * @param amount
     * @return 
     */
    public String getCardData(String vtcTransId, String serviceCode, String amount){
        
        String dataSign = StringUtils.join(new String[] {serviceCode, amount, vtcPartnerCode, vtcTransId}, '-');
        //
        log.info("getCardData dataSign:" + dataSign);
        //
        byte[] dataSigned = securityManager.signData(dataSign.getBytes());
        
        try {
            
            RequestDataGetCard r = new RequestDataGetCard();
            r.setAmount(amount);
            r.setOrgTransID(vtcTransId);
            r.setServiceCode(serviceCode);
            r.setDataSign(Base64.encodeBase64String(dataSigned));//new String(dataSigned)

            String requestData = xmlMapper.writeValueAsString(r);

            requestData = requestData.replaceAll(" xmlns=\"\"", "");
            requestData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + requestData;

            return requestData;
            
        } catch (Exception e) {
            log.info(e.getMessage(), e);
        }
        
        return null;
    }
    /**
     * 
     * 
     * @param topUpRecordId
     * @param serviceCode
     * @param account
     * @param amount
     * @return 
     */
    public String topUpRequestData(Long topUpRecordId, String serviceCode, String account, String amount) {

        String transDate = format.format(Calendar.getInstance().getTime());//yyyyMMddHHmmss

        String orgTransID = LiXiConstants.LIXI_GLOBAL_TOP_UP_CODE + StringUtils.leftPad(topUpRecordId.toString(), 9, '0');

        String dataSign = StringUtils.join(new String[]{serviceCode, account, amount, vtcPartnerCode, transDate, orgTransID}, '-');

        byte[] dataSigned = securityManager.signData(dataSign.getBytes());

        RequestData r = new RequestData();
        r.setAccount(account);
        r.setAmount(amount);
        r.setOrgTransID(orgTransID);
        r.setQuantity("1");
        r.setServiceCode(serviceCode);
        r.setTransDate(transDate);
        r.setDataSign(Base64.encodeBase64String(dataSigned));//new String(dataSigned)

        try {
            String requestData = xmlMapper.writeValueAsString(r);

            requestData = requestData.replaceAll(" xmlns=\"\"", "");
            requestData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + requestData;

            return requestData;
        } catch (Exception e) {
            log.info(e.getMessage(), e);
        }
        return null;
    }

    /**
     *
     * @param requestData
     * @return RequestTransactionResponse ResponseCode|OrgTransID|PartnerBalance|DataSign
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
        /*
        RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
        requestTransaction, new SoapActionCallback("http://tempuri.org/RequestTransaction"));
        */
        
        return response;
    }

    /**
     *
     * @param requestData
     * @return RequestTransactionResponse ResponseCode|OrgTransID|VTCTransID|PartnerBalance|dataSign

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

        //String returnStr = response.getRequestTransactionResult();
        //returnStr.split("\\|");
                
        return response;
    }

    /**
     *
     * @param requestData
     * @return RequestTransactionResponse ResponseCode|OrgTranID|ListCard, ListCard = CardCode1:CardSerial1:ExpriceDate1|
     *                                                              CardCoden:CardSerialn:ExpriceDaten
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

        //RequestTransactionResponse response = (RequestTransactionResponse) getWebServiceTemplate().marshalSendAndReceive(
        //requestTransaction, new SoapActionCallback("http://tempuri.org/RequestTransaction"));
        
        //String returnStr = response.getRequestTransactionResult();
        //returnStr.split("\\|");
        
        return response;
    }
}
