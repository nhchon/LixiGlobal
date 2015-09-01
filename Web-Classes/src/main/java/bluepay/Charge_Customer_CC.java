/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package bluepay;

import java.util.HashMap; 
/**
 *
 * @author chonnh
 */
public class Charge_Customer_CC {

    public static void main(String[] args) {

        String ACCOUNT_ID = "100253216562";
        String SECRET_KEY = "ZKHVRHGRHVFKHL0SEHCESBIHUGNAIMD4";
        String MODE = "TEST";

        BluePay payment = new BluePay(
                ACCOUNT_ID,
                SECRET_KEY,
                MODE
        );

        // Set Customer Information  
        HashMap<String, String> customerParams = new HashMap<>();
        customerParams.put("firstName", "Bob");
        customerParams.put("lastName", "Tester");
        customerParams.put("address1", "123 Test St.");
        customerParams.put("address2", "Apt #500");
        customerParams.put("city", "Testville");
        customerParams.put("state", "IL");
        customerParams.put("zip", "54321");
        customerParams.put("country", "USA");
        customerParams.put("phone", "123-123-12345");
        customerParams.put("email", "test@bluepay.com");
        payment.setCustomerInformation(customerParams);

        // Set Credit Card Information
        HashMap<String, String> ccParams = new HashMap<>();
        ccParams.put("cardNumber", "411111111111111111");
        ccParams.put("expirationDate", "1215");
        ccParams.put("cvv2", "123");
        payment.setCCInformation(ccParams);

        // Set sale amount: $3.00
        HashMap<String, String> saleParams = new HashMap<>();
        saleParams.put("amount", "0.00");
        payment.sale(saleParams);

        // Makes the API Request with BluePay
        try {
            payment.process();
        } catch (Exception ex) {
            System.out.println("Exception: " + ex.toString());
            System.exit(1);
        }

        // If transaction was successful reads the responses from BluePay
        if (payment.isSuccessful()) {
            System.out.println("Transaction Status: " + payment.getStatus());
            System.out.println("Transaction Message: " + payment.getMessage());
            System.out.println("Transaction ID: " + payment.getTransID());
            System.out.println("AVS Response: " + payment.getAVS());
            System.out.println("CVV2 Response: " + payment.getCVV2());
            System.out.println("Masked Payment Account: " + payment.getMaskedPaymentAccount());
            System.out.println("Card Type: " + payment.getCardType());
            System.out.println("Authorization Code: " + payment.getAuthCode());
            System.out.println("BankName: " + payment.getBankName());
        } else {
            System.out.println("Error: " + payment.getMessage());
        }
    }
}
