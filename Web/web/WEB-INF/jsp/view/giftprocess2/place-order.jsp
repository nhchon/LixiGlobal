<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Place Order">

    <jsp:attribute name="extraHeadContent">
        <script language="javascript" src="https://d1cr9zxt7u0sgu.cloudfront.net/crfp.js?SITE_ID=2b57448f3013fc513dcc7a4ab933e6928ab74672&SESSION_ID=${pageContext.session.id}&TYPE=JS" type="text/javascript" charset="UTF-8"></script>
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
            var AJAX_CHECK_TOPUP_EXCEED_PATH = '<c:url value="/topUp/ajax/update"/>';
            var FIRST_NAME_ERROR = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_ERROR = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_ERROR = '<spring:message code="validate.user.email"/>';
            var EMAIL_ERROR = '<spring:message code="validate.user.email"/>';
            var CONF_EMAIL_ERROR = '<spring:message code="validate.user.emailConf"/>';
            var PHONE_ERROR = '<spring:message code="validate.phone_required"/>';
            var NOTE_ERROR = '<spring:message code="validate.user.note_required"/>';
            var CONFIRM_DELETE_MESSAGE = '<spring:message code="message.want_to_delete"/>';
            var SOMETHING_WRONG_ERROR = '<spring:message code="validate.there_is_something_wrong"/>';
            var DELETE_RECEIVER_MESSAGE = '<spring:message code="message.delete_receiver"/>';
            var ALLOW_RECEIVER = '<spring:message code="allow-th-recei"/>'
            var CALCULATE_FEE_PATH = '<c:url value="/checkout/place-order/calculateFee"/>';
            var PLACE_ORDER_DELETE_RECEIVER_PATH = '<c:url value="/checkout/delete/receiver/"/>';
            var PLACE_ORDER_DELETE_TOPUP_PATH = '<c:url value="/checkout/delete/topUp/"/>';
            var PLACE_ORDER_DELETE_GIFT_PATH = '<c:url value="/checkout/ajax/delete/gift/"/>';
            var PLACE_ORDER_UPDATE_GIFT_PATH = '<c:url value="/checkout/ajax/update/gift/"/>';
            var EDIT_REC_URL = '<c:url value="/recipient/ajax/edit/"/>';
            var arrQ = [];
            
            function noAllowRefund(){
                $("#rGiftOnly").prop("checked", true).change();
            }
            
            function yesAllowRefund(){
                $('#confirmAllowRefundModal').modal("hide");
                processingYourOrder();
            }
            
            function preProcessTheOrder(){
                var allowRefund = $("input[name=setting]:checked").val();
                var processOrder = true;
                if (allowRefund == 1) {
                    $('#confirmAllowRefundModal').modal('show');
                }
                else{
                    $('#confirmAllowRefundModal').modal("hide");
                    processingYourOrder();
                }
            }
            
            function processingYourOrder() {
                //var allowRefund = $("input[name=setting]:checked").val();
                var processOrder = true;
                //if (allowRefund == 1) {
                //    if (confirm(ALLOW_RECEIVER)) {
                //
                //    } else {
                //        processOrder = false;
                //    }
                //}
                if (processOrder) {
                    $('#processingYourOrder').modal({backdrop: 'static', keyboard: false});
                    var postData = $('#placeOrderForm').serializeArray();
                    var formURL = $('#placeOrderForm').attr("action");
                    $.ajax(
                            {
                                url: formURL,
                                type: "POST",
                                data: postData,
                                dataType: 'json',
                                success: function (data, textStatus, jqXHR)
                                {
                                    //data: return data from server
                                    if (data.error === '0') {
                                    } else {
                                        alert(data.message);
                                    }
                                    window.location.href = data.returnPage;
                                },
                                error: function (jqXHR, textStatus, errorThrown)
                                {
                                    //if fails
                                    alert(SOMETHING_WRONG_ERROR + " : " + errorThrown);
                                }
                            });
                }
            }
            function closeModelProcessingYourOrder() {
                $('#processingYourOrder').modal('hide');
            }

            function showPageBillAdd(page) {
                $.get('<c:url value="/checkout/choose-billing-address-modal?paging.page"/>=' + page, function (data) {
                    $('#billingAddressListContent').html(data);
                    $('#billingAddressListModal').modal({show: true});
                });
            }

            function doEditRecipient(id) {
                $.get('<c:url value="/recipient/edit/"/>' + id, function (data) {
                    enableEditRecipientHtmlContent(data, recOnPlaceOrder);
            <%-- Did not show delete button on place-order page --%>
                    $('#btnDeleteRec').hide();

                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                        $("#chooseRecipientForm #phone").mask("(999) 999-999?9");
                    })

                });
            }

            function editRecipient(id) {
                $('#editRecipientSpan' + id).html('<span style="font-size:12px;"><a style="font-size:12px;" href="javascript:doEditRecipient(' + id + ');"> Update </a>|<a style="font-size:12px;" href="javascript:deleteReceiver(' + id + ');"> Remove </a> | <a style="font-size:12px;" href="javascript:cancelEditReceiver(' + id + ');"> Cancel </a></span>')
            }

            function deleteReceiver(id) {
                if (confirm(DELETE_RECEIVER_MESSAGE)) {
                    overlayOn($('#placeOrderContentDiv'));
                    $.ajax({
                        url: PLACE_ORDER_DELETE_RECEIVER_PATH + id,
                        type: "get",
                        dataType: 'json',
                                success: function (data, textStatus, jqXHR)
                                {
                            if (data.error == "0") {

                                if ($('.receiver-info-item').length === 2) {

                                    $('.receiver-info-item').remove();

                                    $('#thankyouBeing').html("Your Shopping Cart is empty !");

                                    $('#thankyouBeing').after("<p>Tang qua. Tang niem vui.</p>")

                                    $('#btnSubmit').remove();

                                    $('#btnLogOut').show();
                                } else {
                                    // remove the ceiver
                                    $('#receiver' + id).remove();
                                }
                                //
                                $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                                $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                                $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                                $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                                $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                                /* */
                                updateShoppingCart(data.LIXI_GIFT_PRICE, data.LIXI_GIFT_PRICE_VND);
                            } else {
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

            function cancelEditReceiver(id) {
                $('#editRecipientSpan' + id).html('<a href="javascript:editRecipient(' + id + ');" class="edit-info-event"></a>');
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
                        '<a href="javascript:updateQuantity(' + id + ');">Update</a> | ' +
                        '<a href="javascript:doRemove(' + id + ');">Remove</a> | ' +
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
                    } else {
                        overlayOn($('#placeOrderContentDiv'));
                        $.ajax({
                            url: PLACE_ORDER_UPDATE_GIFT_PATH + id + '/' + combo.val(),
                            type: "get",
                            dataType: 'json',
                                    success: function (data, textStatus, jqXHR)
                                    {
                                try {
                                    if (data.sessionExpired === '1') {
                                        var nextUrl = "?nextUrl=" + getNextUrl();
                                        window.location.href = CONTEXT_PATH + '/user/signIn' + nextUrl;
                                        return;
                                    }
                                } catch (err) {
                                }

                                if (data.exceed == "0") {

                                    removeEditQuantity(id);
                                    $('#q' + id).html(data.NEW_QUANTITY);
                                    $('#itemTotalUsd' + id).html(data.NEW_TOTAL_ITEM_USD);
                                    $('#itemTotalVnd' + id).html(data.NEW_TOTAL_ITEM_VND);
                                    //
                                    $('#giftPriceUsd').html(data.LIXI_GIFT_PRICE);
                                    $('#giftPriceVnd').html(data.LIXI_GIFT_PRICE_VND);
                                    $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.CARD_PROCESSING_FEE_THIRD_PARTY);
                                    $('#lixiHandlingFeeTotal').html(data.LIXI_HANDLING_FEE_TOTAL);
                                    $('#LIXI_FINAL_TOTAL').html(data.LIXI_FINAL_TOTAL);
                                    /* */
                                    updateShoppingCart(data.LIXI_GIFT_PRICE, data.LIXI_GIFT_PRICE_VND);
                                } else {
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
                            try {
                                if (data.sessionExpired === '1') {
                                    var nextUrl = "?nextUrl=" + getNextUrl();
                                    window.location.href = CONTEXT_PATH + '/user/signIn' + nextUrl;
                                    return;
                                }
                            } catch (err) {
                            }

                            if (data.error == "0") {

                                var tBody = $('#trGift' + id).closest('tbody');
                                if (tBody.children("tr").length === 1) {
                                    if ($('.receiver-info-item').length === 2) {

                                        $('.receiver-info-item').remove();

                                        $('#thankyouBeing').html("Your Shopping Cart is empty !");

                                        $('#thankyouBeing').after("<p>Tang qua. Tang niem vui.</p>")

                                        $('#btnSubmit').remove();

                                        $('#btnLogOut').show();
                                    } else {
                                        // remove the ceiver
                                        tBody.closest('.receiver-info-item').remove();
                                    }
                                } else {
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
                            } else {
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

            function changeTopUp(id) {

                checkExceedTopUpOnPlaceOrder(id, $('#amount' + id).val());

            }

            function cancelEditTopUp(id) {

                var amount = $('#topUpDiv' + id).attr("amount");

                $('#topUpDiv' + id).html('VND <span id="topUp' + id + '">' + amount + '</span> <a href="javascript:editTopUp(' + id + ');" class="edit-info-event"></a>');
            }

            function editTopUp(id) {
                var amount = $('#topUpDiv' + id).attr("amount");
                //alert(amount)
                $('#topUpDiv' + id).html('<select class="form-control" id="amount' + id + '">' +
                        '<option value="100000" ' + (amount === "100,000" ? "selected" : "") + '>100,000 VND</option>' +
                        '<option value="200000" ' + (amount === "200,000" ? "selected" : "") + '>200,000 VND</option>' +
                        '<option value="300000" ' + (amount === "300,000" ? "selected" : "") + '>300,000 VND</option>' +
                        '<option value="500000" ' + (amount === "500,000" ? "selected" : "") + '>500,000 VND</option>' +
                        '</select><a href="javascript:changeTopUp(' + id + ');"> Update </a>|<a href="javascript:deleteTopUp(' + id + ');"> Remove </a> | <a href="javascript:cancelEditTopUp(' + id + ');"> Cancel </a>');

            }

            function deleteTopUp(id) {
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
                                    if ($('.receiver-info-item').length === 2) {

                                        $('.receiver-info-item').remove();

                                        $('#thankyouBeing').html("Your Shopping Cart is empty !");

                                        $('#thankyouBeing').after("<p>Tang qua. Tang niem vui.</p>")

                                        $('#btnSubmit').remove();

                                        $('#btnLogOut').show();
                                    } else {
                                        // remove the ceiver
                                        tBody.closest('.receiver-info-item').remove();
                                    }
                                } else {
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
                            } else {
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
        <section class="section-gift main-section">
            <div class="container">
                <c:set var="localStep" value="7"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <c:url value="/checkout/place-order" var="placeOrderUrl"/>
                <form id="placeOrderForm" method="post" class="receiver-form" action="${placeOrderUrl}">
                    <div class="section-receiver">
                        <h2 class="title"><spring:message code="review-your-order"/></h2>

                        <c:if test="${LIXI_FINAL_TOTAL eq 0}">
                            <p class="text-uppercase" id="thankyouBeing">
                                <spring:message code="cart-empty"/> !
                            </p>
                            <p><spring:message code="sologan"/></p>
                        </c:if>
                        <c:if test="${LIXI_FINAL_TOTAL gt 0}">
                            <p class="text-uppercase" id="thankyouBeing">
                                <spring:message code="thank-being-a-cus"/>!  
                            </p>
                        </c:if>
                        <div class="clean-paragraph"></div>
                        <div class="receiver-info-wrapper">
                            <div class="receiver-info-items" id="placeOrderContentDiv">
                                <c:if test="${LIXI_FINAL_TOTAL gt 0}">
                                    <c:forEach items="${REC_GIFTS}" var="entry">
                                        <div class="receiver-info-item" id="receiver${entry.recipient.id}">
                                            <div class="receiver-sent-to">
                                                <h4 class="text-color-link"><spring:message code="order.send_to"/>: <span id="recName${entry.recipient.id}">${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName}</span> <span id="editRecipientSpan${entry.recipient.id}"><a href="javascript:editRecipient(${entry.recipient.id});" class="edit-info-event"></a></span></h4>
                                                <div>
                                                    <strong><spring:message code="mess.email-address"/>:</strong><span id="recEmail${entry.recipient.id}">${entry.recipient.email}</span>
                                                </div>
                                                <div>
                                                    <strong><spring:message code="message.mobile_number"/>:</strong><span id="recPhone${entry.recipient.id}">${entry.recipient.phone}</span>
                                                </div>
                                            </div>
                                            <div class="receiver-order-summary">
                                                <h4 style="padding-left:18px;margin-bottom: 0px;"><spring:message code="order-summary"/></h4>
                                                <table class="table table-striped">
                                                    <thead>
                                                    <th style="padding:0px;">
                                                        <div class="col-md-6"></div>
                                                        <div class="col-md-3"><spring:message code="quantity"/></div>
                                                        <div class="col-md-3"><spring:message code="message.price"/></div>
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
                                                                        <div class="col-md-3" id="topUpDiv${t.id}" amount="<fmt:formatNumber value="${t.amount}" pattern="###,###.##"/>"><span id="topUp${t.id}">VND <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/></span> <a href="javascript:editTopUp(${t.id});" class="edit-info-event"></a></div>
                                                                        <div class="col-md-3">USD <span id="topUpUsd${t.id}"><fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/></span> ~ VND <span id="topUpVnd${t.id}"><fmt:formatNumber value="${t.amount}" pattern="###,###.##"/></span></div>
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
                                                    <strong class="receiver-order-gift-price-left text-bold"><spring:message code="mess.gift-price"/></strong><span class="receiver-order-gift-price-right">USD <span id="giftPriceUsd"><fmt:formatNumber minFractionDigits="2" value="${LIXI_GIFT_PRICE}" pattern="###,###.##"/></span> ~ VND <span id="giftPriceVnd"><fmt:formatNumber minFractionDigits="2" value="${LIXI_GIFT_PRICE_VND}" pattern="###,###.##"/></span></span> (FX 1 USD = <fmt:formatNumber value="${LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/> VND)
                                                </div>
                                                <div>
                                                    <strong class="receiver-order-gift-price-left"><spring:message code="mess.card-process-fee"/></strong><span class="receiver-order-gift-price-right">USD <span id="CARD_PROCESSING_FEE_THIRD_PARTY"><fmt:formatNumber minFractionDigits="2"  value="${CARD_PROCESSING_FEE_THIRD_PARTY}" pattern="###,###.##"/></span></span>
                                                </div>
                                                <div>
                                                    <strong class="receiver-order-gift-price-left"><spring:message code="mess.lixi-handle-fee"/></strong><span class="receiver-order-gift-price-right">USD <span id="lixiHandlingFeeTotal"><fmt:formatNumber minFractionDigits="2" value="${LIXI_HANDLING_FEE_TOTAL}" pattern="###,###.##"/></span> (<fmt:formatNumber minFractionDigits="2" value="${LIXI_HANDLING_FEE}" pattern="###,###.##"/> per / person )</span>
                                                </div>
                                                <div>
                                                    <strong class="receiver-order-gift-price-left"><spring:message code="mess.sale-tax"/></strong><span class="receiver-order-gift-price-right">USD <span id="saleTax"><fmt:formatNumber  minFractionDigits="2" value="0.00" pattern="###,###.##"/></span></span>
                                                </div>
                                                <div>
                                                    <strong class="receiver-order-gift-price-left text-bold" style="color: #000">Total</strong><strong class="receiver-order-gift-price-right text-bold" style="color: #000">USD <span id="LIXI_FINAL_TOTAL"><fmt:formatNumber  minFractionDigits="2" value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/></span></strong>
                                                </div>
                                            </div>
                                            <h4 class="text-color-link"><spring:message code="mess.payment-method"/> <a href="<c:url value="/checkout/paymentMethods"/>" class="edit-info-event"></a></h4>
                                                <c:if test="${not empty LIXI_ORDER.card}">
                                                    <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.card.cardNumber)}"/>
                                                <div>
                                                    <strong>${LIXI_ORDER.card.cardTypeName}:</strong> <span><spring:message code="ending-with"/>&nbsp;${fn:substring(LIXI_ORDER.card.cardNumber, lengthCard-4, lengthCard)}</span> 
                                                </div>
                                                <div>
                                                    <strong><spring:message code="mess.order"/> #:</strong><span>${LIXI_ORDER_ID}</span>
                                                </div>
                                                <div>
                                                    <strong><spring:message code="mess.billing-address"/>:</strong><span>${LIXI_ORDER.card.billingAddress.firstName}&nbsp;${LIXI_ORDER.card.billingAddress.lastName}, ${LIXI_ORDER.card.billingAddress.address}</span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty LIXI_ORDER.bankAccount}">
                                                <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.bankAccount.checkingAccount)}"/>
                                                <div>
                                                    <b>${LIXI_ORDER.bankAccount.name}</b>&nbsp;ending in ${fn:substring(LIXI_ORDER.bankAccount.checkingAccount, lengthCard-4, lengthCard)}
                                                </div>
                                                <br/>
                                                <div>
                                                    <b><spring:message code="mess.billing-address"/>:</b> <span id="billingAdd">${LIXI_ORDER.bankAccount.billingAddress.fullName}, ${LIXI_ORDER.bankAccount.billingAddress.add1}
                                                </div>    
                                            </c:if>
                                        </div>
                                        <div class="receiver-order-item">
                                            <div class="row">
                                                <table>
                                                    <tr>
                                                        <td style="padding-left:15px;">
                                                            <div class="checkbox">
                                                                <label style="padding-left: 0px;"><input id="rGiftOnly" name="setting" value="0" type="radio" <c:if test="${LIXI_ORDER.setting eq 0}"> checked="checked"</c:if>  class="custom-checkbox-input" style="margin-top: 6px;"/>
                                                                    <spring:message code="gift-only"/>
                                                                </label>
                                                            </div>

                                                        </td>
                                                        <td style="padding-left:15px;">
                                                            <div class="checkbox">
                                                                <label><input id="rAllowRefund" name="setting" value="1" type="radio" <c:if test="${LIXI_ORDER.setting eq 1}">checked="checked"</c:if> class="custom-checkbox-input" style="margin-top: 6px;"/>
                                                                    <spring:message code="allow-refund"/>
                                                                </label>
                                                            </div>                                                            
                                                        </td>
                                                        <td style="padding-left:50px;">
                                                            <!-- (c) 2005, 2016. Authorize.Net is a registered trademark of CyberSource Corporation --> 
                                                            <div class="AuthorizeNetSeal"> 
                                                                <script type="text/javascript" language="javascript">var ANS_customer_id = "8d3196bc-e4f9-4a2a-b283-292c0687257d";</script> 
                                                                <script type="text/javascript" language="javascript" src="//verify.authorize.net/anetseal/seal.js" ></script> 
                                                                <a href="http://www.authorize.net/" id="AuthorizeNetText" target="_blank">Internet Payment Gateway</a> 
                                                            </div>
                                                        </td>
                                                        <td style="padding-left:50px;">
                                                            <span id="siteseal"><script type="text/javascript" src="https://seal.godaddy.com/getSeal?sealID=25ZSP0L5Lsd3uLmBTIB8PqsJWEv03qyZ8sJtMVacTWHVe1p60GLbLpEo2G4o"></script></span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="padding-left:15px;">
                                                            <p>(<spring:message code="place-desc-1"/>)</p>
                                                            <p> 
                                                                <c:url value="/support/terms" var="termUrl"/>
                                                                <c:url value="/support/privacy" var="privacyUrl"/>
                                                                <spring:message code="place-desc-2" argumentSeparator=";" arguments="${termUrl};${privacyUrl}"/>.
                                                            </p>
                                                        </td>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="button-control gift-total-wrapper text-center text-uppercase" style="padding-bottom: 20px;">
                        <div class="button-control-page" id="btnDiv">
                            <button class="btn btn-warning btn-has-link-event"  style="color: white;" type="button" data-link="<c:url value="/gifts/choose"/>"><spring:message code="keep-shopping"/></button>
                            <c:if test="${LIXI_FINAL_TOTAL gt 0}">
                                <%--<button id="btnSubmit" type="submit" class="btn btn-primary btn-has-link-event">Place Order</button>--%>
                                <button id="btnSubmit" type="button" class="btn btn-primary" onclick="preProcessTheOrder()" style="color:#fff;"><spring:message code="place-order"/></button>    
                                <button id="btnLogOut" style="display:none;" class="btn btn-primary" type="button" onclick="location.href = '<c:url value="/user/signOut"/>'"><spring:message code="log-out"/></button>
                            </c:if>
                            <c:if test="${LIXI_FINAL_TOTAL eq 0}">
                                <button id="btnLogOut" class="btn btn-primary" type="button" onclick="location.href = '<c:url value="/user/signOut"/>'"><spring:message code="log-out"/></button>
                            </c:if>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />        
                </form>
            </div>
            <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" id="editRecipientContent">
                    </div>
                </div>
            </div>
        </section>
        <!-- Modal -->
        <div id="processingYourOrder" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12" style="text-align:center;">
                                <p><spring:message code="we-are-process-your-order"/>.</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">

                                <div class="progress">
                                    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div id="confirmAllowRefundModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><spring:message code="confirm"/></h4>
                    </div>
                    <div class="modal-body">
                        <p><spring:message code="allow-th-recei"/> ?</p>
                    </div>
                    <div class="modal-footer">
                        <button onclick="noAllowRefund()" type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="message.no"/></button>
                        <button onclick="yesAllowRefund()" type="button" class="btn btn-primary"><spring:message code="message.yes"/></button>
                    </div>
                </div>

            </div>
        </div>    </jsp:body>
</template:Client>