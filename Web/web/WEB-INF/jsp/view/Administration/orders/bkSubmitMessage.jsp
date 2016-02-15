<c:forEach items="${rios}" var="rio">
    <c:if test="${not empty rio.gifts}">
        <c:choose>
            <c:when test="${rio.bkStatus eq 'Not Sent'}">
                <span class="alert-danger">${rio.bkStatus}</span>
            </c:when>
            <c:otherwise>
                <span class="alert-success">${rio.bkStatus}</span>
            </c:otherwise>
        </c:choose>
        <br/>
        <br/>
    </c:if>
</c:forEach>