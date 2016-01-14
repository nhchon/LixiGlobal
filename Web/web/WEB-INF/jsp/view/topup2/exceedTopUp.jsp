{
    "exceed": "${exceed}",
    "SELECTED_RECIPIENT_ID": "${SELECTED_RECIPIENT_ID}",
    "EXCEEDED_VND": "${EXCEEDED_VND}",
    "EXCEEDED_USD":"${EXCEEDED_USD}",
    "CURRENT_PAYMENT_USD": "${CURRENT_PAYMENT_USD}",
    "CURRENT_PAYMENT_VND": "${CURRENT_PAYMENT_VND}",
    "TOP_UP_AMOUNT": "${TOP_UP_AMOUNT}",
    "TOP_UP_IN_VND": "${TOP_UP_IN_VND}",
    "LIXI_GIFT_PRICE" : "<fmt:formatNumber value="${LIXI_GIFT_PRICE}" pattern="###,###.##"/>",
    "LIXI_GIFT_PRICE_VND" : "<fmt:formatNumber value="${LIXI_GIFT_PRICE_VND}" pattern="###,###.##"/>",
    "LIXI_FINAL_TOTAL" : "<fmt:formatNumber value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/>",
    "LIXI_FINAL_TOTAL_VND" : "<fmt:formatNumber value="${LIXI_FINAL_TOTAL_VND}" pattern="###,###.##"/>",
    "LIXI_HANDLING_FEE" : "<fmt:formatNumber value="${LIXI_HANDLING_FEE}" pattern="###,###.##"/>",
    "LIXI_HANDLING_FEE_TOTAL" : "<fmt:formatNumber value="${LIXI_HANDLING_FEE_TOTAL}" pattern="###,###.##"/>",
    "CARD_PROCESSING_FEE_THIRD_PARTY" : "<fmt:formatNumber value="${CARD_PROCESSING_FEE_THIRD_PARTY}" pattern="###,###.##"/>",
    "message":"<spring:message code="validate.top_up_exceeded"><spring:argument value="${TOP_UP_AMOUNT}"/><spring:argument value="${EXCEEDED_VND}"/><spring:argument value="${EXCEEDED_USD}"/></spring:message>"
}