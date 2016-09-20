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
            <div class="col-sm-8">
                <div class="table-responsive">
                    <table class="table table-hover table-responsive table-striped">
                        <thead>
                            <tr>
                                <th nowrap>#</th><%-- 1 --%>
                                <th nowrap>Date</th><%-- 2 --%>
                                <th nowrap>Transaction No</th><%-- 3 --%>
                                <th nowrap>Setting</th>
                                <th>Sender</th><%-- 4 --%>
                                <th nowrap style="text-align: center;">Status</th>
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
                                <td nowrap>
                                    <c:if test="${order.setting eq 0}">
                                        Gift Only
                                    </c:if>
                                    <c:if test="${order.setting eq 1}">
                                        Allow Refund
                                    </c:if>
                                </td>
                                <td><a target="_blank" href='<c:url value="/Administration/SystemSender/detail/${order.sender.id}"/>'>${order.sender.fullName}</a></td>
                                <td style="text-align: center;">
                                    <c:choose>
                                        <c:when test="${order.lixiStatus eq PROCESSING}">
                                            Processing<br/>
                                            <c:if test="${order.lixiSubStatus eq SENT_MONEY}">(Sent Money)</c:if>
                                            <c:if test="${order.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                        </c:when>
                                        <c:when test="${order.lixiStatus eq COMPLETED}">
                                            Completed
                                        </c:when>
                                        <c:when test="${order.lixiStatus eq CANCELED}">
                                            Cancelled
                                        </c:when>
                                        <c:when test="${order.lixiStatus eq PURCHASED}">
                                            Purchased
                                        </c:when>
                                        <c:when test="${order.lixiStatus eq DELIVERED}">
                                            Delivered
                                        </c:when>
                                        <c:when test="${order.lixiStatus eq UNDELIVERABLE}">
                                            Undeliverable
                                        </c:when>
                                        <c:when test="${order.lixiStatus eq REFUNDED}">
                                            Refunded
                                        </c:when>
                                        <c:otherwise>
                                            ${order.lixiStatus}
                                        </c:otherwise>
                                    </c:choose>
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
                                        <th style="text-align: right;">Amount</th><%-- 4 --%>
                                        <th style="text-align:center;">Method</th>
                                        <th style="text-align:right;">Status</th><%-- 5 --%>
                                        <%-- <th>Action</th>6 --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set value="0" var="totalShipping"/>
                                    <c:forEach items="${recGifts}" var="rio" varStatus="theCount">
                                        <tr id="rowR${rio.recipient.id}">
                                            <td>${rio.recipient.fullName}</td>
                                            <td colspan="5"></td>
                                        </tr>
                                        <c:forEach items="${rio.gifts}" var="g" varStatus="theCount2">
                                            <tr>
                                                <td><b># ${g.id}</b></td>
                                                <td>${g.productQuantity}</td>
                                                <td>${g.productName}</td>
                                                <td style="text-align: right;">
                                                    <fmt:formatNumber minFractionDigits="2" value="${g.usdPrice}" pattern="###,###.##"/> USD
                                                    <br/>
                                                    <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND
                                                </td>
                                                <td style="text-align:center;">
                                                    <c:choose>
                                                        <c:when test="${g.bkReceiveMethod eq 'MONEY'}">
                                                            Refunded
                                                        </c:when>
                                                        <c:when test="${g.bkReceiveMethod eq 'GIFT'}">
                                                            Gifted
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${g.bkReceiveMethod}
                                                        </c:otherwise>
                                                    </c:choose>
                                                            <br/>
                                                    <c:choose>
                                                        <c:when test="${fn:startsWith(g.bkUpdated, '0000')}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span style="font-size: 12px;">${g.bkUpdated}</span>
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
                                        <c:forEach items="${rio.topUpMobilePhones}" var="t" varStatus="theCount2">
                                            <tr>
                                                <td></td>
                                                <td>1</td>
                                                <td>Top Up Mobile Minutes ${t.phone}</td>
                                                <td style="text-align: right;">
                                                    <fmt:formatNumber minFractionDigits="2" value="${t.amountUsd}" pattern="###,###.##"/> USD
                                                    <br/>
                                                    <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> VND
                                                </td>
                                                <td style="text-align:right;" colspan="2">
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
                                                        </c:choose>
                                                    
                                                </td>
                                        </tr>
                                        </c:forEach>
                                        <tr>
                                            <td><b>Shipping charge:</b></td>
                                            <td><fmt:formatNumber value="${rio.shippingChargeAmount}" pattern="###,###.##"/> USD</td>
                                            <td style="text-align: right;"><b>Total (include shipping charge):</b></td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber minFractionDigits="2" value="${rio.allTotal.usd + rio.shippingChargeAmount}" pattern="###,###.##"/> USD
                                                <br/>
                                                <fmt:formatNumber value="${rio.allTotal.vnd + (rio.shippingChargeAmountVnd)}" pattern="###,###.##"/> VND
                                            </td>
                                            <td colspan="3"></td>
                                        </tr>
                                        <c:set value="${totalShipping + rio.shippingChargeAmount}" var="totalShipping"/>
                                    </c:forEach>
                                        <%-- GRAND TOTAL --%>
                                        <tr style="border-top: 2px solid #0090d0;">
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Gift price</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber minFractionDigits="2" value="${order.invoice.giftPrice}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td><td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Total shipping charge</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber minFractionDigits="2" value="${totalShipping}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td><td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Card processing fee</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber minFractionDigits="2" value="${order.invoice.cardFee}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td><td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Lixi handing fee</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber minFractionDigits="2" value="${order.invoice.lixiFee}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td><td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Total befor tax</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber minFractionDigits="2" value="${order.invoice.totalAmount}" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td><td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;">Sale tax</td>
                                            <td style="text-align: right;">
                                                <fmt:formatNumber minFractionDigits="2" value="0" pattern="###,###.##"/> USD
                                            </td>
                                            <td></td><td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td style="text-align: right;"><b>Grand Total</b></td>
                                            <td style="text-align: right;">
                                                <b><fmt:formatNumber minFractionDigits="2" value="${order.invoice.totalAmount}" pattern="###,###.##"/></b> USD
                                                <br/>
                                                <b><fmt:formatNumber value="${order.invoice.totalAmountVnd}" pattern="###,###.##"/></b> VND
                                            </td>
                                            <td></td><td></td>
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
