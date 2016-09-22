<c:choose>
    <c:when test="${m.key.lixiStatus eq PROCESSING}">
        Processing<br/>
        <c:if test="${m.key.lixiSubStatus eq SENT_MONEY}">(Sent Money)</c:if>
        <c:if test="${m.key.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
    </c:when>
    <c:when test="${m.key.lixiStatus eq COMPLETED}">
        Completed
    </c:when>
    <c:when test="${m.key.lixiStatus eq CANCELED}">
        Cancelled
    </c:when>
    <c:when test="${m.key.lixiStatus eq PURCHASED}">
        Purchased
    </c:when>
    <c:when test="${m.key.lixiStatus eq DELIVERED}">
        Delivered
    </c:when>
    <c:when test="${m.key.lixiStatus eq UNDELIVERABLE}">
        Undeliverable
    </c:when>
    <c:when test="${m.key.lixiStatus eq REFUNDED}">
        Refunded
    </c:when>
    <c:otherwise>
        ${m.key.lixiStatus}
    </c:otherwise>
</c:choose>
