<template:Client htmlTitle="Lixi Global - Choose Type of Gift">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixi-global/js/recipient.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var FIRST_NAME_ERROR = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_ERROR = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_ERROR = '<spring:message code="validate.user.email"/>';
            var PHONE_ERROR = '<spring:message code="validate.phone_required"/>';
            var NOTE_ERROR = '<spring:message code="validate.user.note_required"/>';
            var SOMETHING_WRONG_ERROR = '<spring:message code="validate.there_is_something_wrong"/>';
            var TOP_UP_EMPTY = '<spring:message code="validate.topup.no_empty"/>';
            var NUM_OF_CARD = '<spring:message code="validate.buyphonecard.num_of_card"/>';

            $(document).ready(function () {
                // check exceed on amount topup
                $('#amountTopUp').change(function () {
                    checkTopUpExceed($(this).val());
                });

                // check exceed on buy phone card
                $('#numOfCard').change(function () {
                    checkBuyPhoneCardExceed($(this).val(), $('#valueOfCard').val());
                });

                $('#valueOfCard').change(function () {
                    checkBuyPhoneCardExceed($('#numOfCard').val(), $('#valueOfCard').val());
                });

                // submit
                $('#btnTopUpKeepShopping').click(function () {
                    // set action
                    $('#topUpAction').val('KEEP_SHOPPING_ACTION');
                    //
                    return checkTopUpMobileForm();
                });

                $('#btnTopUpBuyNow').click(function () {
                    // set action
                    $('#topUpAction').val('BUY_NOW_ACTION');
                    //
                    return checkTopUpMobileForm();
                });

            });

            function checkTopUpExceed(amount) {
                if (amount === '') {
                    $('#topUpInVND').val('');
                }
                else {
                    var topUpId = $('#topUpId').val();
                    if(topUpId === '') topUpId = '0';
                    
                    $.ajax({
                        url: '<c:url value="/topUp/checkTopUpExceed"/>' + '/' + topUpId  + '/' + amount,
                                type: "get",
                        dataType: 'json',
                                success: function (data, textStatus, jqXHR)
                                {
                            if (data.exceed == '1') {
                                $('#divError').remove();
                                $('#topUpPanelBody').prepend('<div class="msg msg-error" id="divError">' + data.message + '</div>')
                                alert(data.message);
                                // disable submit buttons
                                disableTopUpSubmitButtons(true);
                            } else {
                                // no exceed, remove error
                                $('#divError').remove();
                                // update current payment
                                $('#currentPaymentVND').html(data.CURRENT_PAYMENT_VND);
                                $('#currentPaymentUSD').html(data.CURRENT_PAYMENT_USD);
                                //
                                disableTopUpSubmitButtons(false);
                            }
                            $('#topUpInVND').val(data.TOP_UP_IN_VND + " VND");
                        },
                                error: function (jqXHR, textStatus, errorThrown)
                                {
                            //alert(errorThrown);
                            //alert('Đã có lỗi, vui lòng thử lại !'); 
                        }
                    });
                }
            }

            /**
             * 
             * @returns {undefined}             
             *
             */
            function disableTopUpSubmitButtons(enable) {
                $('#btnTopUpKeepShopping').prop('disabled', enable);
                $('#btnTopUpBuyNow').prop('disabled', enable);
            }

            function editRecipient(focusId) {
                $.get('<c:url value="/topUp/editRecipient"/>', function (data) {
                    enableEditRecipientHtmlContent(data);
                    // focus on phone field
                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        $('#' + focusId).focus()
                    })

                });
            }
            
            function enableEditRecipientHtmlContent(data){

                $('#editRecipientContent').html(data);
                $('#editRecipientModal').modal({show:true});

                // change dial code
                $('#iso2Code').change(function(){
                   if($(this).val() === 'VN'){

                       $('#dialCode').val('+84');

                   }
                   else if($(this).val() === 'US'){
                       $('#dialCode').val('+1');
                   }
                });
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
                        //contentType: "application/x-www-form-urlencoded;charset=ISO-8859-1",
                        dataType: 'json',
                        success:function(data, textStatus, jqXHR) 
                        {
                            //data: return data from server
                            if(data.error === '0'){
                                // save successfully
                                // hide popup
                                $('#editRecipientModal').modal('hide');
                                // get new phone number
                                $('#recPhone').val($("#chooseRecipientForm #phone").val());
                                $('#recEmail').val($("#chooseRecipientForm #email").val());
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
            
            /**
             * 
             * @returns {Boolean}
             */
            function checkTopUpMobileForm() {
                if ($.trim($('#amountTopUp').val()) === '0') {
                    alert(TOP_UP_EMPTY);
                    $('#amountTopUp').focus();
                    return false;
                }
                else {
                    return true
                }
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <c:import url="/categories"/>
        <section class="section-gift bg-default main-section">
            <div class="container">
                <c:set var="localStep" value="4"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="section-receiver">      
                    <h2 class="title">Top up mobile phone <span style="font-size: 18px;text-transform: none;">(for ${SELECTED_RECIPIENT.firstName})</span></h2>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-12">
                                <%-- Top up mobile phone --%>
                                <div id="topUpPanel" class="panel panel-default">
                                    <div class="panel-body" id="topUpPanelBody">
                                        <c:if test="${topUpExceed eq 1}">
                                            <div class="msg msg-error" id="divError">
                                                <spring:message code="validate.top_up_exceeded">
                                                    <spring:argument value="${TOP_UP_AMOUNT}"/>
                                                    <spring:argument value="${EXCEEDED_VND}"/>
                                                    <spring:argument value="${EXCEEDED_USD}"/>
                                                </spring:message>
                                            </div>
                                        </c:if>
                                        <c:if test="${addSuccess eq 1}">
                                            <div class="alert alert-success" role="alert">
                                                Top Up Mobile Minute is success
                                            </div>
                                        </c:if>
                                        <c:url value="/topUp/topUpMobilePhone" var="topUpMobilePhoneUrl"/>
                                        <form class="form-horizontal" role="form" method="post" action="${topUpMobilePhoneUrl}">
                                            <div class="form-group">
                                                <label class="col-md-3" for="email">Amount you want to top up</label>
                                                <div class="col-md-7">
                                                    <select id="amountTopUp" name="amountTopUp" class="form-control">
                                                        <option value="0" <c:if test="${amountTopUp eq 0}">selected=""</c:if>>Please select amount to top up</option>
                                                        <option value="10" <c:if test="${amountTopUp eq 10}">selected=""</c:if>>10 USD</option>
                                                        <option value="15" <c:if test="${amountTopUp eq 15}">selected=""</c:if>>15 USD</option>
                                                        <option value="20" <c:if test="${amountTopUp eq 20}">selected=""</c:if>>20 USD</option>
                                                        <option value="25" <c:if test="${amountTopUp eq 25}">selected=""</c:if>>25 USD</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3" for="pwd">Currency conversion rate</label>
                                                <div class="col-md-3"> 
                                                    <input type="text" class="form-control" value="1 USD" readonly="">
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control" value="<fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> VND" readonly="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3" for="pwd">Top up in VND</label>
                                                <div class="col-md-7"> 
                                                    <input type="text" name="topUpInVND" id="topUpInVND" class="form-control" placeholder="<fmt:formatNumber value="${10 * LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> VND" readonly="">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3"><spring:message code="gift.phone_of_recipient"/><span class="errors">*</span></label>
                                                <div class="col-md-7">
                                                    <div class="row">
                                                        <div class="col-md-2" style="padding-right: 0px;">
                                                            <input type="text" name="recDialCode" class="form-control" value="${SELECTED_RECIPIENT.dialCode}" readonly="" style="padding: 6px;"/>
                                                        </div>
                                                        <div class="col-md-8" style="padding-left: 0px;padding-right: 0px;">
                                                            <input type="text" id="recPhone" name="recPhone" class="form-control" readonly="" value="${SELECTED_RECIPIENT.phone}"/>
                                                            <span class="help-block errors"></span>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <button type="button" class="btn btn-default" onclick="editRecipient('phone');">Change</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3"></div>
                                                <div class="col-md-7">
                                                    <input type="hidden" id="topUpId" name="topUpId" value="${topUpId}"/>
                                                    <input type="hidden" value="" id="topUpAction" name="topUpAction"/>
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <button id="btnTopUpBuyNow" type="submit" class="btn btn-warning">Buy Now</button>
                                                    <button id="btnTopUpKeepShopping" type="submit" class="btn btn-primary">Buy & Keep Shopping</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <%-- current payment --%>
                                <div class="row">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-7">
                                        <div class="button-control gift-total-wrapper text-uppercase" style="margin-top:0px;">
                                            <div class="gift-total-box" style="margin:0px;width:400px;">
                                                <span class="gift-total-box-left">order Total</span>
                                                <span class="gift-total-box-right">usd $ <span id="currentPaymentUSD"><fmt:formatNumber value="${CURRENT_PAYMENT_USD}" pattern="###,###.##"/></span> ~ VND <span id="currentPaymentVND"><fmt:formatNumber value="${CURRENT_PAYMENT}" pattern="###,###.##"/></span></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Edit Recipient Modal -->
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Client>