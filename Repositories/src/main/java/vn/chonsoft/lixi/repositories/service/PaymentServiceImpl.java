/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.repositories.service;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import net.authorize.api.contract.v1.BankAccountType;
import net.authorize.api.contract.v1.BankAccountTypeEnum;
import net.authorize.api.contract.v1.CreateCustomerPaymentProfileRequest;
import net.authorize.api.contract.v1.CreateCustomerPaymentProfileResponse;
import net.authorize.api.contract.v1.CreateCustomerProfileRequest;
import net.authorize.api.contract.v1.CreateCustomerProfileResponse;
import net.authorize.api.contract.v1.CreateTransactionRequest;
import net.authorize.api.contract.v1.CreateTransactionResponse;
import net.authorize.api.contract.v1.CreditCardType;
import net.authorize.api.contract.v1.CustomerAddressType;
import net.authorize.api.contract.v1.CustomerPaymentProfileType;
import net.authorize.api.contract.v1.CustomerProfilePaymentType;
import net.authorize.api.contract.v1.CustomerProfileType;
import net.authorize.api.contract.v1.CustomerTypeEnum;
import net.authorize.api.contract.v1.DeleteCustomerPaymentProfileRequest;
import net.authorize.api.contract.v1.DeleteCustomerPaymentProfileResponse;
import net.authorize.api.contract.v1.GetCustomerPaymentProfileRequest;
import net.authorize.api.contract.v1.GetCustomerPaymentProfileResponse;
import net.authorize.api.contract.v1.GetTransactionDetailsRequest;
import net.authorize.api.contract.v1.GetTransactionDetailsResponse;
import net.authorize.api.contract.v1.MerchantAuthenticationType;
import net.authorize.api.contract.v1.MessageTypeEnum;
import net.authorize.api.contract.v1.MessagesType;
import net.authorize.api.contract.v1.OrderType;
import net.authorize.api.contract.v1.PaymentProfile;
import net.authorize.api.contract.v1.PaymentType;
import net.authorize.api.contract.v1.TransactionDetailsType;
import net.authorize.api.contract.v1.TransactionRequestType;
import net.authorize.api.contract.v1.TransactionResponse;
import net.authorize.api.contract.v1.TransactionTypeEnum;
import net.authorize.api.contract.v1.ValidationModeEnum;
import net.authorize.api.controller.CreateCustomerPaymentProfileController;
import net.authorize.api.controller.CreateCustomerProfileController;
import net.authorize.api.controller.CreateTransactionController;
import net.authorize.api.controller.DeleteCustomerPaymentProfileController;
import net.authorize.api.controller.GetCustomerPaymentProfileController;
import net.authorize.api.controller.GetTransactionDetailsController;
import net.authorize.api.controller.base.ApiOperationBase;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import vn.chonsoft.lixi.EnumLixiOrderStatus;
import vn.chonsoft.lixi.LiXiGlobalConstants;
import vn.chonsoft.lixi.model.AuthorizeCustomerResult;
import vn.chonsoft.lixi.model.AuthorizePaymentResult;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiInvoicePayment;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiOrderCard;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.EnumTransactionResponseCode;
import vn.chonsoft.lixi.EnumTransactionStatus;
import vn.chonsoft.lixi.util.LiXiGlobalUtils;

/**
 *
 * @author chonnh
 */
@Service
@PropertySource(value = { "classpath:authorize.properties"})
public class PaymentServiceImpl implements PaymentService{
    
    private static final Logger log = LogManager.getLogger(PaymentServiceImpl.class);
    
    @Autowired
    private Environment env;
    
    @Value("${authorize.net.api_login_id}")
    private String apiLoginId;
    
    @Value("${authorize.net.transaction_key}")
    private String transactionKey = null;

    @Value("${authorize.net.run_mode}")
    private String runMode = "SANDBOX";

    @Autowired
    private LixiOrderPaymentService paymentService;

    @Autowired
    private AuthorizeCustomerResultService customerResultService;

    @Autowired
    private AuthorizePaymentResultService paymentResultService;

    @Autowired
    private UserService userService;

