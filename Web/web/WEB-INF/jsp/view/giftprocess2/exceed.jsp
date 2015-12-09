{
    "exceed": "${exceed}",
    "EXCEEDED_VND": "<fmt:formatNumber value="${EXCEEDED_VND}" pattern="###,###.##"/>",
    "EXCEEDED_USD":"<fmt:formatNumber value="${EXCEEDED_USD}" pattern="###,###.##"/>",
    "RECIPIENT_PAYMENT_USD": "<fmt:formatNumber value="${RECIPIENT_PAYMENT_USD}" pattern="###,###.##"/>",
    "RECIPIENT_PAYMENT_VND": "<fmt:formatNumber value="${RECIPIENT_PAYMENT_VND}" pattern="###,###.##"/>",
    "CURRENT_PAYMENT_USD": "<fmt:formatNumber value="${CURRENT_PAYMENT_USD}" pattern="###,###.##"/>",
    "CURRENT_PAYMENT_VND": "<fmt:formatNumber value="${CURRENT_PAYMENT_VND}" pattern="###,###.##"/>",
    "SELECTED_PRODUCT_ID": "${SELECTED_PRODUCT_ID}",
    "SELECTED_PRODUCT_QUANTITY": "${SELECTED_PRODUCT_QUANTITY}",
    "message":"<spring:message code="validate.exceeded"><spring:argument value="${EXCEEDED_VND}"/><spring:argument value="${EXCEEDED_USD}"/></spring:message>"
}