<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="LiXi Global - Select A Payment Method">

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
                                            <a href="<c:url value="/user/orderDetail/${m.key.id}"/>">Order Detail</a> |  <a href="" >Order Again</a>
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
                                            <c:if test="${empty m.key.invoice}">
                                                &nbsp;(Last check: <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.modifiedDate}"/>)
                                            </c:if>
                                            <c:if test="${not empty m.key.invoice}">
                                                <c:if test="${empty m.key.invoice.netTransStatus}">
                                                    &nbsp;(Last check: <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.invoice.invoiceDate}"/>)
                                                </c:if>
                                                <c:if test="${not empty m.key.invoice.netTransStatus}">
                                                    &nbsp;(Last check: <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.invoice.lastCheckDate}"/>)
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
                                                $ <fmt:formatNumber value="${m.key.invoice.totalAmount}" pattern="###,###.##"/> - 
                                                <fmt:formatNumber value="${m.key.invoice.totalAmountVnd}" pattern="###,###.##"/> đ
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
                                        <li role="presentation" class="active"><a href="#">${rio.recipient.firstName}&nbsp;${rio.recipient.middleName}&nbsp;${rio.recipient.lastName} <span class="badge">${fn:length(rio.gifts)}</span></a></li>
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
                                            <div class="col-md-7" style="padding-top:40px;">
                                                ${g.productName}
                                            </div>
                                            <div class="col-md-2" style="padding-top:40px;">
                                                $ <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/> - <fmt:formatNumber value="${g.exchPrice}" pattern="###,###.##"/> đ
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${theValueCount.count < fn:length(m.value)}">
                                    <div class="row">
                                        <div class="col-md-8"><hr style="height:1px;border:none;color:#333;background-color:#333;"/></div>
                                    </div>
                                    </c:if>
                                    <%--
                                    <table class="table-responsive" style="margin-top:10px;">
                                        <c:forEach items="${rio.gifts}" var="g">
                                            <tr id="giftRow${g.id}">
                                                <td data-title="Receiver"><strong>${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName}</strong></td>
                                                <td  data-title="Items">
                                                    <img width="122" height="107" src="<c:url value="${g.productImage}"/>"/>
                                                </td>
                                                <td data-title="DESCRIPTION"><h4>(${g.productQuantity}) ${g.productName}</h4></td>
                                                <td data-title="Unit Price">
                                                    <div><strong>USD $ <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/></strong></div>
                                                    <div><strong>VND <fmt:formatNumber value="${g.exchPrice}" pattern="###,###.##"/></strong></div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                    <p>&nbsp;</p>
                                    --%>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach><%--
                    <div class="table-responsive table-responsive-mobi">
                        <table class="text-center">
                            <thead>
                                <tr>
                                    <th>Order NO</th>
                                    <th>order date</th>
                                    <th>Summary</th>
                                    <th style="width: 150px;">status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders.content}" var="o">
                                    <tr>
                                        <td data-title="Order NO">
                                            <h4>${o.id}</h4>
                                            <div>
                                                <a href="javascript:alert('in development');" class="btn btn-primary text-uppercase">Order detail</a>
                                            </div>
                                        </td>
                                        <td data-title="Order date"><fmt:formatDate pattern="MM/dd/yyyy" value="${o.modifiedDate}"/></td>
                                        <td data-title="Summary">
                                            <c:if test="${empty o.invoice}">
                                                <div><strong>(Not yet)</strong></div>
                                            </c:if>
                                            <c:if test="${not empty o.invoice}">    
                                                <div><strong>USD $ <fmt:formatNumber value="${o.invoice.totalAmount}" pattern="###,###.##"/></strong></div>
                                                <div><strong>VND <fmt:formatNumber value="${o.invoice.totalAmount * o.lxExchangeRate.buy}" pattern="###,###.##"/></strong></div>
                                            </c:if>
                                            <div class="icon-card-wrapper">
                                                <c:if test="${not empty o.card}">
                                                    <c:set var="lengthCard" value="${fn:length(o.card.cardNumber)}"/>
                                                </c:if>
                                                <c:choose>
                                                    <c:when test="${o.card.cardType eq 1}">
                                                        <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-visa.png"/>"/>
                                                    </c:when>
                                                    <c:when test="${o.card.cardType eq 2}">
                                                        <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-master.png"/>"/>
                                                    </c:when>
                                                    <c:when test="${o.card.cardType eq 3}">
                                                        <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-discover.png"/>"/>
                                                    </c:when>
                                                    <c:when test="${o.card.cardType eq 4}">
                                                        <img width="47" height="29" src="<c:url value="/resource/theme/assets/lixi-global/images/card-amex.jpg"/>"/>
                                                    </c:when>
                                                </c:choose>                                                    

                                                <span><sup>***</sup>${fn:substring(o.card.cardNumber, lengthCard-4, lengthCard)}</span>
                                            </div>
                                        </td>
                                        <td data-title="Status">
                                            <div>
                                                <span class="text-unline">
                                                    <c:if test="${empty o.invoice}">
                                                        <a href="<c:url value="/gifts/order-summary"/>">In Creation</a>
                                                    </c:if>
                                                    <c:if test="${not empty o.invoice}">
                                                        <c:if test="${empty o.invoice.netTransStatus}">
                                                            <c:choose>
                                                                <c:when test="${o.invoice.netResponseCode eq '1'}">
                                                                    In Progress
                                                                </c:when>
                                                                <c:when test="${o.invoice.netResponseCode eq '2'}">
                                                                    Canceled
                                                                </c:when>
                                                                <c:when test="${o.invoice.netResponseCode eq '3'}">
                                                                    Canceled
                                                                </c:when>
                                                                <c:when test="${o.invoice.netResponseCode eq '4'}">
                                                                    In Progress
                                                                </c:when>
                                                            </c:choose>
                                                        </c:if>
                                                        <c:if test="${not empty o.invoice.netTransStatus}">
                                                            ${o.invoice.netTransStatus}
                                                        </c:if>             
                                                    </c:if>
                                                </span>
                                            </div>
                                            <div>
                                                <c:if test="${empty o.invoice}">
                                                    <fmt:formatDate pattern="MM/dd/yyyy" value="${o.modifiedDate}"/>
                                                </c:if>
                                                <c:if test="${not empty o.invoice}">
                                                    <c:if test="${empty o.invoice.netTransStatus}">
                                                        <fmt:formatDate pattern="MM/dd/yyyy" value="${o.invoice.invoiceDate}"/>
                                                    </c:if>
                                                    <c:if test="${not empty o.invoice.netTransStatus}">
                                                        <fmt:formatDate pattern="MM/dd/yyyy" value="${o.invoice.lastCheckDate}"/>
                                                    </c:if>             
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                            --%>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>