    @Autowired
    private LixiInvoiceService invoiceService;
    
    @Autowired
    private LixiOrderService orderService;

    /**
     * 
     * http://stackoverflow.com/questions/17097521/spring-3-2-value-annotation-
     * with-pure-java-configuration-does-not-work-but-env
     * 
     * @return 
     */
    @Bean
    public static PropertySourcesPlaceholderConfigurer propertyPlaceholderConfigurer() {
        return new PropertySourcesPlaceholderConfigurer();
    }

    private void checkInit(){
        
        if(apiLoginId == null){
            
            apiLoginId = env.getProperty("authorize.net.api_login_id");
            transactionKey = env.getProperty("authorize.net.transaction_key");
            runMode = env.getProperty("authorize.net.run_mode");
            
            log.info("===> PaymentServiceImpl init : " + apiLoginId);
        }
    }
    /**
     *
     * @return
     */
    private net.authorize.Environment getEnvironment() {

        //SANDBOX, SANDBOX_TESTMODE, PRODUCTION, PRODUCTION_TESTMODE, LOCAL_VM, HOSTED_VM, CUSTOM
        switch (runMode) {
            case "PRODUCTION":
                return net.authorize.Environment.PRODUCTION;
            case "PRODUCTION_TESTMODE":
                return net.authorize.Environment.PRODUCTION_TESTMODE;
            case "LOCAL_VM":
                return net.authorize.Environment.LOCAL_VM;
            case "HOSTED_VM":
                return net.authorize.Environment.HOSTED_VM;
            case "CUSTOM":
                return net.authorize.Environment.CUSTOM;
            case "SANDBOX_TESTMODE":
                return net.authorize.Environment.SANDBOX_TESTMODE;
            default:
                return net.authorize.Environment.SANDBOX;
        }
    }

    /**
     * 
     */
    @Override
    @Scheduled(fixedDelay=1*60*60*1000, initialDelay=60*1000)
    public void updateAllInvoiceStatus(){
        
        List<String> continueStatus = Arrays.asList(EnumTransactionStatus.inProgress.getValue(),
                EnumTransactionStatus.underReview.getValue(),
                EnumTransactionStatus.FDSPendingReview.getValue(),
                EnumTransactionStatus.FDSAuthorizedPendingReview.getValue(),
                EnumTransactionStatus.approvedReview.getValue(),
                EnumTransactionStatus.refundPendingSettlement.getValue(),
                EnumTransactionStatus.authorizedPendingCapture.getValue(),
                EnumTransactionStatus.capturedPendingSettlement.getValue()
                );
        List<LixiInvoice> invoices = this.invoiceService.findByNetTransStatusIn(continueStatus);
        
        log.info("========================> Update invoices at " + Calendar.getInstance().getTime());
        
        if(invoices!=null && !invoices.isEmpty()){
            
            for(LixiInvoice invoice : invoices){
                updateInvoiceStatus(invoice);
            }
        }
        else{
            log.info("No invoice to update");
        }
    }
    
    @Override
    public void updateInvoiceStatus(LixiInvoice invoice){
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        GetTransactionDetailsRequest getRequest = new GetTransactionDetailsRequest();
        getRequest.setMerchantAuthentication(merchantAuthenticationType);
        getRequest.setTransId(invoice.getNetTransId());

        GetTransactionDetailsController controller = new GetTransactionDetailsController(getRequest);
        controller.execute();
        GetTransactionDetailsResponse getResponse = controller.getApiResponse();

        if (getResponse != null) {

            if (getResponse.getMessages().getResultCode() == MessageTypeEnum.OK) {

                TransactionDetailsType result = getResponse.getTransaction();

                String status = result.getTransactionStatus();
                String translateStatus = LiXiGlobalUtils.translateNetTransStatus(status);
                String responseCode = result.getResponseCode()+"";
                /* update invoice */
                invoice.setNetTransStatus(status);
                invoice.setInvoiceStatus(translateStatus);
                invoice.setNetResponseCode(responseCode);
                invoice.setLastCheckDate(Calendar.getInstance().getTime());
                
                this.invoiceService.save(invoice);
                
                if(LiXiGlobalConstants.TRANS_STATUS_PROCESSED.equals(translateStatus)){
                    
                    LixiOrder order = this.orderService.findById(invoice.getOrder().getId());
                    order.setLixiStatus(EnumLixiOrderStatus.PROCESSED.getValue());
                    order.setLixiSubStatus(EnumLixiOrderStatus.GiftStatus.UN_SUBMITTED.getValue());
                    /* update order to processed */
                    this.orderService.save(order);
                }
                
                log.info("Update invoice id " + invoice.getNetTransId() + " : " + translateStatus + " : " + status + " : " + responseCode);
                
            } else {
                log.info("Failed to get transaction details:  " + getResponse.getMessages().getResultCode());
            }
        }
        
    }
    
