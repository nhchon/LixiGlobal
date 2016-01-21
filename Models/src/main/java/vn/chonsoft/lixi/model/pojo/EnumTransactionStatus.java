/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public enum EnumTransactionStatus {

    beforePayment("beforePayment"),
    paymentError("paymentError"),
    inProgress("inProgress"),
    authorizedPendingCapture("authorizedPendingCapture"),
    capturedPendingSettlement("capturedPendingSettlement"),
    communicationError("communicationError"),
    refundSettledSuccessfully("refundSettledSuccessfully"),
    refundPendingSettlement("refundPendingSettlement"),
    approvedReview("approvedReview"),
    declined("declined"),
    couldNotVoid("couldNotVoid"),
    expired("expired"),
    generalError("generalError"),
    failedReview("failedReview"),
    settledSuccessfully("settledSuccessfully"),
    settlementError("settlementError"),
    underReview("underReview"),
    voided("voided"),
    voidedByUser("voidedByUser"),
    FDSPendingReview("FDSPendingReview"),
    FDSAuthorizedPendingReview("FDSAuthorizedPendingReview"),
    returnedItem("returnedItem");

    private final String value;

    private EnumTransactionStatus(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
    
    public static EnumTransactionStatus getStatusFromResponseCode(String code){
        
        if("1".equals(code) || "4".equals(code)){
            return EnumTransactionStatus.inProgress;
        }
        else{
            return EnumTransactionStatus.declined;
        }
    }
    
}
