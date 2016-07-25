<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select A Gift">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-select/css/bootstrap-select.min.css"/>">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var FIRST_NAME_ERROR = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_ERROR = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_ERROR = '<spring:message code="validate.user.email"/>';
            var CONF_EMAIL_ERROR = '<spring:message code="validate.user.emailConf"/>';
            var PHONE_ERROR = '<spring:message code="validate.phone_required"/>';
            var NOTE_ERROR = '<spring:message code="validate.user.note_required"/>';
            var PLEASE_SELECT_REC = '<spring:message code="gift.select_recipient"/>';
            var CORRECT_QUANTITY = '<spring:message code="correct-quantity" text="correct-quantity"/>';
            var CONFIRM_DELETE_MESSAGE = '<spring:message code="message.want_to_delete"/>';
            var SOMETHING_WRONG_ERROR = '<spring:message code="validate.there_is_something_wrong"/>';
            var DELETE_RECEIVER_MESSAGE = '<spring:message code="message.delete_receiver"/>';
            var AJAX_LOAD_PRODUCTS_PATH = '<c:url value="/gifts/ajax/products"/>';
            var AJAX_CHECK_EXCEED_PATH = '<c:url value="/gifts/ajax/checkExceed"/>';
            var EDIT_REC_URL = '<c:url value="/recipient/ajax/edit/"/>';
            var CREATE_REC_URL = '<c:url value="/recipient/ajax/edit/0"/>';
            jQuery(document).ready(function () {
                
                if ($('.receiver-control-box').length > 0) {
                    $('.receiver-control-box .selectpicker').on('change', function () {
                        var obj = $(this);
                        var selected = $(this).find("option:selected").val();
                        var receiverObj = obj.closest('.receiver-control-box').find('.edit-receiver');
                        if (parseInt(selected) > 0) {
                            receiverObj.attr('data-receiver-id', selected);
                            receiverObj.fadeIn();
                        } else {
                            receiverObj.fadeOut();
                        }
                    });
                    jQuery('button.edit-receiver').click(function () {
                        var obj = $(this);
                        var receiverId = obj.attr('data-receiver-id');
                        if (parseInt(receiverId) > 0) {
                            //BootstrapDialog.show({
                            //   cssClass: 'dialog-no-header',
                            //    title: 'Edit receiver',
                            //    message: $('<div class="edit-reciprt-wrapper">Edit receiver ID: ' + receiverId + '</div>')
                            //});
                            doEditRecipient(receiverId);
                        }
                    });
                }
                $('#btnSubmit').click(function(){
                    <c:if test="${empty sessionScope['scopedTarget.loginedUser'].email}">
                        var nextUrl = "?signInFailed=4&nextUrl=" + getNextUrl();
                        window.location.href = CONTEXT_PATH + '/user/signIn' + nextUrl;
                        return false;
                    </c:if>
                    <c:if test="${not empty sessionScope['scopedTarget.loginedUser'].email}">
                        if(!isInteger($('#quantity').val())){
                            alert(CORRECT_QUANTITY);
                            return false;
                        }
                        if($('#recId').val()==0){
                            alert(PLEASE_SELECT_REC);
                            $('#recId').focus();
                            return false;
                        }
                        return true;
                    </c:if>
                });
                
                $('#recId').change(function(){
                    if($('#recId').val() > 0){
                        doEditRecipient($('#recId').val());
                    }
                });
                
            });
            function doEditRecipient(id) {
                $.get(EDIT_REC_URL + id, function (data) {
                    // check session expired
                    try{
                        if(jQuery.parseJSON(data).sessionExpired ==='1'){
                            var nextUrl = "?nextUrl=" + getNextUrl();
                            window.location.href = CONTEXT_PATH + '/user/signIn' + nextUrl;
                            return;
                        }
                    }catch(err){}
                    enableEditRecipientHtmlContent(data, recOnDetailGift);
                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                        $("#chooseRecipientForm #phone").mask("(999) 999-999?9");
                    })

                });
            }
            
            function createNewRecipient() {
                $.get(CREATE_REC_URL, function (data) {
                    try{
                        if(jQuery.parseJSON(data).sessionExpired ==='1'){
                            var nextUrl = "?nextUrl=" + getNextUrl();
                            window.location.href = CONTEXT_PATH + '/user/signIn' + nextUrl;
                            return;
                        }
                    }catch(err){}

                    enableEditRecipientHtmlContent(data, recOnDetailGift);
                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                        $("#chooseRecipientForm #firstName").focus();
                        $("#chooseRecipientForm #phone").mask("(999) 999-999?9");
                    })

                });
            }
        </script>
        <script src = "<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-select/js/bootstrap-select.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/gifts.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/recipient.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="section-gift section-wrapper">
            <div class="container">
                <c:set var="localStep" value="4"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="section-gift-top">
                    <div class="row">
                        <c:url value="/gifts/buy" var="buyGiftUrl"/>
                        <form method="post" action="${buyGiftUrl}">
                        <div class="col-md-5" style="min-height: 384px;">
                            <div class="wrap_img_detail" style="min-height: 384px;">
                                <div class="img" style="min-height: 384px;vertical-align: baseline;text-align: center;">
                                    <img src="${p.imageUrl}" height="" style="vertical-align: middle;width: 100%;border: 0;">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="row">
                                <div class="col-md-12">
                                    <h2 class="text-color-black">${p.name}</h2>
                                </div>
                            </div>
                            <div class="row" style="margin-bottom: 20px;">
                                <div class="col-md-2 col-sm-2 col-xs-2">
                                    <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                                    <h5>Dollar</h5>
                                    <h4 class="title price price-on-detail" style="color: #0054a5;"><fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/></h4>
                                </div>
                                <div class="col-md-1 col-sm-1 col-xs-1">
                                    <strong style="font-size: 1.5em; margin-top: 20px; display: block;">~</strong>
                                </div>
                                <div class="col-md-9 col-sm-9 col-xs-9">
                                    <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                                    <h5>Vietnam Dong</h5>
                                    <h4 class="title price price-on-detail" style="color: #0054a5;"><fmt:formatNumber value="${p.price}" pattern="###,###.##"/></h4>
                                </div>
                            </div>
                            <div class="row" style="margin-bottom: 30px;">
                                <div class="col-md-2 col-sm-3 col-xs-4"><h4><spring:message code="quantity"/></h4></div>
                                <div class="col-md-10 col-sm-9 col-xs-8">
                                    <div id="giftNumberBox" class="gift-number-box" style="margin: inherit">
                                        <div class="input-group">
                                            <span class="input-group-btn">
                                                <button onclick="LixiGlobal.Gift.initSubBtn(this);" class="btn btn-default gift-sub-event" type="button"><i class="fa fa-chevron-down"></i></button>
                                            </span>
                                            <c:set var="quantity" value="1"/>
                                            <c:if test="${not empty p.quantity}"><c:set var="quantity" value="${p.quantity}"/></c:if>
                                            <input id="quantity" readonly="" style="z-index: 0;background-color: #fff;" type="text" min="1" name="quantity" value="${quantity}" class="form-control bfh-number gift-number" buttons="false" max="10" placeholder="Number"/>
                                            <input type="hidden" name="productId" id="productId" value="${p.id}"/>
                                            <span class="input-group-btn">
                                                <button onclick="LixiGlobal.Gift.initAddBtn(this);"  class="btn btn-default gift-add-event" type="button"><i class="fa fa-chevron-up"></i></button>
                                            </span>
                                        </div><!-- /input-group -->
                                    </div>

                                </div>
                            </div>
                            <div class="receiver-box">
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-xs-12"><h4><spring:message code="mess.rec"/></h4></div>
                                    <div class="col-md-5 col-sm-5 col-xs-7">
                                        <div class="position-relative receiver-control-box">
                                            <select name="recId" id="recId" class="selectpicker show-tick" data-live-search="true" data-style="btn-danger" data-width="100%">
                                                <option value="0"><spring:message code="select-a-rec"/></option>
                                                <c:forEach items="${RECIPIENTS}" var="rec">
                                                    <option data-icon="glyphicon-user" value="${rec.id}">${rec.fullName} - ${rec.phone} - ${rec.email} </option>
                                                </c:forEach>
                                            </select>
                                            <button type="button" class="edit-receiver" title="Edit receiver" rel="tooltip"><i class="fa fa-edit"></i></button>
                                        </div>
                                    </div>
                                    <div class="col-md-4 col-sm-4 col-xs-5">
                                        <button type="button" class="btn btn-default" onclick="createNewRecipient()"><spring:message code="create-new-rec"/></button>
                                    </div>
                                </div>
                                <div class="receiver-break-line"></div>
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-5">
                                        <button id="btnSubmit" type="submit" class="btn btn-primary text-uppercase receiver-buy-gift" style="line-height: 40px;"><spring:message code="buy-gift" text="Buy Gift"/></button>
                                    </div>
                                    <div class="col-md-6 col-sm-6 col-xs-7" style="margin-top: 5px;color: #0090d0;font-weight: 400;">

                                        <span style="color: #696969;"><spring:message code="your-order-total" text="Your order total"/></span><br/>
                                        <span class="gift-total-box-right">
                                            <span>USD</span>
                                            <span id="currentPaymentUSD"><fmt:formatNumber value="${CURRENT_PAYMENT_USD}" pattern="###,###.##"/></span>
                                            <span>~</span>
                                            <span>VND</span>
                                            <span id="currentPaymentVND"><fmt:formatNumber value="${CURRENT_PAYMENT_VND}" pattern="###,###.##"/></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </form>
                    </div>
                    <div class="break-line-default"></div>
                    <div class="product-detail-box">
                        <h2 class="product-detail-title"><spring:message code="product-desc" text="Product Description"/></h2>
                        <div class="product-detail-content">
                            ${p.description}
                        </div>
                    </div>
                    <div class="break-line-default"></div>
                    <c:if test="${not empty BEST_SELLING_PRODUCTS}">
                    <div class="best-selling-product">
                        <h2 class="product-detail-title text-uppercase"><spring:message code="best-selling" text="Best selling products"/></h2>
                        <div class="best-selling-product-content">
                            <ul class="list-pd">
                                <c:forEach items="${BEST_SELLING_PRODUCTS}" var="p" varStatus="theCount">
                                    <li>
                                        <div class="img">
                                            <a href="<c:url value="/gifts/detail/${p.id}"/>">
                                                <img src="${p.imageUrl}" alt="${p.name}">
                                            </a>
                                        </div>
                                        <div class="copy js-height" style="height: 109px;">
                                            <p class="product_name">${p.name}</p>
                                            <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                                            <h4 class="title price" style="font-size: 0.8em;">USD <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${p.price}" pattern="###,###.##"/></h4>
                                        </div>
                                        <a href="<c:url value="/gifts/detail/${p.id}"/>"><span></span></a>
                                    </li>
                                </c:forEach>
                                <li>
                                    <div class="img">
                                        <a href="<c:url value="/topUp"/>">
                                            <img alt="Mobile Top Up" src="<c:url value="/resource/theme/assets/lixi-global/images/icon-topup.png"/>">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Mobile Top up</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD <fmt:formatNumber value="${100000.0/LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> ~ VND 100,000</h4>
                                    </div>
                                    <a href="<c:url value="/topUp"/>"><span></span></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    </c:if>
                </div>
                <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" id="editRecipientContent">
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="chooseCategoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title"><spring:message code="please-select-category"/></h4>
                            </div>
                            <div class="modal-body">
                                <div class="gift-selection">
                                    <div class="gift-selection-icon text-center">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="gift-icon">
                                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.candies.id}"/>">
                                                        <span class="gift-icon-category gift-icon-2"></span>
                                                        <h5><spring:message code="mess.candies"/></h5>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="gift-icon">
                                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.jewelries.id}"/>">
                                                        <span class="gift-icon-category gift-icon-3"></span>
                                                        <h5><spring:message code="mess.jewelries"/></h5>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="gift-icon">
                                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.perfume.id}"/>">
                                                        <span class="gift-icon-category gift-icon-4"></span>
                                                        <h5><spring:message code="mess.perfume"/></h5>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="gift-icon">
                                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.cosmetics.id}"/>">
                                                        <span class="gift-icon-category gift-icon-5"></span>
                                                        <h5><spring:message code="mess.cosmetic"/></h5>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="gift-icon">
                                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.childrentoy.id}"/>">
                                                        <span class="gift-icon-category gift-icon-6"></span>
                                                        <h5><spring:message code="mess.children-toy"/></h5>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="gift-icon">
                                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.flowers.id}"/>">
                                                        <span class="gift-icon-category gift-icon-7"></span>
                                                        <h5><spring:message code="mess.flowers"/></h5>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="gift-icon">
                                                    <a href="<c:url value="/topUp"/>">
                                                        <span class="gift-icon-category gift-icon-1"></span>
                                                        <h5><spring:message code="mess.mobile-top-up"/></h5>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div></div>
                            </div>
                        </div>
                    </div></div>
                                
        </section>
    </jsp:body>
</template:Client>