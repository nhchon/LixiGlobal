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
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderPayment;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.repositories.service.LixiOrderPaymentService;
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
     * @return 
     */
    public boolean charge(LixiOrder order){
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());
        
        MerchantAuthenticationType merchantAuthenticationType  = new MerchantAuthenticationType() ;
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        // Populate the payment data
        PaymentType paymentType = new PaymentType();
        TransactionRequestType txnRequest = new TransactionRequestType();
        if(order.getCard() != null){
            // get credit card
            UserCard card = order.getCard();
            String expireMonth = StringUtils.leftPad(card.getExpMonth()+"", 2, "0");
            String expireYear = StringUtils.leftPad(card.getExpYear()+"", 2, "0");
            
            CreditCardType creditCard = new CreditCardType();
            creditCard.setCardNumber(card.getCardNumber()); // 4242424242424242
            creditCard.setExpirationDate(expireMonth + expireYear); // // 0822
            paymentType.setCreditCard(creditCard);

            // Create the payment transaction request
            txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
            txnRequest.setPayment(paymentType);
            txnRequest.setAmount(new BigDecimal(String.valueOf(order.getTotalAmount())));
        }
        else{
            // paid by banking account
            if(order.getBankAccount() != null){
                
                // get bank account
                UserBankAccount uba = order.getBankAccount();
                //
                BankAccountType bankAccountType = new BankAccountType();
                bankAccountType.setAccountType(BankAccountTypeEnum.CHECKING);
                bankAccountType.setRoutingNumber(uba.getBankRounting());//"125000024"
                bankAccountType.setAccountNumber(uba.getCheckingAccount());//"12345678"
                bankAccountType.setNameOnAccount(uba.getName());//"John Doe"
                paymentType.setBankAccount(bankAccountType);

                // Create the payment transaction request
                txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
                txnRequest.setPayment(paymentType);
                txnRequest.setAmount(new BigDecimal(500.00));
            }
        }
        // Order
        OrderType invoice = new OrderType();
        invoice.setInvoiceNumber(order.getId().toString());
        invoice.setDescription("[" + order.getSender().getId()+", "+
                order.getSender().getFullName() + ", " + 
                order.getSender().getEmail() + ", " + 
                order.getId()+"]");
        //
        txnRequest.setOrder(invoice);
        
        // Make the API Request
        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setTransactionRequest(txnRequest);
        apiRequest.setRefId("LG"+System.currentTimeMillis());
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
                payment.setResponseText(LiXiUtils.marshalWithoutRootElement(result));
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
                    log.info("Failed TransactionResponse: "+result.getResponseCode());
                }
                log.info("###############################################");
            }
            else
            {
                log.info("Failed Transaction:  "+response.getMessages().getResultCode());
                payment.setResponseCode(response.getMessages().getResultCode().value());
                payment.setResponseText(LiXiUtils.marshal(response));
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
