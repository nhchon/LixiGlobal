<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/detail/${order.id}"/>">Order Detail</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Order Detail #${order.invoice.invoiceCode}</h2>
        <div class="row">
            <div class="col-sm-6">
                <div class="table-responsive">
                    <table class="table table-hover table-responsive table-striped">
                        <thead>
                            <tr>
                                <th nowrap>#</th><%-- 1 --%>
                                <th nowrap>Date</th><%-- 2 --%>
                                <th nowrap>Transaction No</th><%-- 3 --%>
                                <th>Sender</th><%-- 4 --%>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${order.invoice.invoiceCode}</td>
                                <td>
                                    <fmt:formatDate pattern="MM/dd/yyyy" value="${order.createdDate}"/>
                                    <br/>
                                    <fmt:formatDate pattern="HH:mm:ss" value="${order.createdDate}"/>

                                </td>
                                <td>${order.invoice.netTransId}<br/>(${order.invoice.translatedStatus})</td>
                                <td>${order.sender.fullName}</td>
                                <td>
                                    <c:if test="${order.lixiStatus eq PROCESSING}">
                                        Processing<br/>
                                        <c:if test="${order.lixiSubStatus eq SENT_MONEY}">(Sent Money Info)</c:if>
                                        <c:if test="${order.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                    </c:if>
                                    <c:if test="${order.lixiStatus eq COMPLETED}">
                                        Completed
                                    </c:if>
                                    <c:if test="${order.lixiStatus eq CANCELED}">
                                        Cancelled
                                    </c:if>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive table-striped">
                                <thead>
                                    <tr>
                                        <th nowrap>Receiver</th><%-- 1 --%>
                                        <th nowrap>Item</th><%-- 2 --%>
                                        <th nowrap>Description</th><%-- 3 --%>
                                        <th>Amount</th><%-- 4 --%>
                                        <th style="text-align:right;">Status</th><%-- 5 --%>
                                        <%-- <th>Action</th>6 --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${recGifts}" var="rio" varStatus="theCount">
                                        <tr id="rowR${rio.recipient.id}">
                                            <td>${rio.recipient.fullName}</td>
                                            <td colspan="4"></td>
                                        </tr>
                                        <c:forEach items="${rio.gifts}" var="g" varStatus="theCount2">
                                            <tr>
                                                <td><b># ${g.id}</b></td>
                                                <td>${g.productQuantity}</td>
                                                <td>${g.productName}</td>
                                                <td style="text-align: right;">
                                                    <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND
                                                    <br/>
                                                    <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/> USD
                                                </td>
                                                <td style="text-align:right;">
                                                    <c:choose>
                                                        <c:when test="${g.bkStatus eq '0'}">
                                                            <span class="alert-danger">Processing</span>
                                                        </c:when>
                                                        <c:when test="${g.bkStatus eq '1'}">
                                                            <span class="alert-danger">Completed</span>
                                                        </c:when>
                                                        <c:when test="${g.bkStatus eq '2'}">
                                                            <span class="alert-danger">Cancelled</span>
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
                                        <c:forEach items="${rio.topUpMobilePhones}" var="t" varStatus="theCount2">
                                            <tr>
                                                <td></td>
                                                <td>1</td>
                                                <td>Top Up Mobile Minutes ${t.phone}</td>
                                                <td style="text-align: right;">
                                                    <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> VND
                                                    <br/>
                                                    <fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/> USD
                                                </td>
                                                <td>
                                                    <br/>
                                                    <br/>
                                                </td>
                                        </tr>
                                        </c:forEach>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Total</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="${rio.allTotal.vnd}" pattern="###,###.##"/> VND
                                                <br/>
                                                <fmt:formatNumber value="${rio.allTotal.usd}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td>
                                        </tr>
                                    </c:forEach>
                                        <%-- GRAND TOTAL --%>
                                        <tr style="border-top: 2px solid #0090d0;">
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Gift price</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="${order.invoice.giftPrice}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Card processing fee</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="${order.invoice.cardFee}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Lixi handing fee</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="${order.invoice.lixiFee}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Total befor tax</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="${order.invoice.totalAmount}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Sale tax</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="0" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;"><b>Grand Total</b></td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber value="${order.invoice.totalAmountVnd}" pattern="###,###.##"/> VND
                                                <br/>
                                                <fmt:formatNumber value="${order.invoice.totalAmount}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td>
                                        </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
