/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import java.math.BigDecimal;
import java.util.Calendar;
import javax.inject.Inject;

import net.authorize.Environment;
import net.authorize.api.contract.v1.*;
import net.authorize.api.controller.base.ApiOperationBase;
import net.authorize.api.controller.CreateTransactionController;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderPayment;
import vn.chonsoft.lixi.repositories.service.LixiOrderPaymentService;
import vn.chonsoft.lixi.repositories.service.LixiOrderService;
import vn.chonsoft.lixi.web.util.LiXiUtils;
/**
 *
 * @author chonnh
 */
public class CreditCardProcesses {
    
    private static final Logger log = LogManager.getLogger(CreditCardProcesses.class);
    
    private String apiLoginId;
    private String transactionKey;

    private String runMode = "SANDBOX";
    
    @Inject
    private LixiOrderService orderService;
    
    @Inject
    private LixiOrderPaymentService paymentService;
    
    public void setApiLoginId(String apiLoginId) {
        this.apiLoginId = apiLoginId;
    }

    public void setTransactionKey(String transactionKey) {
        this.transactionKey = transactionKey;
    }

    public String getRunMode() {
        return runMode;
    }

    public void setRunMode(String runMode) {
        this.runMode = runMode;
    }

    /**
     * 
     * @return 
     */
    private Environment getEnvironment(){
        
        //SANDBOX, SANDBOX_TESTMODE, PRODUCTION, PRODUCTION_TESTMODE, LOCAL_VM, HOSTED_VM, CUSTOM
        switch(runMode){
            case "PRODUCTION":
                return Environment.PRODUCTION;
            case "PRODUCTION_TESTMODE":
                return Environment.PRODUCTION_TESTMODE;
            case "LOCAL_VM":
                return Environment.LOCAL_VM;
            case "HOSTED_VM":
                return Environment.HOSTED_VM;
            case "CUSTOM":
                return Environment.CUSTOM;
            case "SANDBOX_TESTMODE":
                return Environment.SANDBOX_TESTMODE;
            default:
                return Environment.SANDBOX;
        }
    }
    
    /**
     * 
     * @param order 
     * @param cardNumber
     * @param expirationDate
     * @param amount
     * @return 
     */
    public boolean chargeCreditCard(LixiOrder order, String cardNumber, String expirationDate, BigDecimal amount){
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());
        
        MerchantAuthenticationType merchantAuthenticationType  = new MerchantAuthenticationType() ;
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        // Populate the payment data
        PaymentType paymentType = new PaymentType();
        CreditCardType creditCard = new CreditCardType();
        creditCard.setCardNumber(cardNumber);
        creditCard.setExpirationDate(expirationDate);
        paymentType.setCreditCard(creditCard);

        // Create the payment transaction request
        TransactionRequestType txnRequest = new TransactionRequestType();
        txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
        txnRequest.setPayment(paymentType);
        txnRequest.setAmount(amount);

        // Make the API Request
        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setTransactionRequest(txnRequest);
        CreateTransactionController controller = new CreateTransactionController(apiRequest);
        controller.execute();


        CreateTransactionResponse response = controller.getApiResponse();
        
        // return value
        boolean returned = false;
        
        // insert lixi order payment
        LixiOrderPayment payment = new LixiOrderPayment();
        payment.setOrder(order);
        //
        log.info("###############################################");
        log.info("Order ID: " + order.getId());
        if (response!=null) {
            // If API Response is ok, go ahead and check the transaction response
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                TransactionResponse result = response.getTransactionResponse();
                
                payment.setResponseCode(result.getResponseCode());
                payment.setResponseText(LiXiUtils.marshal(result));
                // log
                if (result.getResponseCode().equals("1")) {
                    log.info(result.getResponseCode());
                    log.info("Successful Credit Card Transaction");
                    log.info(result.getAuthCode());
                    log.info(result.getTransId());
                    //
                    returned = true;
                }
                else
                {
                    log.info("Failed Transaction"+result.getResponseCode());
                }
                log.info("###############################################");
            }
            else
            {
                log.info("Failed Transaction:  "+response.getMessages().getResultCode());
                payment.setResponseCode(response.getMessages().getResultCode().value());
                payment.setResponseText("Failed Transaction");
            }
        }
        else{
            
            payment.setResponseCode("-1");
            payment.setResponseText("Can not create CreateTransactionResponse");
        }
        //
        payment.setModifiedDate(Calendar.getInstance().getTime());
        this.paymentService.save(payment);
        //
        return returned;
    }
}
