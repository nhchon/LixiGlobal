/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import java.math.BigDecimal;
import java.util.Calendar;

import net.authorize.Environment;
import net.authorize.api.contract.v1.*;
import net.authorize.api.controller.CreateCustomerProfileController;
import net.authorize.api.controller.CreateCustomerProfileFromTransactionController;
import net.authorize.api.controller.CreateCustomerProfileTransactionController;
import net.authorize.api.controller.base.ApiOperationBase;
import net.authorize.api.controller.CreateTransactionController;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import vn.chonsoft.lixi.model.AuthorizeCustomerResult;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiInvoicePayment;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.web.util.LiXiUtils;
/**
 *
 * @author chonnh
 */
public class CreditCardProcessesTest {
    
    private static final Logger log = LogManager.getLogger(CreditCardProcessesTest.class);
    
    private String apiLoginId;
    private String transactionKey;

    private String runMode = "SANDBOX";
    
    //@Inject
    //private LixiOrderPaymentService paymentService;
    
    //@Inject
    //private AuthorizeCustomerResultService customerResultService;
    
    //@Inject
    //private AuthorizePaymentResultService paymentResultService;
    
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

        /* Credit card*/    
        CreditCardType creditCard = new CreditCardType();
        creditCard.setCardNumber(card.getCardNumber());
        String expireMonth = StringUtils.leftPad(card.getExpMonth()+"", 2, "0");
        String expireYear = StringUtils.leftPad(card.getExpYear()+"", 2, "0");
        creditCard.setExpirationDate(expireMonth + expireYear);
        PaymentType paymentType = new PaymentType();
        paymentType.setCreditCard(creditCard);
        
        /* Billing Address*/
        CustomerAddressType billingInfo = new CustomerAddressType();
        billingInfo.setFirstName(u.getFirstName());
        billingInfo.setLastName(u.getLastName());
        billingInfo.setCompany("");
        billingInfo.setAddress("");
        billingInfo.setCity("");
        billingInfo.setState("");
        billingInfo.setCountry("");
        billingInfo.setZip("");
        //billingInfo.setCountry();
        billingInfo.setPhoneNumber(u.getPhone());
        billingInfo.setFaxNumber(u.getPhone());
        
        /* Payment */
        CustomerPaymentProfileType customerPaymentProfileType = new CustomerPaymentProfileType();
        customerPaymentProfileType.setCustomerType(CustomerTypeEnum.INDIVIDUAL);
        customerPaymentProfileType.setPayment(paymentType);
        customerPaymentProfileType.setBillTo(billingInfo);
        
        /* customer profile*/
        CustomerProfileType customerProfileType = new CustomerProfileType();
        customerProfileType.setMerchantCustomerId(u.getId().toString());
        customerProfileType.setDescription("[" + u.getFullName() + " , " + u.getPhone() + " , " + u.getEmail() + "]");
        customerProfileType.setEmail(u.getEmail());
        customerProfileType.getPaymentProfiles().add(customerPaymentProfileType);
        
        /* Action*/
        CreateCustomerProfileRequest apiRequest = new CreateCustomerProfileRequest();
        apiRequest.setProfile(customerProfileType);
        apiRequest.setValidationMode(ValidationModeEnum.TEST_MODE);
        apiRequest.setRefId(System.currentTimeMillis()+"");
        
        CreateCustomerProfileController controller = new CreateCustomerProfileController(apiRequest);
        controller.execute();
        
