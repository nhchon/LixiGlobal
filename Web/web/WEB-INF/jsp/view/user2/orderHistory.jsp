<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="LiXi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            jQuery(document).ready(function () {
                
                $('#timeCombo').change(function(){
                    
                    document.location.href = '<c:url value="/user/orderHistory"/>' + '/' + this.value;
                    
                });
            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper">
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
                        <%--
                    <c:forEach items="${mOs}" var="m">
                    </c:forEach>
                        --%>
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
                </div>
                <div class="button-control">
                    <button class="btn btn-primary btn-has-link-event text-uppercase"  type="button" data-link="send-gift.html">Order again</button>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>