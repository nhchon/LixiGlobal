<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="LiXi Global - Orde">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/summary.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var AJAX_CHECK_EXCEED_PATH = '<c:url value="/gifts/ajax/checkExceed"/>';
        </script>
    </jsp:attribute>

    <jsp:body>
        <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-categories.jsp" %>
        <section class="bg-default main-section">
            <div class="container">
                <c:set var="localStep" value="5"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <form action="" method="get" class="receiver-form">
                    <div class="section-receiver">
                        <h2 class="title">order summary</h2>
                        <div class="table-responsive table-responsive-mobi">
                            <table class="text-center">
                                <thead>
                                    <tr>
                                        <th class="table-col-checkbox">&nbsp;</th>
                                        <th>Receiver</th>
                                        <th class="table-col-thumb">Items</th>
                                        <th>DESCRIPTION</th>
                                        <th class="table-col-Quantity">Quantity</th>
                                        <th>unit price</th>
                                        <th class="table-col-action">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${REC_GIFTS}" var="entry">
                                        <c:forEach items="${entry.gifts}" var="g">
                                            <tr id="giftRow${g.id}">
                                            <td data-title="Select">
                                                <input type="checkbox" class="custom-checkbox-input"/>
                                            </td>
                                            <td data-title="Receiver"><strong>${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName}</strong></td>
                                            <td  data-title="Items">
                                                <img width="122" height="107" src="<c:url value="${g.productImage}"/>"/>
                                            </td>
                                            <td data-title="DESCRIPTION"><h4>${g.productName}</h4></td>
                                            <td data-title="Quantity">
                                                <div class="gift-number-box">
                                                    <div class="input-group add-sub-item text-center">
                                                        <span class="input-group-btn">
                                                            <button onclick="subBtn(${g.id}, ${g.productId}, ${entry.recipient.id});" class="btn btn-default gift-sub-event" type="button"><i class="fa fa-chevron-down"></i></button>
                                                        </span>
                                                        <input id="quantity${g.id}" min="1" name="number" value="${g.productQuantity}" class="form-control gift-number" placeholder="Number">
                                                        <span class="input-group-btn">
                                                            <button onclick="addBtn(${g.id}, ${g.productId}, ${entry.recipient.id});"  class="btn btn-default gift-add-event" type="button"><i class="fa fa-chevron-up"></i></button>
                                                        </span>
                                                    </div><!-- /input-group -->
                                                </div>
                                            </td>
                                            <td data-title="Unit Price">
                                                <c:set var="priceInUSD" value="${g.getPriceInUSD(LIXI_ORDER.lxExchangeRate.buy)}"/>
                                                <div><strong>USD $ <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/></strong></div>
                                                <div><strong>VND <fmt:formatNumber value="${priceInUSD * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/></strong></div>
                                            </td>
                                            <td data-title="Action" class="table-row-action-btn">
                                                <p><button type="button" class="btn btn-default text-uppercase" onclick="location.href='<c:url value="/gifts/type/${g.category.id}"/>';"><spring:message code="message.change"/></button></p>
                                                <p> <button type="button" class="btn btn-primary text-uppercase" onclick="location.href='<c:url value="/gifts/delete/gift/${g.id}"/>';"><spring:message code="message.delete"/></button></p>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                        <tr class="has-colspan">
                                            <td colspan="5" class="border-right has-colspan-label"><strong class="text-uppercase title text-right float-right">Total</strong></td>
                                            <td colspan="2"><strong class="text-uppercase  title">usd $ <span id="recPaymentUSD${entry.recipient.id}"><fmt:formatNumber value="${entry.allTotal.usd}" pattern="###,###.##"/></span> ~ VND <span id="recPaymentVND${entry.recipient.id}"><fmt:formatNumber value="${entry.allTotal.vnd}" pattern="###,###.##"/></span></strong></td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="has-colspan">
                                        <td colspan="3" class="no-padding-left"><strong class="text-uppercase text-right">order limit ( USD $ 150 / vnd 3,000,000 ) </strong></td>
                                        <td colspan="2" class="border-right has-colspan-label"><strong class="text-uppercase text-right  float-right  title">Total</strong></td>
                                        <td colspan="2"><strong class="text-uppercase  title">usd $ <span id="currentPaymentUSD"><fmt:formatNumber value="${LIXI_TOTAL_AMOUNT.usd}" pattern="###,###.##"/></span> ~ VND <span id="currentPaymentVND"><fmt:formatNumber value="${LIXI_TOTAL_AMOUNT.vnd}" pattern="###,###.##"/></span></strong></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p style="margin-top: 10px;">
                            ( <sup>*</sup> You can shop for up to 5 different persons )
                        </p>
                    </div>
                    <div class="button-control text-center text-uppercase">
                        <div class="button-control-page">
                            <button class="btn btn-default btn-has-link-event text-uppercase" type="button" data-link="<c:url value="/gifts/recipient"/>">Keep shopping</button>
                            <button class="btn btn-primary btn-has-link-event"  type="button" data-link="select-a-payment.html">NEXT</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </jsp:body>
</template:Client>