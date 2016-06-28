<div id="detailStatusOrder${m.key.id}" style="display:none;" class="table-responsive">
    <table class="table table-hover table-responsive table-striped" style="font-size: 12px;">
        <thead>
            <tr>
                <th nowrap>Receiver</th><%-- 1 --%>
                <th nowrap>Item</th><%-- 2 --%>
                <th nowrap>Description</th><%-- 3 --%>
                <th nowrap style="text-align:center;">Method</th>
                <th style="text-align:right;">Status</th><%-- 4 --%>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${m.value}" var="rio" varStatus="theCount">
                <tr>
                    <td  colspan="5" nowrap>${rio.recipient.fullName}</td>
                </tr>
                <c:forEach items="${rio.gifts}" var="g" varStatus="theCount2">
                    <tr>
                        <td># ${g.id}</td>
                        <td>${g.productQuantity}</td>
                        <td>${g.productName}</td>
                        <td style="text-align: center;" nowrap>
                            <c:choose>
                                <c:when test="${g.bkReceiveMethod eq 'MONEY'}">
                                    <b>Refunded</b>
                                </c:when>
                                <c:when test="${g.bkReceiveMethod eq 'GIFT'}">
                                    <b>Gifted</b>
                                </c:when>
                                <c:otherwise>
                                    <b>${g.bkReceiveMethod}</b>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${fn:startsWith(g.bkUpdated, '0000')}">
                                </c:when>
                                <c:otherwise>
                                    <br/>${g.bkUpdated}
                                </c:otherwise>
                            </c:choose>                                        
                                    
                        </td>
                        <td style="text-align:right;">
                            <c:choose>
                                <c:when test="${g.bkStatus eq '0'}">
                                    <span class="alert-danger">Processing</span>
                                </c:when>
                                <c:when test="${g.bkStatus eq '1'}">
                                    <span class="alert-success">Completed</span>
                                </c:when>
                                <c:when test="${g.bkStatus eq '2'}">
                                    <span class="alert-warning">Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="alert-danger">${g.bkStatus}</span>
                                </c:otherwise>
                            </c:choose>
                            <br/>
                            <br/>
                        </td>
                    </tr>
                </c:forEach>
                <c:forEach items="${rio.topUpMobilePhones}" var="t">
                    <tr>
                        <td># ${t.id}</td>
                        <td>1</td>
                        <td colspan="2">Top Up Mobile: ${t.phone}</td>
                        <td style="text-align:right;">

                            <c:choose>
                                <c:when test="${t.status eq UN_SUBMITTED}">
                                    <span class="alert-danger">Not Sent</span>
                                </c:when>
                                <c:when test="${t.status eq COMPLETED}">
                                    <span class="alert-success">Completed</span>
                                </c:when>
                                <c:when test="${t.status eq CANCELED}">
                                    <span class="alert-warning">Canceled</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="alert-danger">${t.status}</span>
                                </c:otherwise>
                            </c:choose>

                        </td>
                    </tr>
                </c:forEach>
            </c:forEach>
        </tbody>
    </table>
</div>
