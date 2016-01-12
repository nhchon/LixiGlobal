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
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.number.min.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var FIRST_NAME_ERROR = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_ERROR = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_ERROR = '<spring:message code="validate.user.email"/>';
            var PHONE_ERROR = '<spring:message code="validate.phone_required"/>';
            var NOTE_ERROR = '<spring:message code="validate.user.note_required"/>';
            var CONFIRM_DELETE_MESSAGE = '<spring:message code="message.want_to_delete"/>';
            var SOMETHING_WRONG_ERROR = '<spring:message code="validate.there_is_something_wrong"/>';
            var DELETE_RECEIVER_MESSAGE = '<spring:message code="message.delete_receiver"/>';
            var CALCULATE_FEE_PATH = '<c:url value="/checkout/place-order/calculateFee"/>';
            var PLACE_ORDER_DELETE_RECEIVER_PATH = '<c:url value="/checkout/delete/receiver/"/>';
            var PLACE_ORDER_DELETE_TOPUP_PATH = '<c:url value="/checkout/delete/topUp/"/>';
            var PLACE_ORDER_DELETE_GIFT_PATH = '<c:url value="/checkout/delete/gift/"/>';
            var PLACE_ORDER_UPDATE_GIFT_PATH = '<c:url value="/checkout/update/gift/"/>';
            var arrQ = [];
            function doEditRecipient(id) {
                $.get('<c:url value="/recipient/edit/"/>'+id, function (data) {
                    enableEditRecipientHtmlContent(data);
                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })

                });
            }

            function editRecipient(id){
                $('#editRecipientSpan'+id).html('<span style="font-size:12px;"><a style="font-size:12px;" href="javascript:doEditRecipient('+id+');"> Update </a>|<a style="font-size:12px;" href="javascript:deleteReceiver('+id+');"> Remove </a> | <a style="font-size:12px;" href="javascript:cancelEditReceiver('+id+');"> Cancel </a></span>')
            }
            
            function deleteReceiver(id){
                if (confirm(DELETE_RECEIVER_MESSAGE)) {
                    overlayOn($('#placeOrderContentDiv'));
                    $.ajax({
                        url: PLACE_ORDER_DELETE_RECEIVER_PATH + id,
                        type: "get",
                        dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                            if (data.error == "0") {

                                    if($('.receiver-info-item').length === 2){
                                        
                                        $('.receiver-info-item').remove();
                                        
                                        $('#thankyouBeing').html("Your Shopping Cart is empty !");
                                        
                                        $('#thankyouBeing').after("<p>Tang qua. Tang niem vui.</p>")
                                        
                                        $('#btnSubmit').remove();
                                        
                                        $('#btnLogOut').show();
                                    }
                                    else{
                                        // remove the ceiver
                                        $('#receiver'+id).remove();
                                    }
                                //
                                $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                                $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                                $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                                $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                                $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                                /* */
                                updateShoppingCart(data.LIXI_GIFT_PRICE, data.LIXI_GIFT_PRICE_VND);
                            }
                            else {
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
            
            function cancelEditReceiver(id){
                $('#editRecipientSpan'+id).html('<a href="javascript:editRecipient('+id+');" class="edit-info-event"></a>');
            }
            
            function enableEditRecipientHtmlContent(data){

                $('#editRecipientContent').html(data);
                $('#editRecipientModal').modal({show:true});

                // handler submit form
                //callback handler for form submit
                $("#chooseRecipientForm").submit(function(e)
                {
                    var postData = $(this).serializeArray();
                    var formURL = $(this).attr("action");
                    $.ajax(
                    {
                        url : formURL,
                        type: "POST",
                        data : postData,
                        dataType: 'json',
                        success:function(data, textStatus, jqXHR) 
                        {
                            //data: return data from server
                            if(data.error === '0'){
                                // save successfully
                                // hide popup
                                $('#editRecipientModal').modal('hide');
                                // get new phone number
                                var recId = $("#chooseRecipientForm #recId").val();
                                var name = $("#chooseRecipientForm #firstName").val() + " " + $("#chooseRecipientForm #middleName").val() + " " + $("#chooseRecipientForm #lastName").val();
                                $('#recName' + recId).html(name);
                                $('#recPhone' + recId).html($("#chooseRecipientForm #phone").val());
                                $('#recEmail' + recId).html($("#chooseRecipientForm #email").val());
                            }
                            else{
                                alert(SOMETHING_WRONG_ERROR);
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) 
                        {
                            //if fails      
                        }
                    });
                    if(typeof e  !== 'undefined'){
                        e.preventDefault(); //STOP default action
                        //e.unbind(); //unbind. to stop multiple form submit.
                    }
                });
            }

            function returnSelected(q, value) {
                if (q == value)
                    return " selected=''";
                else
                    return "";
            }

            function editQuantity(id) {
                var q = $('#q' + id).html();
                // store quantity value
                arrQ[id] = q;
                var editHtml = '<div class="checkbox" style="margin-bottom:0px;"><label style="padding-left:0px;">' +
                        '<input type="text" class="form-control" value="' + q + '"  id="combo' + id + '" style="height:30px;"/>' +
                        '<a href="javascript:updateQuantity(' + id + ');">Update</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;' +
                        '<a href="javascript:doRemove(' + id + ');">Remove</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;' +
                        '<a href="javascript:removeEditQuantity(' + id + ');">Cancel</a>' +
                        '</label></div>';

                $('#gift' + id).html(editHtml);

                $('#combo' + id).number(true, 0, ',', '');

                $('#combo' + id).focus();
            }

            function removeEditQuantity(id) {
                var editHtml = '<span id="q' + id + '">' + arrQ[id] + '</span> <a href="javascript:editQuantity(' + id + ');" class="edit-info-event"></a>';
                $('#gift' + id).html(editHtml);
            }

            function updateQuantity(id) {
                var combo = $('#combo' + id);
                if (combo.length) {
                    if (combo.val() <= 0) {
                        // call delete 
                        doRemove(id);
                    }
                    else {
                        overlayOn($('#placeOrderContentDiv'));
                        $.ajax({
                            url: PLACE_ORDER_UPDATE_GIFT_PATH + id + '/' + combo.val(),
                            type: "get",
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR)
                            {
                                if (data.exceed == "0") {

                                    removeEditQuantity(id);
                                    $('#q'+id).html(data.NEW_QUANTITY);
                                    $('#itemTotalUsd'+id).html(data.NEW_TOTAL_ITEM_USD);
                                    $('#itemTotalVnd'+id).html(data.NEW_TOTAL_ITEM_VND);
                                    //var tBody = $('#trGift' + id).closest('tbody');
                                    //if (tBody.children("tr").length === 1) {
                                        // remove the ceiver
                                        //tBody.closest('.receiver-info-item').remove();
                                    //}
                                    //else {
                                        // remove the row
                                        //$('#trGift' + id).remove();
                                    //}
                                    //
                                    $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                                    $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                                    $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                                    $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                                    $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                                    /* */
                                    updateShoppingCart(data.LIXI_GIFT_PRICE, data.LIXI_GIFT_PRICE_VND);
                                }
                                else {
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
            }

            /**
             * 
             * @param {type} id
             * @returns {undefined}
             */
            function doRemove(id) {
                if (confirm(CONFIRM_DELETE_MESSAGE)) {
                    overlayOn($('#placeOrderContentDiv'));
                    $.ajax({
                        url: PLACE_ORDER_DELETE_GIFT_PATH + id,
                        type: "get",
                        dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                            if (data.error == "0") {

                                var tBody = $('#trGift' + id).closest('tbody');
                                if (tBody.children("tr").length === 1) {
                                    if($('.receiver-info-item').length === 2){
                                        
                                        $('.receiver-info-item').remove();
                                        
                                        $('#thankyouBeing').html("Your Shopping Cart is empty !");
                                        
                                        $('#thankyouBeing').after("<p>Tang qua. Tang niem vui.</p>")
                                        
                                        $('#btnSubmit').remove();
                                        
                                        $('#btnLogOut').show();
                                    }
                                    else{
                                        // remove the ceiver
                                        tBody.closest('.receiver-info-item').remove();
                                    }
                                }
                                else {
                                    // remove the row
                                    $('#trGift' + id).remove();
                                }
                                //
                                $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                                $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                                $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                                $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                                $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                                /* */
                                updateShoppingCart(data.LIXI_GIFT_PRICE, data.LIXI_GIFT_PRICE_VND);
                            }
                            else {
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
            
            function changeTopUp(id){
                document.location.href = '<c:url value="/topUp/change/"/>' + id;
            }
            
            function cancelEditTopUp(id){
                
                var amount = $('#topUpDiv'+id).attr("amount");
                $('#topUpDiv'+id).html('USD <span id="topUp'+id+'">'+amount+'</span> <a href="javascript:editTopUp('+id+');" class="edit-info-event"></a>');
            }
            
            function editTopUp(id){
                
                $('#topUpDiv'+id).html('<a href="javascript:changeTopUp('+id+');"> Change </a>|<a href="javascript:deleteTopUp('+id+');"> Remove </a> | <a href="javascript:cancelEditTopUp('+id+');"> Cancel </a>');
                
            }
            
            function deleteTopUp(id){
                if (confirm(CONFIRM_DELETE_MESSAGE)) {
                    overlayOn($('#placeOrderContentDiv'));
                    $.ajax({
                        url: PLACE_ORDER_DELETE_TOPUP_PATH + id,
                        type: "get",
                        dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                            if (data.error == "0") {

                                var tBody = $('#trTopUp' + id).closest('tbody');
                                if (tBody.children("tr").length === 1) {
                                    if($('.receiver-info-item').length === 2){
                                        
                                        $('.receiver-info-item').remove();
                                        
                                        $('#thankyouBeing').html("Your Shopping Cart is empty !");
                                        
                                        $('#thankyouBeing').after("<p>Tang qua. Tang niem vui.</p>")
                                        
                                        $('#btnSubmit').remove();
                                        
                                        $('#btnLogOut').show();
                                    }
                                    else{
                                        // remove the ceiver
                                        tBody.closest('.receiver-info-item').remove();
                                    }
                                }
                                else {
                                    // remove the row
                                    $('#trTopUp' + id).remove();
                                }
                                //
                                $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                                $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                                $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                                $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                                $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                                /* */
                                updateShoppingCart(data.LIXI_GIFT_PRICE, data.LIXI_GIFT_PRICE_VND);
                            }
                            else {
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
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/recipient.js"/>"></script>
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
                        
                            <c:if test="${LIXI_FINAL_TOTAL eq 0}">
                                <p class="text-uppercase" id="thankyouBeing">
                                    Your Shopping Cart is empty !
                                </p>
                                <p>Tang qua. Tang niem vui.</p>
                            </c:if>
                            <c:if test="${LIXI_FINAL_TOTAL gt 0}">
                                <p class="text-uppercase" id="thankyouBeing">
                                    Thank you for being a customer!  
                                </p>
                            </c:if>
                        <div class="clean-paragraph"></div>
                        <div class="receiver-info-wrapper">
                            <div class="receiver-info-items" id="placeOrderContentDiv">
                                <c:if test="${LIXI_FINAL_TOTAL gt 0}">
                                <c:forEach items="${REC_GIFTS}" var="entry">
                                    <div class="receiver-info-item" id="receiver${entry.recipient.id}">
                                        <div class="receiver-sent-to">
                                            <h4 class="text-color-link">Send To: <span id="recName${entry.recipient.id}">${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName}</span> <span id="editRecipientSpan${entry.recipient.id}"><a href="javascript:editRecipient(${entry.recipient.id});" class="edit-info-event"></a></span></h4>
                                            <div>
                                                <strong>Email Address:</strong><span id="recEmail${entry.recipient.id}">${entry.recipient.email}</span>
                                            </div>
                                            <div>
                                                <strong>Mobile Phone:</strong><span id="recPhone${entry.recipient.id}">${entry.recipient.phone}</span>
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
                                                                    <div class="col-md-3">USD <span id="itemTotalUsd${g.id}"><fmt:formatNumber value="${g.usdPrice * g.productQuantity}" pattern="###,###.##"/></span> ~ VND <span id="itemTotalVnd${g.id}"><fmt:formatNumber value="${g.productPrice * g.productQuantity}" pattern="###,###.##"/></span></div>
                                                                </div>    
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:forEach items="${entry.topUpMobilePhones}" var="t"  varStatus="tCount">
                                                        <tr id="trTopUp${t.id}">
                                                            <td>
                                                                <div class="row">
                                                                    <div class="col-md-6" style="padding-left:40px">Top up mobile phone (${t.phone})</div>
                                                                    <div class="col-md-3" id="topUpDiv${t.id}" amount="<fmt:formatNumber value="${t.amount}" pattern="###,###.##"/>">USD <span id="topUp${t.id}"><fmt:formatNumber value="${t.amount}" pattern="###,###.##"/></span> <a href="javascript:editTopUp(${t.id});" class="edit-info-event"></a></div>
                                                                    <div class="col-md-3">USD <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${t.amount * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/></div>
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
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="button-control gift-total-wrapper text-center text-uppercase" style="padding-bottom: 20px;">
                        <div class="button-control-page" id="btnDiv">
                            <button class="btn btn-default btn-has-link-event" type="button" data-link="<c:url value="/gifts/recipient"/>">Keep Shopping</button>
                            <c:if test="${LIXI_FINAL_TOTAL gt 0}">
                            <button id="btnSubmit" type="submit" class="btn btn-primary btn-has-link-event">Place Order</button>
                            <button id="btnLogOut" style="display:none;" class="btn btn-primary" type="button" onclick="location.href='<c:url value="/user/signOut"/>'">Log Out</button>
                            </c:if>
                            <c:if test="${LIXI_FINAL_TOTAL eq 0}">
                            <button id="btnLogOut" class="btn btn-primary" type="button" onclick="location.href='<c:url value="/user/signOut"/>'">Log Out</button>
                            </c:if>
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