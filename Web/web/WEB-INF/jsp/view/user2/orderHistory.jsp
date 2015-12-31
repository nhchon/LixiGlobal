<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            jQuery(document).ready(function () {

                $('#timeCombo').change(function () {

                    document.location.href = '<c:url value="/user/orderHistory"/>' + '/' + this.value;

                });
            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title">order history</h2>
                    <h4 class="title">
                        <c:if test="${not empty orders.content}">${fn:length(orders.content)} orders place in</c:if>
                        <c:if test="${empty orders.content}">There is no order place in</c:if>
                        </h4>
                        <div class="form-group">
                            <select id="timeCombo" class="selectpicker">
                                <option value="lastWeek" <c:if test="${when eq 'lastWeek'}">selected=""</c:if>>Last week</option>
                            <option value="last30Days" <c:if test="${when eq 'last30Days'}">selected=""</c:if>>Last 30 days</option>
                            <option value="last6Months" <c:if test="${when eq 'last6Months'}">selected=""</c:if>>Last 6 months</option>
                            <option value="allOrders" <c:if test="${when eq 'allOrders'}">selected=""</c:if>>All</option>
                            </select>
                        </div>
                    <c:forEach items="${mOs}" var="m">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-md-2">
                                        <div style="font-size:16px;" class="badge">
                                                ORDER NO ${m.key.id}
                                            </div>
                                        <div style="font-size:14px;padding-top: 8px;">
                                            <a href="<c:url value="/user/orderDetail/${m.key.id}"/>">Order Detail</a> |  <a href="javascript:alert('Comming Soon');" >Order Again</a>
                                        </div>
                                    </div>
                                    <div class="col-md-2" style="text-align:center;">
                                        <div style="font-size:16px;">ORDER DATE</div>
                                        <div style="font-size:14px;padding-top: 8px;">
                                        <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.modifiedDate}"/>
                                        </div>
                                    </div>
                                    <div class="col-md-3" style="text-align:center;">
                                        <div style="font-size:16px;">STATUS</div>
                                        <div style="font-size:14px;padding-top: 8px;">
                                            <c:if test="${empty m.key.invoice}">
                                                <a href="<c:url value="/gifts/order-summary"/>">In Creation</a>
                                            </c:if>
                                            <c:if test="${not empty m.key.invoice}">
                                                <c:if test="${empty m.key.invoice.netTransStatus}">
                                                    <c:choose>
                                                        <c:when test="${m.key.invoice.netResponseCode eq '1'}">
                                                            In Progress
                                                        </c:when>
                                                        <c:when test="${m.key.invoice.netResponseCode eq '2'}">
                                                            Canceled
                                                        </c:when>
                                                        <c:when test="${m.key.invoice.netResponseCode eq '3'}">
                                                            Canceled
                                                        </c:when>
                                                        <c:when test="${m.key.invoice.netResponseCode eq '4'}">
                                                            In Progress
                                                        </c:when>
                                                    </c:choose>
                                                </c:if>
                                                <c:if test="${not empty m.key.invoice.netTransStatus}">
                                                    ${m.key.invoice.netTransStatus}
                                                </c:if>             
                                            </c:if>
                                            <c:set var="lastCheck" value="Last check: "/>
                                            <c:if test="${m.key.invoice.netTransStatus eq 'settledSuccessfully'}">
                                                <c:set var="lastCheck" value=""/>
                                            </c:if>
                                            <c:if test="${empty m.key.invoice}">
                                                &nbsp;(${lastCheck}<fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.modifiedDate}"/>)
                                            </c:if>
                                            <c:if test="${not empty m.key.invoice}">
                                                <c:if test="${empty m.key.invoice.netTransStatus}">
                                                    &nbsp;(${lastCheck}<fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.invoice.invoiceDate}"/>)
                                                </c:if>
                                                <c:if test="${not empty m.key.invoice.netTransStatus}">
                                                    &nbsp;(${lastCheck}<fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.invoice.lastCheckDate}"/>)
                                                </c:if>             
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-md-2" style="text-align:center;">
                                        <div style="font-size:16px;">TOTAL</div>
                                        <div style="font-size:14px;padding-top: 8px;">
                                            <c:if test="${empty m.key.invoice}">
                                                --
                                            </c:if>
                                            <c:if test="${not empty m.key.invoice}">    
                                                USD <fmt:formatNumber value="${m.key.invoice.totalAmount}" pattern="###,###.##"/> - 
                                                <fmt:formatNumber value="${m.key.invoice.totalAmountVnd}" pattern="###,###.##"/> VND
                                            </c:if>
                                        </div>
                                    </div>
                                        <div class="col-md-3" style="text-align: center;">
                                        <div style="font-size:16px;">SETTING</div>
                                            <div style="font-size:14px;padding-top: 8px;">
                                            <c:if test="${m.key.setting eq 0}">
                                                Gift Only
                                            </c:if>
                                            <c:if test="${m.key.setting eq 1}">
                                                Allow Refund
                                            </c:if>
                                            </div>    
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                    <ul class="nav nav-pills" role="tablist">
                                        <li role="presentation" class="active"><a href="#">${rio.recipient.firstName}&nbsp;${rio.recipient.middleName}&nbsp;${rio.recipient.lastName} <span class="badge">${fn:length(rio.gifts) + fn:length(rio.topUpMobilePhones)}</span></a></li>
                                    </ul>
                                    <div>&nbsp;</div>
                                    <c:forEach items="${rio.gifts}" var="g">
                                        <div class="row" style="margin-bottom: 5px;">
                                            <div class="col-md-2" style="padding-left:50px;">
                                                <img width="122" height="107" src="<c:url value="${g.productImage}"/>"/>
                                            </div>
                                            <div class="col-md-1" style="padding-top:40px;text-align: center;">
                                                ${g.productQuantity}
                                            </div>
                                            <div class="col-md-6" style="padding-top:40px;">
                                                ${g.productName}
                                            </div>
                                            <div class="col-md-3" style="padding-top:40px;text-align: center;">
                                                USD <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> - VND <fmt:formatNumber value="${g.exchPrice}" pattern="###,###.##"/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:forEach items="${rio.topUpMobilePhones}" var="t">
                                        <div class="row" style="margin-bottom: 5px;">
                                            <div class="col-md-3" style="padding-left:50px;">
                                                Top Up Mobile Phone
                                            </div>
                                            <div class="col-md-6" style="text-align: center;">
                                                ${t.phone}
                                            </div>
                                            <div class="col-md-3" style="text-align: center;">
                                                USD <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> - VND <fmt:formatNumber value="${t.amount * m.key.lxExchangeRate.buy}" pattern="###,###.##"/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${theValueCount.count < fn:length(m.value)}">
                                    <div class="row">
                                        <div class="col-md-8"><hr style="height:1px;border:none;color:#333;background-color:#333;"/></div>
                                    </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>