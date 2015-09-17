<template:Client htmlTitle="LiXi Global - Choose Type of Gift">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/type-of-gift.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/recipient.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var FIRST_NAME_ERROR = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_ERROR = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_ERROR = '<spring:message code="validate.user.email"/>';
            var PHONE_ERROR = '<spring:message code="validate.phone_required"/>';
            var NOTE_ERROR = '<spring:message code="validate.user.note_required"/>';
            var SOMETHING_WRONG_ERROR = '<spring:message code="validate.there_is_something_wrong"/>'
            
            $(document).ready(function () {

                // default show/hide panels
                $('#topUpPanel').show();
                $('#buyCardPanel').hide();
                //
                $('#myTabs a').click(function (e) {
                    e.preventDefault()
                    $(this).tab('show')
                    if ($(this).attr('id') === 'buyCardTab') {
                        $('#buyCardPanel').show();
                        $('#topUpPanel').hide();
                    }
                    else
                    if ($(this).attr('id') === 'topUpTab') {
                        $('#topUpPanel').show();
                        $('#buyCardPanel').hide();
                    }
                })
                // check exceed on amount topup
                $('#amountTopUp').change(function(){
                    checkTopUpExceed($(this).val());
                });
            });

            function checkTopUpExceed(amount){
                if(amount === ''){
                    $('#topUpInVND').val('');
                }
                else{
                    $.ajax({
                        url : '<c:url value="/topUp/checkTopUpExceed"/>' + '/'+amount,
                        type: "get",
                        dataType: 'json',
                        success:function(data, textStatus, jqXHR) 
                        {
                            if(data.exceed == '1'){
                                $('#divError').remove();
                                $('#topUpPanelBody').prepend('<div class="msg msg-error" id="divError">' + data.message + '</div>')
                                alert(data.message);
                                // disable submit buttons
                                disableTopUpSubmitButtons(true);
                            }else{
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
                        error: function(jqXHR, textStatus, errorThrown) 
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
            function disableTopUpSubmitButtons(enable){
                $('#btnTopUpKeepShooping').prop('disabled', enable);
                $('#btnTopUpBuyNow').prop('disabled', enable);
            }
            
            function editRecipient(){
                $.get( '<c:url value="/topUp/editRecipient"/>', function( data ) {
                    enableEditRecipientHtmlContent(data)               
                });
            }

        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="type-of-gift">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <fieldset>
                            <legend>Choose Type of Gift</legend>
                        </fieldset>        
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <ul class="list-group">
                                        <li class="list-group-item active">
                                            <div class="radio" style="text-align: center;">
                                                <a href="#">
                                                    <img  width="125" height="161"  src="<c:url value="/resource/theme/assets/lixiglobal/img/mobile.minutes.jpg"/>" />
                                                    <br/>
                                                    Top up mobile minutes
                                                </a>
                                            </div>
                                        </li>
                                        <c:forEach items="${LIXI_CATEGORIES}" var="lxc" varStatus="theCount">
                                            <li class="list-group-item">
                                                <div class="radio" style="text-align: center;">
                                                    <a href="<c:url value="/gifts/type/${lxc.id}"/>">
                                                        <img  width="125" height="161"  src="<c:url value="/showImages/"/>${lxc.icon}" />
                                                        <br/>
                                                        ${lxc.name}
                                                    </a>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="col-md-9">
                                    <ul id="myTabs" class="nav nav-tabs">
                                        <li role="presentation" class="active"><a id="topUpTab" href="#">Top Up Mobile Phone</a></li>
                                        <li role="presentation"><a id="buyCardTab" href="#">Buy Phone Card</a></li>
                                    </ul>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <%-- Top up mobile phone --%>
                                            <div id="topUpPanel" class="panel panel-default" style="border-top: none;">
                                                <div class="panel-body" id="topUpPanelBody">

                                                    <form class="form-horizontal" role="form">
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="email">Amount you want to top up</label>
                                                            <div class="col-sm-7">

                                                                <div class="row">
                                                                    <div class="col-lg-10" style="padding-right: 0px;">
                                                                        <input type="number" name="amountTopUp" id="amountTopUp" min="10" class="form-control" placeholder="10" title="Min is $10"/>
                                                                    </div>
                                                                    <div class="col-lg-2" style="padding-left: 0px;">
                                                                        <input type="text" class="form-control" value="USD" readonly=""/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="pwd">Currency conversion rate</label>
                                                            <div class="col-sm-3"> 
                                                                <input type="text" class="form-control" value="1 USD" readonly="">
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <input type="text" class="form-control" value="<fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> VND" readonly="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="pwd">Top up in VND</label>
                                                            <div class="col-sm-7"> 
                                                                <input type="text" name="topUpInVND" id="topUpInVND" class="form-control" placeholder="<fmt:formatNumber value="${10 * LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> VND" readonly="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5"><spring:message code="gift.phone_of_recipient"/><span class="errors">*</span></label>
                                                            <div class="col-sm-7">
                                                                <div class="row">
                                                                    <div class="col-sm-2" style="padding-right: 0px;">
                                                                        <input type="text" name="recDialCode" class="form-control" value="${SELECTED_RECIPIENT.dialCode}" readonly="" style="padding: 6px;"/>
                                                                    </div>
                                                                    <div class="col-sm-7" style="padding-left: 0px;padding-right: 0px;">
                                                                        <input type="text" id="recPhone" name="recPhone" class="form-control" readonly="" value="${SELECTED_RECIPIENT.phone}"/>
                                                                        <span class="help-block errors"></span>
                                                                    </div>
                                                                    <div class="col-sm-3">
                                                                        <button type="button" class="btn btn-default" onclick="editRecipient();">Change</button>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-12"><span class="help-block">(Only mobile phone number. No first 0 i.e. 967 00 78 69, 169 262 31 88)</span></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group"> 
                                                            <div class="col-sm-offset-2 col-sm-10">
                                                                <button id="btnTopUpKeepShooping" type="submit" class="btn btn-primary">Keep Shopping</button>
                                                                <button id="btnTopUpBuyNow" type="submit" class="btn btn-primary">Buy Now</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>

                                            <%-- Buy Phone Card --%>
                                            <div id="buyCardPanel" class="panel panel-default" style="border-top: none;">
                                                <div class="panel-body">
                                                    <form class="form-horizontal" role="form">
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="email">Select mobile phone company</label>
                                                            <div class="col-sm-7">
                                                                <select class="form-control">
                                                                    <c:forEach items="${PHONE_COMPANIES}" var="p">
                                                                        <option value="${p.code}">${p.name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="pwd">Number of card</label>
                                                            <div class="col-sm-7"> 
                                                                <input type="number" min="1" max="5" class="form-control" value="1">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="email">Value of card</label>
                                                            <div class="col-sm-7">
                                                                <select class="form-control">
                                                                    <option value="100000">100,000 đ</option>
                                                                    <option value="200000">200,000 đ</option>
                                                                    <option value="300000">300,000 đ</option>
                                                                    <option value="500000">500,000 đ</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="pwd">Currency conversion rate</label>
                                                            <div class="col-sm-3"> 
                                                                <input type="text" class="form-control" value="1 USD" readonly="">
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <input type="text" class="form-control" value="<fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> VND" readonly="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="pwd">Amount in USD</label>
                                                            <div class="col-sm-7"> 
                                                                <input type="text" class="form-control" value="<fmt:formatNumber value="${100000 / LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/> USD" readonly="">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-sm-5" for="pwd">Email of receiver of card</label>
                                                            <div class="col-sm-5" style="padding-right: 0px;">
                                                                <input type="text" class="form-control" value="timothy@gmail.com" readonly=""/>
                                                            </div>
                                                            <div class="col-sm-2"> 
                                                                <button type="button" class="btn btn-default" onclick="editRecipient();">&nbsp;Change&nbsp; </button>
                                                            </div>
                                                        </div>
                                                        <div class="form-group"> 
                                                            <div class="col-sm-offset-2 col-sm-10">
                                                                <button type="submit" class="btn btn-primary">Keep Shopping</button>
                                                                <button type="submit" class="btn btn-primary">Buy Now</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                            
                                            <%-- current payment --%>
                                            <div class="row">
                                                <div class="col-lg-6">
                                                    <div class="row">
                                                        <div class="col-lg-8">Your maximum payment amount:</div>
                                                        <div class="col-lg-4" style="padding-left: 0px;text-align: right;">
                                                            <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount * LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/>&nbsp;VND</strong>
                                                            <br/>
                                                            <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount}" pattern="###,###.##"/>&nbsp;${USER_MAXIMUM_PAYMENT.code}</strong>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="pull-right">
                                                        Current payment: <strong><span id="currentPaymentVND"><fmt:formatNumber value="${CURRENT_PAYMENT}" pattern="###,###.##"/></span> VND</strong>
                                                        <br/>
                                                        <div class="pull-right"><strong><span id="currentPaymentUSD"><fmt:formatNumber value="${CURRENT_PAYMENT / LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/></span> USD</strong></div>
                                                    </div>
                                                </div>
                                            </div>                                        
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>
        <!-- Billing Address Modal -->
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Client>