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
import net.authorize.api.controller.CreateCustomerProfileController;
import net.authorize.api.controller.base.ApiOperationBase;
import net.authorize.api.controller.CreateTransactionController;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import vn.chonsoft.lixi.model.AuthorizeCustomerResult;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderPayment;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.repositories.service.AuthorizeCustomerResultService;
import vn.chonsoft.lixi.repositories.service.AuthorizePaymentResultService;
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
    
    @Inject
    private AuthorizeCustomerResultService customerResultService;
    
    @Inject
    private AuthorizePaymentResultService paymentResultService;
    
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
     * @param u
     * @param card
     * @return 
     */
    public boolean createCustomerProfile(User u, UserCard card){
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());
        
        MerchantAuthenticationType merchantAuthenticationType  = new MerchantAuthenticationType() ;
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        CreditCardType creditCard = new CreditCardType();
        //creditCard.set
        creditCard.setCardNumber(card.getCardNumber());
        String expireMonth = StringUtils.leftPad(card.getExpMonth()+"", 2, "0");
        String expireYear = StringUtils.leftPad(card.getExpYear()+"", 2, "0");
        creditCard.setExpirationDate(expireMonth + expireYear);
        PaymentType paymentType = new PaymentType();
        paymentType.setCreditCard(creditCard);
        
        CustomerPaymentProfileType customerPaymentProfileType = new CustomerPaymentProfileType();
        customerPaymentProfileType.setCustomerType(CustomerTypeEnum.INDIVIDUAL);
        customerPaymentProfileType.setPayment(paymentType);
        
        CustomerProfileType customerProfileType = new CustomerProfileType();
        customerProfileType.setMerchantCustomerId(u.getId().toString());
        customerProfileType.setDescription("[" + u.getFullName() + " , " + u.getPhone() + " , " + u.getEmail() + "]");
        customerProfileType.setEmail(u.getEmail());
        customerProfileType.getPaymentProfiles().add(customerPaymentProfileType);
        
        CreateCustomerProfileRequest apiRequest = new CreateCustomerProfileRequest();
        apiRequest.setProfile(customerProfileType);
        apiRequest.setValidationMode(ValidationModeEnum.LIVE_MODE);
        apiRequest.setRefId(System.currentTimeMillis()+"");
        
        CreateCustomerProfileController controller = new CreateCustomerProfileController(apiRequest);
        controller.execute();
        // 
        CreateCustomerProfileResponse response = controller.getApiResponse();
        AuthorizeCustomerResult cus = new AuthorizeCustomerResult();
        cus.setUser(u);
        boolean returned = false;
        if (response != null) {
            
            String resultCode = response.getMessages().getResultCode().value();
            String resultText = LiXiUtils.marshalWithoutRootElement(response.getMessages());
            
            cus.setResponseCode(resultCode);
            cus.setResponseText(resultText);
            cus.setCreatedDate(Calendar.getInstance().getTime());
            
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {
                
                System.out.println(response.getCustomerProfileId());
                for(String s : response.getCustomerPaymentProfileIdList().getNumericString()){
                    System.out.println(s);
                }
                System.out.println(response.getCustomerPaymentProfileIdList().getNumericString().get(0));
                System.out.println(response.getCustomerShippingAddressIdList().getNumericString().get(0));
                System.out.println(response.getValidationDirectResponseList().getString().get(0));
                
                //
                returned = true;
            } else {
                
                System.out.println("Failed to create customer profile:  " + response.getMessages().getResultCode());
                for(MessagesType.Message m : response.getMessages().getMessage()){
                    System.out.println(m.getCode() + " : " + m.getText());
                }
            }
        }
        else{
            
            cus.setResponseCode("-999");
            cus.setResponseText("CAN NOT CREATE CreateCustomerProfileResponse");
            
        }
        
        // save
        cus.setCreatedDate(Calendar.getInstance().getTime());
        this.customerResultService.save(cus);
        
        // return
        return returned;
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
        txnRequest.setRefTransId(order.getId().toString());
        
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
            
            payment.setResponseCode("-999");
            payment.setResponseText("Can not create CreateTransactionResponse");
        }
        //
        payment.setModifiedDate(Calendar.getInstance().getTime());
        this.paymentService.save(payment);
        //
        return returned;
    }
}