    /**
     * 
     * @param invoice
     * @return String "1", "3"
     */
    @Override
    public String voidTransaction(LixiInvoice invoice){
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        // Create the payment transaction request
        TransactionRequestType txnRequest = new TransactionRequestType();
        txnRequest.setTransactionType(TransactionTypeEnum.VOID_TRANSACTION.value());
        txnRequest.setRefTransId(invoice.getNetTransId());

        // Make the API Request
        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setTransactionRequest(txnRequest);
        CreateTransactionController controller = new CreateTransactionController(apiRequest);
        controller.execute(); 

        CreateTransactionResponse response = controller.getApiResponse();

        if (response!=null) {

            // If API Response is ok, go ahead and check the transaction response
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                TransactionResponse result = response.getTransactionResponse();
                if (result.getResponseCode().equals("1")) {
                    System.out.println(result.getResponseCode());
                    System.out.println("Successfully Voided Transaction");
                    System.out.println(result.getAuthCode());
                    System.out.println(result.getTransId());
                    invoice.setNetTransStatus(EnumTransactionStatus.voided.getValue());
                    invoice.setInvoiceStatus(LiXiGlobalUtils.translateNetTransStatus(invoice.getNetTransStatus()));
                    
                    this.invoiceService.save(invoice);
                    
                    return "1";
                }
                else
                {
                    System.out.println("Failed Transaction"+result.getResponseCode());
                    System.out.println("Failed Transaction"+result.getMessages().getMessage().get(0).getDescription());
                    return "3";
                }
            }
            else
            {
                System.out.println("Failed Transaction:  "+response.getMessages().getResultCode());
                System.out.println("Failed Transaction"+response.getMessages().getMessage().get(0).getText());
                return "3";
            }
        }
        /* */
        return "3";
    }
    /**
     * 
     * @param card 
     */
    @Override
    public void getPaymentProfile(UserCard card){
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        GetCustomerPaymentProfileRequest apiRequest = new GetCustomerPaymentProfileRequest();
        apiRequest.setCustomerProfileId(card.getUser().getAuthorizeProfileId());
        apiRequest.setCustomerPaymentProfileId(card.getAuthorizePaymentId());

        GetCustomerPaymentProfileController controller = new GetCustomerPaymentProfileController(apiRequest);
        controller.execute();

        GetCustomerPaymentProfileResponse response = new GetCustomerPaymentProfileResponse();
        response = controller.getApiResponse();

        if (response != null) {

            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                //System.out.println(response.getMessages().getMessage().get(0).getCode());
                //System.out.println(response.getMessages().getMessage().get(0).getText());

                //System.out.println(response.getPaymentProfile().getBillTo().getFirstName());
                //System.out.println(response.getPaymentProfile().getBillTo().getLastName());
                //System.out.println(response.getPaymentProfile().getBillTo().getCompany());
                //System.out.println(response.getPaymentProfile().getBillTo().getAddress());
                //System.out.println(response.getPaymentProfile().getBillTo().getCity());
                //System.out.println(response.getPaymentProfile().getBillTo().getState());
                //System.out.println(response.getPaymentProfile().getBillTo().getZip());
                //System.out.println(response.getPaymentProfile().getBillTo().getCountry());
                //System.out.println(response.getPaymentProfile().getBillTo().getPhoneNumber());
                //System.out.println(response.getPaymentProfile().getBillTo().getFaxNumber());

                //System.out.println(response.getPaymentProfile().getCustomerPaymentProfileId());

                //System.out.println(response.getPaymentProfile().getPayment().getCreditCard().getCardNumber());
                //System.out.println(response.getPaymentProfile().getPayment().getCreditCard().getExpirationDate());
                
                card.setCardNumber(response.getPaymentProfile().getPayment().getCreditCard().getCardNumber());
            } else {
                log.info("Failed to get customer payment profile:  " + response.getMessages().getResultCode());
                log.info("Failed to get customer payment profile:  " + response.getMessages().getMessage().get(0).getText());
            }
        }
    }
    
    /**
     * 
     * @param card 
     */
    @Override
    public void deletePaymentProfile(UserCard card){

        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        DeleteCustomerPaymentProfileRequest apiRequest = new DeleteCustomerPaymentProfileRequest();
        apiRequest.setCustomerProfileId(card.getUser().getAuthorizeProfileId());
        apiRequest.setCustomerPaymentProfileId(card.getAuthorizePaymentId());

        DeleteCustomerPaymentProfileController controller = new DeleteCustomerPaymentProfileController(apiRequest);
        controller.execute();

        DeleteCustomerPaymentProfileResponse response = new DeleteCustomerPaymentProfileResponse();
        response = controller.getApiResponse();

        if (response != null) {
            
            log.info("=========================================================");
            log.info("Delete card id: " + card.getId());
            
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {
                
                log.info(response.getMessages().getMessage().get(0).getCode());
                log.info(response.getMessages().getMessage().get(0).getText());
            } else {
                log.info("Failed to delete customer payment profile:  " + response.getMessages().getResultCode());
                log.info(response.getMessages().getMessage().get(0).getText());
            }
            log.info("=========================================================");
        }
    }
    
    /**
     *
     * Add a new card
     *
     * @param card
     * @return
     */
    @Override
    public String createPaymentProfile(UserCard card) {
        
        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        /* Credit card*/
        CreditCardType creditCard = new CreditCardType();
        creditCard.setCardNumber(card.getCardNumber());
        String expireMonth = StringUtils.leftPad(card.getExpMonth() + "", 2, "0");
        String expireYear = StringUtils.leftPad(card.getExpYear() + "", 2, "0");
        creditCard.setExpirationDate(expireMonth + expireYear);

        /* Payment */
        PaymentType paymentType = new PaymentType();
        paymentType.setCreditCard(creditCard);

        /* Billing Address*/
        CustomerAddressType billingInfo = new CustomerAddressType();
        billingInfo.setFirstName(card.getBillingAddress().getFirstName());
        billingInfo.setLastName(card.getBillingAddress().getLastName());
        billingInfo.setAddress(card.getBillingAddress().getAddress());
        billingInfo.setCity(card.getBillingAddress().getCity());
        billingInfo.setState(card.getBillingAddress().getState());
        billingInfo.setCountry(card.getBillingAddress().getCountry());
        billingInfo.setZip(card.getBillingAddress().getZipCode());
        billingInfo.setPhoneNumber(card.getUser().getPhone());
        billingInfo.setFaxNumber(card.getUser().getPhone());

        /* Payment */
        CustomerPaymentProfileType customerPaymentProfileType = new CustomerPaymentProfileType();
        customerPaymentProfileType.setCustomerType(CustomerTypeEnum.INDIVIDUAL);
        customerPaymentProfileType.setPayment(paymentType);
        customerPaymentProfileType.setBillTo(billingInfo);

        CreateCustomerPaymentProfileRequest apiRequest = new CreateCustomerPaymentProfileRequest();
        apiRequest.setMerchantAuthentication(merchantAuthenticationType);
        apiRequest.setCustomerProfileId(card.getUser().getAuthorizeProfileId());
        apiRequest.setPaymentProfile(customerPaymentProfileType);

        CreateCustomerPaymentProfileController controller = new CreateCustomerPaymentProfileController(apiRequest);
        controller.execute();

        CreateCustomerPaymentProfileResponse response = new CreateCustomerPaymentProfileResponse();
        response = controller.getApiResponse();

        /* Handle result */
        AuthorizePaymentResult payResult = new AuthorizePaymentResult();
        String cardInfo = "["+StringUtils.right(card.getCardNumber(), 4) + "-"+card.getExpMonth()+"-"+card.getExpYear()+"]";
        payResult.setCardInfo(cardInfo);
        String returned = "";
        if (response != null) {

            String resultCode = response.getMessages().getResultCode().value();
            String resultText = LiXiGlobalUtils.marshalWithoutRootElement(response.getMessages());

            payResult.setResponseCode(resultCode);
            payResult.setResponseText(resultText);
            payResult.setCreatedDate(Calendar.getInstance().getTime());

            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                // set card payment id
                card.setAuthorizePaymentId(response.getCustomerPaymentProfileId());
                //
                returned = LiXiGlobalConstants.OK;
            } else {

                System.out.println("Failed to create payment profile:  " + response.getMessages().getResultCode());
                for (MessagesType.Message m : response.getMessages().getMessage()) {
                    returned += ("<div>" + m.getCode() + " : " + m.getText() + "</div>");
                }
            }
        } else {

            payResult.setResponseCode("-999");
            payResult.setResponseText("CAN NOT CREATE CreateCustomerPaymentProfileResponse");
            //
            returned = "There was a problem with your card information";
        }

        // save
        payResult.setCreatedDate(Calendar.getInstance().getTime());
        this.paymentResultService.save(payResult);

        /* update authorize.net payment id */
        //this.cardService.updateAuthorizeProfileId(card.getAuthorizePaymentId(), card.getId());

        // return
        return returned;

    }

    /**
     *
     * @param u
     * @param card
     * @return
     */
    @Override
    public String createCustomerProfile(User u, UserCard card) {

        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        /* Credit card*/
        CreditCardType creditCard = new CreditCardType();
        creditCard.setCardNumber(card.getCardNumber());
        String expireMonth = StringUtils.leftPad(card.getExpMonth() + "", 2, "0");
        String expireYear = StringUtils.leftPad(card.getExpYear() + "", 2, "0");
        creditCard.setExpirationDate(expireMonth + expireYear);
        PaymentType paymentType = new PaymentType();
        paymentType.setCreditCard(creditCard);

        /* Billing Address*/
        CustomerAddressType billingInfo = new CustomerAddressType();
        billingInfo.setFirstName(card.getBillingAddress().getFirstName());
        billingInfo.setLastName(card.getBillingAddress().getLastName());
        billingInfo.setAddress(card.getBillingAddress().getAddress());
        billingInfo.setCity(card.getBillingAddress().getCity());
        billingInfo.setState(card.getBillingAddress().getState());
        billingInfo.setCountry(card.getBillingAddress().getCountry());
        billingInfo.setZip(card.getBillingAddress().getZipCode());
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
        apiRequest.setRefId(System.currentTimeMillis() + "");

        CreateCustomerProfileController controller = new CreateCustomerProfileController(apiRequest);
        controller.execute();

        /* Get response*/
        CreateCustomerProfileResponse response = controller.getApiResponse();

        /* Handle result */
        AuthorizeCustomerResult cus = new AuthorizeCustomerResult();
        cus.setUserId(u.getId());
        String returned = "";
        if (response != null) {

            String resultCode = response.getMessages().getResultCode().value();
            String resultText = LiXiGlobalUtils.marshalWithoutRootElement(response.getMessages());

            cus.setResponseCode(resultCode);
            cus.setResponseText(resultText);
            cus.setCreatedDate(Calendar.getInstance().getTime());

            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                // update customer profile id
                this.userService.updateAuthorizeProfileId(response.getCustomerProfileId(), u.getId());
                // set card payment id
                card.setAuthorizePaymentId(response.getCustomerPaymentProfileIdList().getNumericString().get(0));
                //for(String s : response.getCustomerPaymentProfileIdList().getNumericString()){
                //card.setAuthorizePaymentId(s);
                //}
                //this.cardService.save(card);

                // return
                returned = LiXiGlobalConstants.OK;
            } else {

                System.out.println("Failed to create customer profile:  " + response.getMessages().getResultCode());
                for (MessagesType.Message m : response.getMessages().getMessage()) {
                    returned += ("<div>" + m.getCode() + " : " + m.getText() + "</div>");
                }
            }
        } else {

            cus.setResponseCode("-999");
            cus.setResponseText("CAN NOT CREATE CreateCustomerProfileResponse");
            //
            returned = "There was a problem with your card information";
        }

        // save
        cus.setCreatedDate(Calendar.getInstance().getTime());
        this.customerResultService.save(cus);

        // return
        return returned;
    }

    /**
     *
     * @param lxInvoice
     * @return
     */
    @Override
    public boolean charge(LixiInvoice lxInvoice) {

        LixiOrder order = lxInvoice.getOrder();

        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        // Populate the payment data
        PaymentType paymentType = new PaymentType();
        TransactionRequestType txnRequest = new TransactionRequestType();
        if (order.getCard() != null) {
            // get credit card
            LixiOrderCard card = order.getCard();
            String expireMonth = StringUtils.leftPad(card.getExpMonth() + "", 2, "0");
            String expireYear = StringUtils.leftPad(card.getExpYear() + "", 2, "0");

            CreditCardType creditCard = new CreditCardType();
            creditCard.setCardNumber(card.getCardNumber()); // 4242424242424242
            creditCard.setExpirationDate(expireMonth + expireYear); // // 0822
            paymentType.setCreditCard(creditCard);

            // Create the payment transaction request
            txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
            txnRequest.setPayment(paymentType);
            txnRequest.setAmount(new BigDecimal(String.valueOf(LiXiGlobalUtils.getTestTotalAmount(lxInvoice.getTotalAmount()))));
        } else // paid by banking account
        if (order.getBankAccount() != null) {

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
            txnRequest.setAmount(new BigDecimal(String.valueOf(lxInvoice.getTotalAmount())));
        }
        // Order
        OrderType invoice = new OrderType();
        invoice.setInvoiceNumber(lxInvoice.getId().toString() );
        invoice.setDescription("["
                + lxInvoice.getId() + ", "
                + order.getId() + ", "
                + order.getSender().getId() + ", "
                + order.getSender().getFullName() + ", "
                + order.getSender().getEmail()
                + "]");
        //
        txnRequest.setOrder(invoice);
        txnRequest.setRefTransId(Long.toString(System.currentTimeMillis()));

        // Make the API Request
        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setTransactionRequest(txnRequest);
        apiRequest.setRefId("LG" + System.currentTimeMillis());
        CreateTransactionController controller = new CreateTransactionController(apiRequest);
        controller.execute();

        CreateTransactionResponse response = controller.getApiResponse();

        return handleTransactionResponse(response, lxInvoice);
    }

    /**
     *
     * @param lxInvoice
     * @return
     */
    @Override
    public boolean chargeByCustomerProfile(LixiInvoice lxInvoice) {

        /* get order */
        LixiOrder order = lxInvoice.getOrder();

        //Common code to set for all requests
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        /* Create the payment transaction request */
        TransactionRequestType txnRequest = new TransactionRequestType();
        txnRequest.setTransactionType(TransactionTypeEnum.AUTH_ONLY_TRANSACTION.value());//AUTH_CAPTURE_TRANSACTION
        txnRequest.setAmount(new BigDecimal(String.valueOf(LiXiGlobalUtils.getTestTotalAmount(lxInvoice.getTotalAmount()))));
        
        //
        log.info("invoice: " + lxInvoice.getId() + " - " + String.valueOf(lxInvoice.getTotalAmount()));
        //
        
        PaymentProfile paymentProfile = new PaymentProfile();
        paymentProfile.setPaymentProfileId(order.getCard().getAuthorizePaymentId());

        CustomerProfilePaymentType pay = new CustomerProfilePaymentType();
        pay.setPaymentProfile(paymentProfile);
        pay.setCustomerProfileId(order.getSender().getAuthorizeProfileId());

        txnRequest.setProfile(pay);

        /* Order information */
        OrderType invoice = new OrderType();
        invoice.setInvoiceNumber(lxInvoice.getId().toString());
        invoice.setDescription("["
                + lxInvoice.getId() + ", "
                + order.getId() + ", "
                + order.getSender().getId() + ", "
                + order.getSender().getFullName() + ", "
                + order.getSender().getEmail()
                + "]");
        txnRequest.setOrder(invoice);

        /* RefId*/
        txnRequest.setRefTransId(Long.toString(System.currentTimeMillis()));

        /**/
        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setTransactionRequest(txnRequest);

        /* */
        CreateTransactionController controller = new CreateTransactionController(apiRequest);
        controller.execute();

        /* get transaction response */
        CreateTransactionResponse response = controller.getApiResponse();

        /* handle and return*/
        return handleTransactionResponse(response, lxInvoice);
    }

    @Override
    public boolean capturePreviouslyAuthorizedAmount(LixiInvoice lxInvoice){
        
        ApiOperationBase.setEnvironment(getEnvironment());

        MerchantAuthenticationType merchantAuthenticationType  = new MerchantAuthenticationType() ;
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);
        ApiOperationBase.setMerchantAuthentication(merchantAuthenticationType);

        // Create the payment transaction request
        TransactionRequestType txnRequest = new TransactionRequestType();
        txnRequest.setTransactionType(TransactionTypeEnum.PRIOR_AUTH_CAPTURE_TRANSACTION.value());
        txnRequest.setRefTransId(lxInvoice.getNetTransId());

        // Make the API Request
        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setTransactionRequest(txnRequest);
        CreateTransactionController controller = new CreateTransactionController(apiRequest);
        controller.execute(); 

        CreateTransactionResponse response = controller.getApiResponse();
        
        /* handle and return*/
        return handleTransactionResponse(response, lxInvoice);
    }
    
    /**
     *
     * @param response
     * @return
     */
    private boolean handleTransactionResponse(CreateTransactionResponse response, LixiInvoice lxInvoice) {
        // return value
        boolean returned = false;

        // insert lixi order payment
        LixiInvoicePayment payment = new LixiInvoicePayment();
        payment.setInvoice(lxInvoice.getId());
        //
        log.info("###############################################");
        log.info("Invoice ID: " + lxInvoice.getId());
        if (response != null) {
            // If API Response is ok, go ahead and check the transaction response
            TransactionResponse result = response.getTransactionResponse();
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                // log
                if (EnumTransactionResponseCode.APPROVED.getValue().equals(result.getResponseCode()) || EnumTransactionResponseCode.HELD_FOR_REVIEW.getValue().equals(result.getResponseCode())) {
                    log.info(result.getResponseCode());
                    log.info("Successful Credit Card Transaction");
                    log.info(result.getAuthCode());
                    log.info(result.getTransId());
                    //

                    returned = true;
                } else {
                    log.info("Failed TransactionResponse: " + result.getResponseCode());
                }
                log.info("###############################################");
            } else {
                log.info("Failed Transaction:  " + response.getMessages().getResultCode());
                log.info("Failed Transaction:  " + response.getMessages().getMessage().get(0).getText());
            }
            
            payment.setResponseCode(result.getResponseCode());
            payment.setResponseText(LiXiGlobalUtils.marshal(response));
            payment.setNetTransId(result.getTransId());
            
            lxInvoice.setNetResponseCode(result.getResponseCode());
            lxInvoice.setNetTransId(result.getTransId());
            lxInvoice.setNetTransStatus(EnumTransactionStatus.getStatusFromResponseCode(result.getResponseCode()).getValue());
            lxInvoice.setInvoiceStatus(LiXiGlobalUtils.translateNetTransStatus(lxInvoice.getNetTransStatus()));
        } else {

            payment.setResponseCode("-999");
            payment.setResponseText("Can not create CreateTransactionResponse");
        }
        //
        payment.setModifiedDate(Calendar.getInstance().getTime());
        this.paymentService.save(payment);
        //
        this.invoiceService.save(lxInvoice);

        return returned;
    }
    
    
}
