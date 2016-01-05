<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Orde">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.number.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/summary.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var AJAX_CHECK_EXCEED_PATH = '<c:url value="/gifts/ajax/checkExceed"/>';
            var DELETE_GIFT_PATH = '<c:url value="/gifts/delete/gift"/>';
            var DELETE_TOPUP_PATH = '<c:url value="/topUp/delete"/>';
            var CONFIRM_DELETE_MESSAGE = '<spring:message code="message.want_to_delete"/>';
            var CONFIRM_CHANGE_MESSAGE = '<spring:message code="message.confirm_to_delete" text="This item will be deleted. Would you like to continue?"/>';
            function change(giftId){
                if(confirm(CONFIRM_CHANGE_MESSAGE)){
                    location.href='<c:url value="/gifts/change/"/>' + giftId;
                }
            }
            
            $(document).ready(function () {
                $('.gift-number').number(true, 0, ',', '');
            });
            
        </script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="bg-default main-section">
            <div class="container">
                <c:set var="localStep" value="5"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <form action="" method="get" class="receiver-form">
                    <div class="section-receiver">
                        <h2 class="title">order summary</h2>
                        <c:if test="${empty REC_GIFTS}">
                            <p>Your order is empty.</p>
                        </c:if>
                        <c:if test="${not empty REC_GIFTS}">
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
                                            <!--    
                                                <input type="checkbox" class="custom-checkbox-input"/>
                                            -->
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
                                            <td data-title="Unit Price" nowrap>
                                                <div><strong>USD <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/></strong></div>
                                                <div><strong>VND <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/></strong></div>
                                            </td>
                                            <td data-title="Action" class="table-row-action-btn">
                                                <p><button type="button" class="btn btn-default text-uppercase" onclick="change(${g.id});"><spring:message code="message.change"/></button></p>
                                                <p> <button type="button" class="btn btn-primary text-uppercase" onclick="deleteGiftOnSummary(${g.id})"><spring:message code="message.delete"/></button></p>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                        <c:forEach items="${entry.topUpMobilePhones}" var="t">
                                            <tr id="topUpRow${g.id}">
                                            <td data-title="Select">
                                            <!--
                                                <input type="checkbox" class="custom-checkbox-input"/>
                                            -->
                                            </td>
                                            <td data-title="Receiver"><strong>${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName}</strong></td>
                                            <td  data-title="Items">
                                                
                                            </td>
                                            <td data-title="DESCRIPTION"><h4>Top Up Mobile Minutes</h4></td>
                                            <td data-title="Quantity">
                                            </td>
                                            <td data-title="Unit Price" nowrap>
                                                <div nowrap><strong>USD <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/></strong></div>
                                                <div nowrap><strong>VND <fmt:formatNumber value="${t.amount * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/></strong></div>
                                            </td>
                                            <td data-title="Action" class="table-row-action-btn">
                                                <p><button type="button" class="btn btn-default text-uppercase" onclick="location.href='<c:url value="/topUp/change/${t.id}"/>';"><spring:message code="message.change"/></button></p>
                                                <p> <button type="button" class="btn btn-primary text-uppercase" onclick="deleteTopUpOnSummary(${t.id})"><spring:message code="message.delete"/></button></p>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                        <c:if test="${fn:length(REC_GIFTS) > 1}">
                                        <tr class="has-colspan">
                                            <td colspan="5" class="border-right has-colspan-label"><strong class="text-uppercase title text-right float-right">Total</strong></td>
                                            <td colspan="2"><strong class="text-uppercase  title">usd <span id="recPaymentUSD${entry.recipient.id}"><fmt:formatNumber value="${entry.allTotal.usd}" pattern="###,###.##"/></span> ~ VND <span id="recPaymentVND${entry.recipient.id}"><fmt:formatNumber value="${entry.allTotal.vnd}" pattern="###,###.##"/></span></strong></td>
                                        </tr>
                                        </c:if>
                                    </c:forEach>
                                    <tr class="has-colspan">
                                        <td colspan="4" class="no-padding-left" style="text-align: left;"><strong class="text-uppercase text-right">order limit ( USD 250 / vnd <fmt:formatNumber value="${250 * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/> ) </strong></td>
                                        <td colspan="1" class="border-right has-colspan-label"><strong class="text-uppercase text-right  float-right  title">Grand Total</strong></td>
                                        <td colspan="2"><strong class="text-uppercase  title">usd <span id="currentPaymentUSD"><fmt:formatNumber value="${LIXI_TOTAL_AMOUNT.usd}" pattern="###,###.##"/></span> ~ VND <span id="currentPaymentVND"><fmt:formatNumber value="${LIXI_TOTAL_AMOUNT.vnd}" pattern="###,###.##"/></span></strong></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p style="margin-top: 10px;">
                            ( <sup>*</sup> You can shop for up to 5 different persons )
                        </p>
                        </c:if>        
                    </div>
                    <c:if test="${not empty REC_GIFTS}">
                    <div class="button-control text-center text-uppercase">
                        <div class="button-control-page">
                            <button class="btn btn-default btn-has-link-event text-uppercase" type="button" data-link="<c:url value="/gifts/recipient"/>">Keep shopping</button>
                            <button class="btn btn-primary btn-has-link-event"  type="button" data-link="<c:url value="/checkout/paymentMethods"/>">NEXT</button>
                        </div>
                    </div>
                    </c:if>        
                </form>
            </div>
        </section>
    </jsp:body>
</template:Client>