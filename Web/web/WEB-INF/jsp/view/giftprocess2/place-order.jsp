<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Place Order">

    <jsp:attribute name="extraHeadContent">
        <style>
            .btn{
                padding-left: 10px;
                padding-right: 10px;
            }
        </style>
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var CALCULATE_FEE_PATH = '<c:url value="/checkout/place-order/calculateFee"/>';
            var CONFIRM_DELETE_MESSAGE = '<spring:message code="message.want_to_delete"/>';
            var PLACE_ORDER_DELETE_GIFT_PATH = '<c:url value="/checkout/delete/gift/"/>';
            var arrQ = [];
            function editRecipient(focusId) {
                $.get('<c:url value="/topUp/editRecipient"/>', function (data) {
                    enableEditRecipientHtmlContent(data);
                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        $('#' + focusId).focus()
                    })

                });
            }
            
            function returnSelected(q, value){
                if(q == value) return " selected=''";
                else return "";
            }
            
            function editQuantity(id){
                var q = $('#q'+id).html();
                // store quantity value
                arrQ[id] = q;
                var editHtml = '<div class="checkbox" style="margin-bottom:0px;"><label style="padding-left:0px;">' + 
                '<input type="text" class="form-control" value="'+q+'"  id="combo'+id+'" style="height:30px;"/>'+
                '<a href="javascript:updateQuantity('+id+');">Change</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;'+
                '<a href="javascript:doRemove('+id+');">Remove</a>'+
                '</label></div>';
        
                $('#gift' + id).html(editHtml);
                
                $('#combo'+id).focus();
            }
            
            function removeEditQuantity(id){
                var editHtml = '<span id="q'+id+'">'+arrQ[id]+'</span> <a href="javascript:editQuantity('+id+');" class="edit-info-event"></a>';
                 $('#gift' + id).html(editHtml);
            }
            
            function updateQuantity(id){
                var combo = $('#combo'+id);
                if(combo.length){
                    if(combo.val() <= 0){
                        if(confirm(CONFIRM_DELETE_MESSAGE)){
                            
                        }
                    }
                }
            }
            
            /**
             * 
             * @param {type} id
             * @returns {undefined}
             */
            function doRemove(id){
                if(confirm(CONFIRM_DELETE_MESSAGE)){
                    overlayOn($('#trGift'+id));
                    $.ajax({
                        url: PLACE_ORDER_DELETE_GIFT_PATH + id,
                        type: "get",
                        dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                            if(data.error == "0"){
                                $('#trGift'+id).remove();
                                //
                                $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                                $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                                $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                                $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                                $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                            }
                            else{
                                alert(data.message);
                            }
                            overlayOff();
                        },
                        error: function (jqXHR, textStatus, errorThrown)
                        {
                            alert(errorThrown);
                            overlayOff();
                        }
                    });
                }
            }
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
                                            <h4 class="text-color-link">Send To: ${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName} <a href="javascript:editRecipient();" class="edit-info-event"></a></h4>
                                            <div>
                                                <strong>Email Address:</strong><span>${entry.recipient.email}</span>
                                            </div>
                                            <div>
                                                <strong>Mobile Phone:</strong><span>${entry.recipient.phone}</span>
                                            </div>
                                        </div>
                                        <div class="receiver-order-summary">
                                            <h4 style="padding-left:18px;margin-bottom: 0px;">Order summary</h4>
                                            <table class="table table-striped">
                                                <thead>
                                                <th style="padding:0px;">
                                                    <div class="col-md-6"></div>
                                                    <div class="col-md-3">Quantity</div>
                                                    <div class="col-md-3">Price</div>
                                                </th>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${entry.gifts}" var="g"  varStatus="giftCount">
                                                        <tr id="trGift${g.id}">
                                                            <td>
                                                                <div class="row">
                                                                    <div class="col-md-6" style="padding-left:40px">${g.productName}</div>
                                                                    <div class="col-md-3" id="gift${g.id}"><span id="q${g.id}">${g.productQuantity}</span> <a href="javascript:editQuantity(${g.id});" class="edit-info-event"></a></div>
                                                                    <div class="col-md-3">USD <fmt:formatNumber value="${g.usdPrice * g.productQuantity}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${g.productPrice * g.productQuantity}" pattern="###,###.##"/></div>
                                                                </div>    
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:forEach items="${entry.topUpMobilePhones}" var="t"  varStatus="tCount">
                                                        <tr>
                                                            <td>
                                                                <div class="row">
                                                                    <div class="col-md-8">Top up mobile phone (${t.phone}) <a href="<c:url value="/topUp/change/${t.id}"/>" class="edit-info-event"></a></div>
                                                                    <div class="col-md-4">USD <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${t.amount * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/></div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody></table> 
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="receiver-info-item">
                                    <div class="receiver-order-item">
                                        <div class="receiver-order-gift-price">
                                            <div>
                                                <strong class="receiver-order-gift-price-left text-bold">Gift Price</strong><span class="receiver-order-gift-price-right">USD <span id="giftPriceUsd"><fmt:formatNumber value="${LIXI_GIFT_PRICE}" pattern="###,###.##"/></span> ~ VND <span id="giftPriceVnd"><fmt:formatNumber value="${LIXI_GIFT_PRICE_VND}" pattern="###,###.##"/></span></span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left">Card Processing fee</strong><span class="receiver-order-gift-price-right">USD <span id="CARD_PROCESSING_FEE_THIRD_PARTY"><fmt:formatNumber value="${CARD_PROCESSING_FEE_THIRD_PARTY}" pattern="###,###.##"/></span></span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left">Lixi handing fee</strong><span class="receiver-order-gift-price-right">USD <span id="lixiHandlingFeeTotal"><fmt:formatNumber value="${LIXI_HANDLING_FEE_TOTAL}" pattern="###,###.##"/></span> (<fmt:formatNumber value="${LIXI_HANDLING_FEE}" pattern="###,###.##"/> per / person )</span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left">Sale Tax</strong><span class="receiver-order-gift-price-right">USD <span id="saleTax"><fmt:formatNumber value="0" pattern="###,###.##"/></span></span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left text-bold" style="color: #000">Total</strong><strong class="receiver-order-gift-price-right text-bold" style="color: #000">USD <span id="LIXI_FINAL_TOTAL"><fmt:formatNumber value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/></span></strong>
                                            </div>
                                        </div>
                                        <h4 class="text-color-link">Payment method <a href="<c:url value="/checkout/paymentMethods"/>" class="edit-info-event"></a></h4>
                                            <c:if test="${not empty LIXI_ORDER.card}">
                                                <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.card.cardNumber)}"/>
                                            <div>
                                                <strong>${LIXI_ORDER.card.cardTypeName}:</strong> <span>ending with ${fn:substring(LIXI_ORDER.card.cardNumber, lengthCard-4, lengthCard)}</span> 
                                            </div>
                                            <div>
                                                <strong>Order #:</strong><span>${LIXI_ORDER.id}</span>
                                            </div>
                                            <div>
                                                <strong>Billing address:</strong><span>${LIXI_ORDER.card.billingAddress.firstName}&nbsp;${LIXI_ORDER.card.billingAddress.lastName}, ${LIXI_ORDER.card.billingAddress.address}</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty LIXI_ORDER.bankAccount}">
                                            <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.bankAccount.checkingAccount)}"/>
                                            <div>
                                                <b>${LIXI_ORDER.bankAccount.name}</b> ending in ${fn:substring(LIXI_ORDER.bankAccount.checkingAccount, lengthCard-4, lengthCard)}
                                            </div>
                                            <br/>
                                            <div>
                                                <b>Billing address:</b> <span id="billingAdd">${LIXI_ORDER.bankAccount.billingAddress.fullName}, ${LIXI_ORDER.bankAccount.billingAddress.add1}
                                            </div>    
                                        </c:if>
                                    </div>
                                    <div class="receiver-order-item">
                                        <div class="row">
                                            <div class="col-md-4">

                                                <div class="checkbox">
                                                    <label style="padding-left: 0px;"><input name="setting" value="0" type="radio" <c:if test="${LIXI_ORDER.setting eq 0}"> checked="checked"</c:if>  class="custom-checkbox-input" style="margin-top: 6px;"/>
                                                            Gift only ( Do not allow refund to receiver )
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="checkbox">
                                                        <label><input name="setting" value="1" type="radio" <c:if test="${LIXI_ORDER.setting eq 1}">checked="checked"</c:if> class="custom-checkbox-input" style="margin-top: 6px;"/>
                                                            Allow Refund to Receiver
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <p>(Receiver will be notified right away. Delivery varies by vendor. Settlement of refund will be 48 to 72 hours)</p>
                                            <p> By placing this order, you agree to <a href="<c:url value="/support/terms"/>" target="_blank">Lixi.Global Terms of Use</a> and <a href="<c:url value="/support/privacy"/>" target="_blank">Privacy Policy</a>.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="button-control gift-total-wrapper text-center text-uppercase" style="padding-bottom: 20px;">
                            <div class="button-control-page">
                                <button class="btn btn-default btn-has-link-event" type="button" data-link="<c:url value="/gifts/order-summary"/>">Cancel</button>
                            <button type="submit" class="btn btn-primary btn-has-link-event">Place Order</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />        
                </form>
            </div>
            <!-- Billing Address Modal -->
            <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" id="editRecipientContent">
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>