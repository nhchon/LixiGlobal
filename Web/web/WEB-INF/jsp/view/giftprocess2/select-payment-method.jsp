<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var SELECT_PAYMENT_METHOD = '<spring:message code="validate.checkout.select_a_card"/>';
        </script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/payment-methods.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <c:import url="/categories"/>
        <section class="main-section"><%--bg-default --%>
            <div class="container">
                <c:set var="localStep" value="6"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <c:if test="${wrong eq '1' || param.wrong eq '1'}">
                    <div class="alert alert-danger" role="alert">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                        <span class="sr-only">Error:</span>
                        <spring:message code="error.payment-method"/>
                    </div>
                </c:if>
                <c:if test="${overNumOfCard eq '1' || param.overNumOfCard eq '1'}">
                    <div class="alert alert-danger" role="alert">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                        <span class="sr-only">Error:</span>
                        <spring:message code="error.over-num-of-card" text="Your maximum number of card is 5. Please delete on of them before add new card"/>
                    </div>
                </div>
                </c:if>
                <c:url value="/checkout/paymentMethods" var="choosePaymentMethodUrl"/>
                <form id="changePaymentForm" action="${choosePaymentMethodUrl}" method="post" class="receiver-form" onsubmit="return checkSelectedPayment()">
                    <div class="section-receiver">
                        <h2 class="title"><spring:message code="select-payment-method"/></h2>

                        <div class="table-responsive table-select-payment table-responsive-mobi">
                            <table>
                                <thead>
                                    <tr>
                                        <th style="width: 60%; text-align: left;"><spring:message code="your-card"/></th>
                                        <th style="width: 20%"><spring:message code="mess.name-on-card"/></th>
                                        <th style="width: 20%"><spring:message code="expires-on"/></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${CARDS}" var="c">
                                        <c:set var="lengthCard" value="${fn:length(c.cardNumber)}"/>
                                        <tr>
                                            <td data-title="Card">
                                                <div>
                                                    <input type="radio"  value="${c.id}" name="cardId" <c:if test="${not empty LIXI_ORDER.card && LIXI_ORDER.card.id == c.id}">checked=""</c:if>  class="custom-checkbox-input"/>
                                                    <c:choose>
                                                        <c:when test="${c.cardType eq 1}">
                                                           <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-visa.png"/>"/>
                                                        </c:when>
                                                        <c:when test="${c.cardType eq 2}">
                                                            <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-master.png"/>"/>
                                                        </c:when>
                                                        <c:when test="${c.cardType eq 3}">
                                                            <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-discover.png"/>"/>
                                                        </c:when>
                                                        <c:when test="${c.cardType eq 4}">
                                                            <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-amex.jpg"/>"/>
                                                        </c:when>
                                                    </c:choose>                                                    
                                                    <span class="text-uppercase">Ending in ${fn:substring(c.cardNumber, lengthCard-4, lengthCard)}</span>
                                                </div>
                                            </td>
                                            <td data-title="Name" class="text-center">${c.cardName}</td>
                                            <td data-title="Expires on" class="text-center">
                                                <c:if test="${c.expMonth < 10}">0${c.expMonth}</c:if><c:if test="${c.expMonth >= 10}">${c.expMonth}</c:if>/${c.expYear}
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="button-control text-uppercase">
                        <div class="row">
                            <div class="col-md-6 text-left">
                                <button class="btn btn-warning btn-has-link-event text-uppercase"  style="color: white;" type="button" data-link="<c:url value="/gifts/choose"/>"><spring:message code="keep-shopping"/></button>
                                <button class="btn btn-primary text-uppercase"  type="submit"><spring:message code="use-this-payment-method"/></button>
                            </div>
                            <div class="col-md-6 text-right">
                                <c:set var="numOfCard" value="${fn:length(CARDS)}"/>
                                <c:if test="${numOfCard < 5}">
                                    <button class="btn btn-primary btn-has-link-event text-uppercase" type="button" data-link="<c:url value="/checkout/addCard"/>"><spring:message code="add-new-card"/></button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />        
                </form>
            </div>
        </section>

    </jsp:body>
</template:Client>