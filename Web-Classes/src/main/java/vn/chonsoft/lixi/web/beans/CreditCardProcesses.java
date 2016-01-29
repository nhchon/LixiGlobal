/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import net.authorize.Environment;
import net.authorize.api.contract.v1.*;
import net.authorize.api.controller.CreateCustomerPaymentProfileController;
import net.authorize.api.controller.CreateCustomerProfileController;
import net.authorize.api.controller.base.ApiOperationBase;
import net.authorize.api.controller.CreateTransactionController;
import net.authorize.api.controller.GetTransactionDetailsController;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import vn.chonsoft.lixi.model.AuthorizeCustomerResult;
import vn.chonsoft.lixi.model.AuthorizePaymentResult;
import vn.chonsoft.lixi.model.LixiInvoice;
import vn.chonsoft.lixi.model.LixiOrder;
import vn.chonsoft.lixi.model.LixiInvoicePayment;
import vn.chonsoft.lixi.model.LixiOrderCard;
import vn.chonsoft.lixi.model.User;
import vn.chonsoft.lixi.model.UserBankAccount;
import vn.chonsoft.lixi.model.UserCard;
import vn.chonsoft.lixi.EnumTransactionStatus;
import vn.chonsoft.lixi.repositories.service.AuthorizeCustomerResultService;
import vn.chonsoft.lixi.repositories.service.AuthorizePaymentResultService;
import vn.chonsoft.lixi.repositories.service.LixiInvoiceService;
import vn.chonsoft.lixi.repositories.service.LixiOrderPaymentService;
import vn.chonsoft.lixi.repositories.service.UserService;
import vn.chonsoft.lixi.web.LiXiConstants;
import vn.chonsoft.lixi.web.util.LiXiUtils;

/**
 *
 * @author chonnh
 */
public class CreditCardProcesses{

    public enum TransactionResponseCode{
        
        APPROVED("1"),
        DECLINED("2"),
        ERROR("3"),
        HELD_FOR_REVIEW("4");
        
        private final String value;

        private TransactionResponseCode(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }
    
    private static final Logger log = LogManager.getLogger(CreditCardProcesses.class);

    private String apiLoginId;
    private String transactionKey;

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
    private Environment getEnvironment() {

        //SANDBOX, SANDBOX_TESTMODE, PRODUCTION, PRODUCTION_TESTMODE, LOCAL_VM, HOSTED_VM, CUSTOM
        switch (runMode) {
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
     */
    public void updateAllInvoiceStatus(){
        
        List<String> continueStatus = Arrays.asList(EnumTransactionStatus.inProgress.getValue(),
                EnumTransactionStatus.underReview.getValue(),
                EnumTransactionStatus.FDSPendingReview.getValue(),
                EnumTransactionStatus.FDSAuthorizedPendingReview.getValue(),
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
                String responseCode = result.getResponseCode()+"";
                /* update invoice */
                invoice.setNetTransStatus(status);
                invoice.setNetResponseCode(responseCode);
                invoice.setLastCheckDate(Calendar.getInstance().getTime());
                
                this.invoiceService.save(invoice);
                
                log.info("Update invoice id " + invoice.getNetTransId() + " : " + status + " : " + responseCode);
                
            } else {
                log.info("Failed to get transaction details:  " + getResponse.getMessages().getResultCode());
            }
        }
        
    }
    /**
     *
     * Add a new card
     *
     * @param card
     * @return
     */
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
            String resultText = LiXiUtils.marshalWithoutRootElement(response.getMessages());

            payResult.setResponseCode(resultCode);
            payResult.setResponseText(resultText);
            payResult.setCreatedDate(Calendar.getInstance().getTime());

            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {

                // set card payment id
                card.setAuthorizePaymentId(response.getCustomerPaymentProfileId());
                //
                returned = LiXiConstants.OK;
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
            String resultText = LiXiUtils.marshalWithoutRootElement(response.getMessages());

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
                returned = LiXiConstants.OK;
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
            txnRequest.setAmount(new BigDecimal(String.valueOf(lxInvoice.getTotalAmount())));
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
        txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
        txnRequest.setAmount(new BigDecimal(String.valueOf(lxInvoice.getTotalAmount())));
        
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
                if (TransactionResponseCode.APPROVED.getValue().equals(result.getResponseCode()) || TransactionResponseCode.HELD_FOR_REVIEW.getValue().equals(result.getResponseCode())) {
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
            }
            
            payment.setResponseCode(result.getResponseCode());
            payment.setResponseText(LiXiUtils.marshal(response));
            payment.setNetTransId(result.getTransId());
            
            lxInvoice.setNetResponseCode(result.getResponseCode());
            lxInvoice.setNetTransId(result.getTransId());
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