        // 
        CreateCustomerProfileResponse response = controller.getApiResponse();
        AuthorizeCustomerResult cus = new AuthorizeCustomerResult();
        cus.setUserId(u.getId());
        boolean returned = false;
        if (response != null) {
            
            String resultCode = response.getMessages().getResultCode().value();
            String resultText = LiXiUtils.marshalWithoutRootElement(response.getMessages());
            
            System.out.println(resultCode +" : " + resultText);
            
            cus.setResponseCode(resultCode);
            cus.setResponseText(resultText);
            cus.setCreatedDate(Calendar.getInstance().getTime());
            
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {
                
                System.out.println(response.getCustomerProfileId());
                for(String s : response.getCustomerPaymentProfileIdList().getNumericString()){
                    System.out.println(s);
                }
                System.out.println(response.getCustomerPaymentProfileIdList().getNumericString().get(0));
                //System.out.println(response.getCustomerShippingAddressIdList().getNumericString().get(0));
                //System.out.println(response.getValidationDirectResponseList().getString().get(0));
                
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
            
            System.out.println("-999");
            System.out.println("CAN NOT CREATE CreateCustomerProfileResponse");
            
        }
        
        // save
        cus.setCreatedDate(Calendar.getInstance().getTime());
        //this.customerResultService.save(cus);
        
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
            //txnRequest.setAmount(new BigDecimal(String.valueOf(order.getTotalAmount())));
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
        LixiInvoicePayment payment = new LixiInvoicePayment();
        payment.setInvoice(order.getId());
        //
        System.out.println("###############################################");
        System.out.println("Order ID: " + order.getId());
        if (response!=null) {
            // If API Response is ok, go ahead and check the transaction response
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                TransactionResponse result = response.getTransactionResponse();
                
                payment.setResponseCode(result.getResponseCode());
                payment.setResponseText(LiXiUtils.marshalWithoutRootElement(result));
                // log
                if (result.getResponseCode().equals("1")) {
                    System.out.println(result.getResponseCode());
                    System.out.println("Successful Credit Card Transaction");
                    System.out.println(result.getAuthCode());
                    System.out.println(result.getTransId());
                    //
                    returned = true;
                }
                else
                {
                    System.out.println("Failed TransactionResponse: "+result.getResponseCode());
                }
                System.out.println("###############################################");
            }
            else
            {
                System.out.println("Failed Transaction:  "+response.getMessages().getResultCode());
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
        //this.paymentService.save(payment);
        //
        return returned;
    }
    
    public boolean chargeByCustomerProfile(String cusProfile, String payProfile){
        
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());
        
        MerchantAuthenticationType merchantAuthenticationType  = new MerchantAuthenticationType() ;
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        // Populate the payment data
        PaymentType paymentType = new PaymentType();
        CreditCardType creditCard = new CreditCardType();
        creditCard.setCardNumber("4242424242424242");
        creditCard.setExpirationDate("0822");
        paymentType.setCreditCard(creditCard);
        
        // Create the payment transaction request
        //TransactionRequestType txnRequest = new TransactionRequestType();
        CreateCustomerProfileTransactionRequest txnRequest = new CreateCustomerProfileTransactionRequest();
        //txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
        //txnRequest.setPayment(paymentType);
        //txnRequest.setAmount(new BigDecimal("50.0"));
        /* Billing Address*/
        //CustomerAddressType billingInfo = new CustomerAddressType();
        //billingInfo.setFirstName("Nguyen Thi");
        //billingInfo.setLastName("Tung");
        //billingInfo.setCompany("");
        //billingInfo.setAddress("");
        //billingInfo.setCity("");
        //billingInfo.setState("");
        //billingInfo.setCountry("");
        //billingInfo.setZip("");
        //billingInfo.setPhoneNumber("+84967007869");
        //billingInfo.setFaxNumber("+84967007869");
        
        
        /* Customer profile id */
        //CustomerProfilePaymentType cusPaymentProfile = new CustomerProfilePaymentType();
        //cusPaymentProfile.setCreateProfile(Boolean.FALSE);
        //cusPaymentProfile.setCustomerProfileId(cusProfile);
        /* Payment profile */
        //PaymentProfile paymentProfile = new PaymentProfile();
        //paymentProfile.setPaymentProfileId(payProfile);
        //paymentProfile.setCardCode("");
        
        //cusPaymentProfile.setPaymentProfile(paymentProfile);
        //cusPaymentProfile.setShippingProfileId(null);
        /* set profile */
        //txnRequest.setProfile(cusPaymentProfile);
        
        /* Order information */
        OrderExType invoice = new OrderExType();
        invoice.setPurchaseOrderNumber(Long.toString(System.currentTimeMillis()));
        invoice.setInvoiceNumber(Long.toString(System.currentTimeMillis()));
        invoice.setDescription("[description here]");
        //txnRequest.setOrder(invoice);
        
        ProfileTransAuthCaptureType authCap = new ProfileTransAuthCaptureType();
        authCap.setCardCode("");
        authCap.setAmount(new BigDecimal("1.0"));
        authCap.setCustomerProfileId(cusProfile);
        authCap.setCustomerPaymentProfileId(payProfile);
        authCap.setOrder(invoice);
        /* ProfileTransactionType */
        ProfileTransactionType transType = new ProfileTransactionType();
        transType.setProfileTransAuthCapture(authCap);
        //authCap.s
        txnRequest.setTransaction(transType);
        
        /* RefId*/
        //txnRequest.setRefTransId(Long.toString(System.currentTimeMillis()));
        
        
        /**/
        //CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        //Create
        //apiRequest.setTransactionRequest(txnRequest);
        //CreateCustomerProfileTransactionRequest apiRequest = new CreateCustomerProfileTransactionRequest();
        //apiRequest.setTransaction(transType);
        /* */
        //CreateTransactionController controller = new CreateTransactionController(txnRequest);
        
        CreateCustomerProfileTransactionController controller = new CreateCustomerProfileTransactionController(txnRequest);
        controller.execute();
        
        /* get transaction response */
        CreateCustomerProfileTransactionResponse response = controller.getApiResponse();
        
        /* handle and return*/
        // return value
        boolean returned = false;
        
        // insert lixi order payment
        //LixiOrderPayment payment = new LixiInvoicePayment();
        //payment.setOrder(orderId);
        //
        System.out.println("###############################################");
        //System.out.println("Order ID: " + orderId);
        if (response!=null) {
            // If API Response is ok, go ahead and check the transaction response
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                TransactionResponse result = response.getTransactionResponse();
                
                System.out.println(result.getResponseCode());
                System.out.println(LiXiUtils.marshalWithoutRootElement(result));
                // log
                if (result.getResponseCode().equals("1")) {
                    System.out.println(result.getResponseCode());
                    System.out.println("Successful Credit Card Transaction");
                    System.out.println(result.getAuthCode());
                    System.out.println(result.getTransId());
                    //
                    returned = true;
                }
                else
                {
                    System.out.println("Failed TransactionResponse: "+result.getResponseCode());
                }
                System.out.println("###############################################");
            }
            else
            {
                System.out.println("Failed Transaction:  "+response.getMessages().getResultCode());
                System.out.println(response.getMessages().getResultCode().value());
                System.out.println(LiXiUtils.marshal(response));
            }
        }
        else{
            
            System.out.println("-999");
            System.out.println("Can not create CreateTransactionResponse");
        }
        //
        //payment.setModifiedDate(Calendar.getInstance().getTime());
        //this.paymentService.save(payment);
        //
        return returned;
    }
    
    /**
     * 
     * @param args 
     */
    public static void main(String[] args) {
        
        CreditCardProcessesTest test = new CreditCardProcessesTest();
        test.setApiLoginId("682rK4FcUpX");
        test.setTransactionKey("2q5V46wSy82uT98L");
        test.setRunMode("PRODUCTION_TESTMODE");
        
        /* 
        User u = new User(999L);
        u.setFirstName("Chon");
        u.setMiddleName("Huu");
        u.setLastName("Nguyen");
        u.setEmail("chonnh@gmail.com");
        u.setPhone("0967007869");
        */
        /* 
        UserCard card = new UserCard();
        card.setCardNumber("4242424242424242");
        card.setExpMonth(8);
        card.setExpYear(2022);
        */
        //test.createCustomerProfile(u, card);
        System.out.println(test.chargeByCustomerProfile("195941546", "189477917"));
    }
}
