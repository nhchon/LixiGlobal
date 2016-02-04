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
        <%-- EnumLixiOrderStatus.java --%>
        <c:set var="UNFINISHED" value="-9"/>
        <c:set var="NOT_YET_SUBMITTED" value="-8"/>
        <c:set var="SENT_INFO" value="-7"/>
        <c:set var="SENT_MONEY" value="-6"/>
        <c:set var="PROCESSING" value="0"/>
        <c:set var="COMPLETED" value="1"/>
        <c:set var="CANCELED" value="2"/>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/newOrders/-1"/>">Order Detail</a></li>
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
                                <td>${order.invoice.netTransId}</td>
                                <td>${order.sender.fullName}</td>
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
                                        <tr id="rowR${m.key.id}">
                                            <td>${rio.recipient.fullName}</td>
                                            <td colspan="4"></td>
                                        </tr>
                                        <c:forEach items="${rio.gifts}" var="g" varStatus="theCount2">
                                            <tr>
                                                <td></td>
                                                <td>${g.productQuantity}</td>
                                                <td>${g.productName}</td>
                                                <td style="text-align: right;">
                                                    <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND
                                                    <br/>
                                                    <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/> USD
                                                </td>
                                                <td style="text-align:right;">
                                                    <c:choose>
                                                        <c:when test="${g.bkStatus eq NOT_YET_SUBMITTED}">
                                                            <span class="alert-danger">Failed</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="alert-success">Passed</span>
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
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
