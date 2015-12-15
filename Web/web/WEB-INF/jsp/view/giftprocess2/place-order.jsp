<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="LiXi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var CALCULATE_FEE_PATH = '<c:url value="/checkout/place-order/calculateFee"/>';
        </script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/place-order.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="section-gift bg-default main-section">
            <div class="container">
                <c:set var="localStep" value="7"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <c:url value="/checkout/place-order" var="placeOrderUrl"/>
                <form method="post" class="receiver-form" action="${placeOrderUrl}">
                    <div class="section-receiver">
                        <h2 class="title">review your order</h2>
                        <p class="text-uppercase">Thank you for being a customer!  </p>
                        <div class="clean-paragraph"></div>
                        <div class="receiver-info-wrapper">
                            <div class="receiver-info-items">
                            <c:forEach items="${REC_GIFTS}" var="entry">
                                <div class="receiver-info-item">
                                    <div class="receiver-sent-to">
                                        <h4 class="text-color-link">Send To: ${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName} <a href="#" class="edit-info-event"></a></h4>
                                        <div>
                                            <strong>Email Address:</strong><span>${entry.recipient.email}</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                        <div>
                                            <strong>Mobile Phone:</strong><span>${entry.recipient.phone}</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                    </div>
                                    <div class="receiver-order-summary">
                                        <h4>Order summary</h4>
                                        <c:forEach items="${entry.gifts}" var="g"  varStatus="giftCount">
                                        <div>
                                            <strong style="width:350px;">${g.productName}</strong>
                                            <span>USD $ <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/> * ${g.productQuantity} ~ VND <fmt:formatNumber value="${g.exchPrice * g.productQuantity}" pattern="###,###.##"/></span>
                                            <a href="#" class="edit-info-event"></a>
                                            <!--<span>( gift / more recipient )</span>-->
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                                <div class="receiver-info-item">
                                    <div class="receiver-order-item">
                                        <div class="receiver-order-gift-price">
                                            <div>
                                                <strong class="receiver-order-gift-price-left text-bold">Gift Price</strong><span class="receiver-order-gift-price-right">USD $ <fmt:formatNumber value="${LIXI_GIFT_PRICE}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${LIXI_GIFT_PRICE_VND}" pattern="###,###.##"/></span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left">Card Processing fee</strong><span class="receiver-order-gift-price-right">USD $ <span id="CARD_PROCESSING_FEE_THIRD_PARTY"><fmt:formatNumber value="${CARD_PROCESSING_FEE_THIRD_PARTY}" pattern="###,###.##"/></span></span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left">Lixi handing fee</strong><span class="receiver-order-gift-price-right">USD $ <fmt:formatNumber value="${LIXI_HANDLING_FEE_TOTAL}" pattern="###,###.##"/> (<fmt:formatNumber value="${LIXI_HANDLING_FEE}" pattern="###,###.##"/> per / person )</span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left text-bold">Total</strong><strong class="receiver-order-gift-price-right text-bold">USD $ <span id="LIXI_FINAL_TOTAL"><fmt:formatNumber value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/></span></strong>
                                            </div>
                                        </div>
                                        <h4 class="text-color-link">Payment method</h4>
                                        <div>
                                            <strong>Visa:</strong><span>ending with 4242</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                        <div>
                                            <strong>Order #:</strong><span>21591</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                        <div>
                                            <strong>Billing address:</strong><span>abc</span>
                                        </div>
                                    </div>
                                    <div class="receiver-order-item">
                                        <div class="row">
                                            <div class="col-md-4">

                                                <span class="receiver-order-item-left">
                                                    <input name="setting" value="0" type="radio" <c:if test="${LIXI_ORDER.setting eq 0}"> checked="checked"</c:if>  class="custom-checkbox-input"/>
                                                    Gift only
                                                </span>
                                                <span class="receiver-order-item-left">
                                                    ( Do not allow refund to receiver )
                                                </span>
                                            </div>
                                            <div class="col-md-4">
                                                <span class="receiver-order-item-left">
                                                    <input name="setting" value="1" type="radio" <c:if test="${LIXI_ORDER.setting eq 1}">checked="checked"</c:if> class="custom-checkbox-input"/>
                                                    Allow refund to receiver if so choise
                                                </span>
                                            </div>
                                        </div>
                                        <p>( Receiver will be notified right away! Delivery varies: settlement will be 24 to 72 hours. )</p>
                                        <p>By placing your order, you agree to LIXI.GLOBAL <a href="#">private</a> notice and <a target="_blank" href="term-of-user.html">term of use</a>.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="button-control gift-total-wrapper text-center text-uppercase" style="padding-bottom: 20px;">
                        <div class="button-control-page">
                            <button class="btn btn-default btn-has-link-event" type="button" data-link="<c:url value="/checkout/order-summary"/>">Cancel</button>
                            <button type="submit" class="btn btn-primary btn-has-link-event">Place Order</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />        
                </form>
            </div>
        </section>

    </jsp:body>
</template:Client>