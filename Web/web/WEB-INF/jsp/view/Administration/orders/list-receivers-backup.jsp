        <h3>Receivers</h3>
        <div class="row">
            <div class="col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover table-responsive table-striped">
                        <thead>
                            <tr>
                                <th nowrap>#</th><%-- 1 --%>
                                <th nowrap>First Name</th><%-- 2 --%>
                                <th nowrap>Middle Name</th><%-- 3 --%>
                                <th nowrap>Last Name</th><%-- 4 --%>
                                <th nowrap>Email</th><%-- 5 --%>
                                <th nowrap>Phone</th><%-- 6 --%>
                                <th nowrap>Created Date</th><%-- 7 --%>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sender.recipients}" var="r">
                                <tr>
                                    <td>${r.id}</td><%-- 1 --%>
                                    <td>${r.firstName}</td><%-- 2 --%>
                                    <td>${r.middleName}</td><%-- 3 --%>
                                    <td>${r.lastName}</td><%-- 4 --%>
                                    <td>${r.email}</td><%-- 5 --%>
                                    <td>(${r.dialCode})&nbsp; ${r.phone}</td><%-- 6 --%>
                                    <td><fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${r.modifiedDate}"/></td>
                                </tr>

                                <c:forEach items="${r.processedOrders}" var="pO">
                                    <tr>
                                        <td colspan="7">
                                            <h4>Order #${pO.invoice.invoiceCode} </h4>
                                            <table class="table table-hover table-responsive table-striped" style="width:50%;">
                                                <thead>
                                                    <tr>
                                                        <th nowrap>Order</th><%-- 1 --%>
                                                        <th nowrap>Date</th><%-- 2 --%>
                                                        <th nowrap>Transaction No</th><%-- 3 --%>
                                                        <th nowrap>Option</th><%-- 4 --%>
                                                        <th>Status</th><%-- 5 --%>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td nowrap>
                                                            <a href="<c:url value="/Administration/Orders/detail/${pO.id}"/>">
                                                                ${pO.invoice.invoiceCode}
                                                            </a>
                                                            <br/>
                                                            1 USD = ${pO.lxExchangeRate.buy} VND
                                                        </td>
                                                        <td><fmt:formatDate pattern="MM/dd/yyyy" value="${pO.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${pO.createdDate}"/></td>
                                                        <td>${pO.invoice.netTransId} <br/>(${pO.invoice.translatedStatus})</td>
                                                        <td nowrap>
                                                            <c:if test="${pO.setting eq 0}">
                                                                Gift Only
                                                            </c:if>
                                                            <c:if test="${pO.setting eq 1}">
                                                                Allow Refund
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <c:if test="${pO.lixiStatus eq PROCESSED}">
                                                                Processed<br/>
                                                                <c:if test="${pO.lixiSubStatus eq SENT_MONEY}">(Sent Money)</c:if>
                                                                <c:if test="${pO.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                                            </c:if>
                                                            <c:if test="${pO.lixiStatus eq COMPLETED}">
                                                                Completed
                                                            </c:if>
                                                            <c:if test="${pO.lixiStatus eq CANCELED}">
                                                                Cancelled
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="table table-hover table-responsive table-striped" style="margin-bottom:0px;">
                                                <c:forEach items="${pO.gifts}" var="g" varStatus="theCount2">
                                                    <c:if test="${g.recipient.id eq r.id}">
                                                    <tr>
                                                        <td></td>
                                                        <td>${g.productQuantity}</td>
                                                        <td>${g.productName}</td>
                                                        <td style="text-align: right;">
                                                            <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND
                                                            <br/>
                                                            <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/> USD
                                                        </td>
                                                    </tr>
                                                    </c:if>
                                                </c:forEach>
                                                <c:forEach items="${pO.topUpMobilePhones}" var="t" varStatus="theCount2">
                                                    <c:if test="${t.recipient.id eq r.id}">
                                                    <tr>
                                                        <td></td>
                                                        <td>1</td>
                                                        <td>Top Up Mobile Minutes ${t.phone}</td>
                                                        <td style="text-align: right;">
                                                            <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> VND
                                                            <br/>
                                                            <fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/> USD
                                                        </td>
                                                    </tr>
                                                    </c:if>
                                                </c:forEach>
                                                    
                                            </table>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
