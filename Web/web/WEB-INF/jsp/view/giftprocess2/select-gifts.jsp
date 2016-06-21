<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select Gifts">

    <jsp:attribute name="extraHeadContent">
        <script language="javascript" src="https://cashshieldasia.cashrun.com/crfp.js?SITE_ID=2b57448f3013fc513dcc7a4ab933e6928ab74672&SESSION_ID=${pageContext.session.id}&TYPE=JS" type="text/javascript" charset="UTF-8"></script>
        <style>
            div.pagination-wrapper{
                opacity: .99;
            }
        </style>
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
            var CONFIRM_DELETE_MESSAGE = '<spring:message code="message.want_to_delete"/>';
            var SOMETHING_WRONG_ERROR = '<spring:message code="validate.there_is_something_wrong"/>';
            var DELETE_RECEIVER_MESSAGE = '<spring:message code="message.delete_receiver"/>';
            var AJAX_LOAD_PRODUCTS_PATH = '<c:url value="/gifts/ajax/products"/>';
            var AJAX_CHECK_EXCEED_PATH = '<c:url value="/gifts/ajax/checkExceed"/>';
            var TOTAL_PAGES = 1;
            <c:if test="${not empty PAGES}">
                TOTAL_PAGES = ${PAGES.totalPages};
            </c:if>
            // maximum is 2 pages
            if (TOTAL_PAGES > 2)
                TOTAL_PAGES = 2;

            $(document).ready(function () {
                //alert(window.location.pathname);
                if(window.location.pathname === '<c:url value="/gifts/choose"/>'){
                    $('#chooseCategoryModal').modal({backdrop: 'static', keyboard: false});
                }

                $('#recId').change(function () {
                    if ($(this).val() !== "0") {
                        
                        doEditRecipient();
                        
                        showGiftValueFor();
                        /* */
                        loadPage(1);
                    }
                    else {
                        $('#giftValueFor').hide();
                        $('#btnEditReceiver').hide();
                        /**/
                        $('#recFirstName').html("...");
                    }
                });
                
                $(".gift-product-thumb").each(function(){
                    var zoom = $(this).attr("zoomWindowPosition");
                    $(this).elevateZoom({zoomWindowPosition:parseInt(zoom)});
                });
                
                //
                loadNewPrice(10);
            });

            function showGiftValueFor() {
                $('#giftValueFor').show();
                $('#btnEditReceiver').show();
                /**/
                $('#recFirstName').html($("#recId option:selected").attr("firstname"));
            }

            function createNewRecipient() {
                $.get('<c:url value="/recipient/edit/0"/>', function (data) {
                    enableEditRecipientHtmlContent(data);
                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                        $("#chooseRecipientForm #firstName").focus();
                    })

                });
            }

            function doEditRecipient() {
                $.get('<c:url value="/recipient/edit/"/>' + $('#recId').val(), function (data) {
                    enableEditRecipientHtmlContent(data);
                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })

                });
            }

            function enableEditRecipientHtmlContent(data) {

                $('#editRecipientContent').html(data);
                $('#editRecipientModal').modal({show: true});

                $("#chooseRecipientForm #phone").mask("999999999?9");
                // handler submit form
                //callback handler for form submit
                $("#chooseRecipientForm").submit(function (e)
                {
                    var postData = $(this).serializeArray();
                    var formURL = $(this).attr("action");
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
                                // hide popup
                                $('#editRecipientModal').modal('hide');
                                var name = $("#chooseRecipientForm #firstName").val() + " " + $("#chooseRecipientForm #middleName").val() + " " + $("#chooseRecipientForm #lastName").val();
                                var firstName = $("#chooseRecipientForm #firstName").val();
                                /* new recipient */
                                if (parseInt(data.recId) > 0) {
                                    if(data.action === 'create'){
                                        $('#recId')
                                                .append($("<option></option>")
                                                        .attr("value", data.recId)
                                                        .attr("firstname", firstName)
                                                        .text(name));

                                        $('#recId').val(data.recId);
                                        /* */
                                        showGiftValueFor();
                                    }
                                    else {
                                        // save successfully
                                        var name = $("#chooseRecipientForm #firstName").val() + " " + $("#chooseRecipientForm #middleName").val() + " " + $("#chooseRecipientForm #lastName").val();

                                        $("#recId option:selected").attr("firstname", $("#chooseRecipientForm #firstName").val());
                                        $("#recId option:selected").html(name);
                                        $('#recFirstName').html(firstName);
                                    }
                                }
                            }
                            else {
                                alert(SOMETHING_WRONG_ERROR);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown)
                        {
                            //if fails      
                        }
                    });
                    if (typeof e !== 'undefined') {
                        e.preventDefault(); //STOP default action
                        //e.unbind(); //unbind. to stop multiple form submit.
                    }
                });
            }

        </script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.twbsPagination.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/gifts.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/recipient.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.elevatezoom.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="section-gift bg-default section-wrapper">
            <div class="container">
                <c:set var="localStep" value="4"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="section-gift-top">
                    <div class="row">
                        <div class="col-md-4" style="padding-right: 0px;"><h2 class="title" style="text-transform: none;"><spring:message code="select-a-rec"/> </h2></div>
                        <div class="col-md-3" style="padding-left: 0px;">
                            <select class="form-control" id="recId" name="recId">
                                <option value="0"><spring:message code="gift.select_recipient"/></option>
                                <c:forEach items="${RECIPIENTS}" var="rec">
                                    <option firstname="${rec.firstName}" value="${rec.id}" <c:if test="${recId == rec.id}">selected</c:if>>${rec.firstName}&nbsp;${rec.middleName}&nbsp;${rec.lastName} </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <button id="btnEditReceiver" style="<c:if test="${empty SELECTED_RECIPIENT_FIRST_NAME}">display: none;</c:if>" class="btn btn-primary" onclick="doEditRecipient()"><spring:message code="edit-rec"/></button>
                            <button class="btn btn-primary" onclick="createNewRecipient()"><spring:message code="create-new-rec"/></button>
                        </div>
                    </div>
                    <h2 id="giftValueFor" class="title" style="text-transform: none;<c:if test="${empty SELECTED_RECIPIENT_FIRST_NAME}">display: none;</c:if>"><spring:message code="gift-value-for"/>&nbsp;<span id="recFirstName">${SELECTED_RECIPIENT_FIRST_NAME}</span></h2>
                    <p>( <spring:message code="we-select-at-your-range"/> )</p>
                    <c:set value="150" var="maximumValue"/>
                    <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * maximumValue}" pattern="###,###.##" var="maximumValueVnd"/>
                    <h5 class="maximum-purchase">Maximum purchase is VND ${maximumValueVnd}  or USD ${maximumValue}</h5>
                    <div class="change-curency-box">
                        <div class="btn-group">
                            <button class="btn change-curency-box-des" type="button">
                                <span class="des-box"><spring:message code="locked-exchange-rate"/></span>
                                <span class="amount-box">USD 1 = <strong><fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/></strong> VND</span>
                            </button>
                            <button data-toggle="dropdown" class="btn dropdown-toggle" type="button">
                                <span class="flag flag-vn"></span>
                                <i class="fa fa-chevron-down"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li><a class="flag-link" href="#change-rate" rel="tooltip" title="English"><span class="flag flag-en"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="gift-filter gift-filter-wrapper">
                    <div class="gift-filter-control">
                        <div class="gift-filter-control-slide">
                            <c:set value="10" var="startPrice"/>
                            <c:if test="${not empty SELECTED_AMOUNT_IN_USD}">
                                <c:set value="${SELECTED_AMOUNT_IN_USD}" var="startPrice"/>
                            </c:if>
                            <input type="text" class="gift-filter-slider-input" value="" data-slider-min="10" data-slider-max="150" data-slider-step="5" data-slider-value="10"/>
                        </div>
                        <div class="gift-filter-label">
                            <span class="gift-filter-label-min">
                                <span class="gift-filter-label-usd">USD 10</span>
                                <span class="gift-filter-label-vn">VND <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * 10}" pattern="###,###.##"/></span>
                            </span>
                            <span class="gift-filter-label-max text-right">
                                <span class="gift-filter-label-usd">USD 150</span>
                                <span class="gift-filter-label-vn">VND <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * 150}" pattern="###,###.##"/></span>
                            </span>
                        </div>
                    </div>
                    <div class="gift-filter-items">
                        <h2 class="title">${SELECTED_LIXI_CATEGORY_NAME}</h2>
                        <div class="row" id="divProducts">
                            <%@include file="/WEB-INF/jsp/view/giftprocess2/ajax-products.jsp" %>
                        </div>
                        <div class="pagination-wrapper">
                            <ul id="pagination-data" class="pagination-sm"></ul>
                        </div>
                        <div class="clean-paragraph"></div>
                        <div class="button-control gift-total-wrapper text-center text-uppercase">
                            <div class="gift-total-box">
                                <span class="gift-total-box-left"><spring:message code="order-total"/></span>
                                <span class="gift-total-box-right">
                                    <span>usd</span>
                                    <span id="currentPaymentUSD"><fmt:formatNumber value="${CURRENT_PAYMENT_USD}" pattern="###,###.##"/></span>
                                    <span>~</span>
                                    <span>VND</span>
                                    <span id="currentPaymentVND"><fmt:formatNumber value="${CURRENT_PAYMENT}" pattern="###,###.##"/></span>
                                </span>
                            </div>
                            <div class="button-control-page">
                                <button class="btn btn-default"><spring:message code="message.back"/></button>
                                <button class="btn btn-primary btn-has-link-event"  type="button" data-link="<c:url value="/gifts/order-summary"/>"><spring:message code="message.next"/></button>
                            </div>
                        </div>
                    </div>
                </div>
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