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

    begin("begin"),
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
}
