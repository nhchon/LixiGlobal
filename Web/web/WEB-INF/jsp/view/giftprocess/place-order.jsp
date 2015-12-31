<template:Client htmlTitle="Lixi Global - Place Order Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var NOT_NULL_MESSAGE = '<spring:message code="validate.not_null"/>';
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>'
            var BILLING_ADDRESS_MODAL_URL = '<c:url value="/checkout/billing-address-modal"/>';
            
            $(document).ready(function(){
                
                $('input[name=setting]').change(function(){
                   
                    if($(this).prop("checked")){
                        
                        //document.location.href = '<c:url value="/checkout/place-order/settings/"/>' + $(this).val();
                        $.ajax({
                            url : '<c:url value="/checkout/place-order/calculateFee"/>' + '/'+$(this).val(),
                            type: "get",
                            dataType: 'json',
                            success:function(data, textStatus, jqXHR) 
                            {
                                if(data.data.error == '0'){
                                    //alert(data.data.LIXI_HANDLING_FEE_TOTAL);
                                    $('#CARD_PROCESSING_FEE_THIRD_PARTY').html(data.data.CARD_PROCESSING_FEE_THIRD_PARTY)
                                    $('#LIXI_HANDLING_FEE_TOTAL').html(data.data.LIXI_HANDLING_FEE_TOTAL)
                                    $('#LIXI_FINAL_TOTAL').html(data.data.LIXI_FINAL_TOTAL)
                                }
                                else{
                                    // TODO 
                                }
                            },
                            error: function(jqXHR, textStatus, errorThrown) 
                            { 
                                //alert(errorThrown);
                                //alert('Đã có lỗi, vui lòng thử lại !'); 
                            }    
                        });
                        
                    }
                });
                
                
            });
            
            function editMobilePhone(recId) {

                $('#mobilePhone').val($('#phone_' + recId).text());
                $('#recId').val(recId);

                $('#editMobilePhoneModal').modal();
            }
            
            function editEmailAddress(recId) {

                $('#emailAddress').val($('#email_' + recId).text());
                $('#editEmailForm input[name=recId]').val(recId);

                $('#editEmailModal').modal();
            }
            
            function checkMobilePhone(){
                
                if($.trim($('#mobilePhone').val()) === ''){
                    
                    alert(NOT_NULL_MESSAGE);
                    $('#mobilePhone').attr("placeholder", NOT_NULL_MESSAGE);
                    $('#mobilePhone').focus();
                    
                    return false;
                }
                //
                return true;
            }
            
            function checkEmail(){
                
                if(!$('#emailAddress').isValidEmailAddress()){
                    
                    alert(EMAIL_MESSAGE);
                    $('#emailAddress').attr("placeholder", EMAIL_MESSAGE);
                    $('#emailAddress').focus();
                    return false;
                }
                //
                return true;
            }
            
            function showPageBillAdd(page){
                $.get( '<c:url value="/checkout/choose-billing-address-modal?paging.page"/>='+page, function( data ) {
                    $('#billingAddressListContent').html(data);
                    $('#billingAddressListModal').modal({show:true});
                });
            }
            
            /**
             * 
             * @param {type} recId
             * @returns {undefined}
             */
            function deleteRecever(recId){
                if(confirm('<spring:message code="message.delete_receiver"/>')){
                    document.location.href = "<c:url value="/checkout/deleteReceiver/"/>" + recId;
                }
            }
        </script>
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/billingAddress.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <section id="place-order" class="normal-page">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <h1><spring:message code="order.place_your_order"/></h1>
                        <c:if test="${empty REC_GIFTS}">
                            <div class="msg msg-error">
                                Sorry ! There is no item in your order
                            </div>
                        </c:if>
                        <c:if test="${not empty REC_GIFTS}">
                        <div class="info-bound">
                            <table class="recipient">
                                <c:forEach items="${REC_GIFTS}" var="entry" varStatus="recCount">
                                    <tr>
                                        <td><b>${recCount.count}</b></td>
                                        <td style="max-width: 250px;"><spring:message code="order.send_to"/></td>
                                        <td>${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName}</td>
                                        <td style="text-align: right;">
                                            <a href="javascript:deleteRecever(${entry.recipient.id})"><i class="fa fa-pencil"></i> Delete</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Email Address</td>
                                        <td id="email_${recipient.recipient.id}">${entry.recipient.email}</td>
                                        <td style="text-align: right;">
                                            <a title="Change this email" href="javascript:editEmailAddress(${entry.recipient.id});"><i class="fa fa-pencil"></i> Change</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Mobile Phone</td>
                                        <td id="phone_${entry.recipient.id}">${entry.recipient.phone}</td>
                                        <td style="text-align: right">
                                            <a href="javascript:editMobilePhone(${entry.recipient.id});"><i class="fa fa-pencil"></i> Change</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><b>Order Summary</b></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <c:forEach items="${entry.gifts}" var="g"  varStatus="giftCount">
                                        <c:set var="priceInUSD" value="${g.getPriceInUSD(LIXI_ORDER.lxExchangeRate.buy)}"/>
                                        <c:set var="recGiftIndex" value="${giftCount.count}"/>
                                        <tr>
                                            <td></td>
                                            <td colspan="3">
                                                <table>
                                                    <tr>
                                                        <td>${giftCount.count}</td>
                                                        <td class="col-md-1">Item</td>
                                                        <td>
                                                            ${g.category.name}
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            ${g.productName}
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            ${g.productQuantity} x <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND
                                                            &nbsp;=&nbsp;<fmt:formatNumber value="${g.productQuantity * g.productPrice}" pattern="###,###.##"/> VND
                                                            or <fmt:formatNumber   value="${priceInUSD * g.productQuantity}" pattern="###,###.##"/> USD
                                                        </td>
                                                        <td style="text-align: right"><a href="<c:url value="/gifts/more-recipient"/>"><i class="fa fa-pencil"></i> Change</a></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:forEach items="${entry.topUpMobilePhones}" var="t"  varStatus="tCount">
                                        <c:set var="recGiftIndex" value="${recGiftIndex + tCount.count}"/>
                                        <tr>
                                            <td></td>
                                            <td colspan="3">
                                                <table>
                                                    <tr>
                                                        <td>${recGiftIndex}</td>
                                                        <td class="col-md-1">Item</td>
                                                        <td>
                                                            Top Up
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <fmt:formatNumber value="${t.amount * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/> VND
                                                            or <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> USD
                                                        </td>
                                                        <td style="text-align: right"><a href="<c:url value="/gifts/more-recipient"/>"><i class="fa fa-pencil"></i> Delete</a></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:forEach items="${entry.buyPhoneCards}" var="p"  varStatus="pCount">
                                        <c:set var="recGiftIndex" value="${recGiftIndex + pCount.count}"/>
                                        <c:set var="priceInUSD" value="${p.getValueInUSD(LIXI_ORDER.lxExchangeRate.buy)}"/>
                                        <tr>
                                            <td></td>
                                            <td colspan="3">
                                                <table>
                                                    <tr>
                                                        <td>${recGiftIndex}</td>
                                                        <td class="col-md-1">Item</td>
                                                        <td>
                                                            Phone Card
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            ${p.numOfCard} x <fmt:formatNumber value="${p.valueOfCard}" pattern="###,###.##"/> VND
                                                            or <fmt:formatNumber value="${priceInUSD * p.numOfCard}" pattern="###,###.##"/> USD
                                                        </td>
                                                        <td style="text-align: right"><a href="<c:url value="/gifts/more-recipient"/>"><i class="fa fa-pencil"></i> Delete</a></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                                <tr>
                                    <td></td>
                                    <td><b>Gift Price:</b></td>
                                    <td><b>$<fmt:formatNumber value="${LIXI_ALL_TOTAL[0].usd}" pattern="###,###.##"/></b></td>
                                    <td></td>
                                </tr>
                                <c:if test="${not empty CARD_PROCESSING_FEE_THIRD_PARTY}">
                                <tr>
                                    <td></td>
                                    <td>
                                        <b>
                                        <c:if test="${not empty LIXI_ORDER.card}">Card Processing Fee:</c:if>
                                        <c:if test="${not empty LIXI_ORDER.bankAccount}">eCheck Processing Fee:</c:if>
                                        </b>
                                    </td>
                                    <td>
                                        <b>$<span id="CARD_PROCESSING_FEE_THIRD_PARTY"><fmt:formatNumber value="${CARD_PROCESSING_FEE_THIRD_PARTY}" pattern="###,###.##"/></span></b>
                                    </td>
                                    <td></td>
                                </tr>
                                </c:if>
                                <tr>
                                    <td></td>
                                    <td><b>Lixi Handling Fee:</b></td>
                                    <td><b>$<span id="LIXI_HANDLING_FEE_TOTAL">${LIXI_HANDLING_FEE_TOTAL}</span></b> ($${LIXI_HANDLING_FEE.fee} per person)<br/>
                                    
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><b>TOTAL:</b></td>
                                    <td><b>$<span id="LIXI_FINAL_TOTAL"><fmt:formatNumber value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/></span></b></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Payment Method</td>
                                    
                                    <td>
                                    <c:if test="${not empty LIXI_ORDER.card}">
                                    <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.card.cardNumber)}"/>
                                    <b>${LIXI_ORDER.card.cardTypeName}</b> ending with ${fn:substring(LIXI_ORDER.card.cardNumber, lengthCard-4, lengthCard)}
                                    <br/>
                                    <b>Billing address:</b> <span id="billingAdd">${LIXI_ORDER.card.billingAddress.fullName}, ${LIXI_ORDER.card.billingAddress.add1}
                                    <c:if test="${not empty LIXI_ORDER.card.billingAddress.add2}">&nbsp; ${LIXI_ORDER.card.billingAddress.add2}}</c:if>
                                    , ...</span>&nbsp;
                                    </c:if>
                                    <c:if test="${not empty LIXI_ORDER.bankAccount}">
                                        <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.bankAccount.checkingAccount)}"/>
                                        <b>${LIXI_ORDER.bankAccount.name}</b> ending in ${fn:substring(LIXI_ORDER.bankAccount.checkingAccount, lengthCard-4, lengthCard)}
                                        <br/>
                                        <b>Billing address:</b> <span id="billingAdd">${LIXI_ORDER.bankAccount.billingAddress.fullName}, ${LIXI_ORDER.bankAccount.billingAddress.add1}
                                    </c:if>
                                    <a href="javascript:showPageBillAdd(1);" style="font-weight:normal;">&nbsp;Change</a>
                                    </td>
                                    <c:url value="/checkout/place-order" var="returnUrl"/>
                                    <td style="text-align: right;vertical-align: top;"><a href="<c:url value="/checkout/payment-method/change?returnUrl=${returnUrl}"/>"><i class="fa fa-pencil"></i> Change</a></td>
                                </tr>
                            </table>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/checkout/place-order" method="post">
                        <div class="info-bound" style="padding-top:0px; padding-bottom: 0px;">
                            <table class="table" style="margin-bottom: 0px;">
                                <tr>
                                    <td style="border-top:none;width: 5%;">
                                        <div class="checkbox">
                                            <input type="radio" name="setting" value="0" <c:if test="${LIXI_ORDER.setting eq 0}">checked=""</c:if>/>
                                        </div>
                                    </td>
                                    <td style="border-top:none;width: 60%;">
                                        <div class="checkbox">
                                        Gift only<br/>Do not allow refund to receiver
                                        </div>
                                    </td>
                                    <td style="border-top:none;width: 5%;">
                                        <div class="checkbox">
                                            <input type="radio" name="setting" value="1"  <c:if test="${LIXI_ORDER.setting eq 1}">checked=""</c:if>/>
                                        </div>
                                    </td>
                                    <td style="border-top:none;">
                                        <div class="checkbox">
                                        <label>Allow refund to receiver<br/>If so choosen
                                        </label>
                                    </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="border-top:none;padding: 0px; text-align: center;">
                                        <span class="help-block">(The option you choose will be applied to everyone on the order)</span>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="btns">
                            <a href="<c:url value="/checkout/payment-method/change"/>" class="btn btn-primary left"><spring:message code="message.back"/></a>
                            <c:if test="${not empty REC_GIFTS}"><button type="submit" class="btn btn-primary">Place Order</button></c:if>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                        </c:if>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>
        <!-- Modal Edit Mobile Phone -->
        <div class="modal fade" id="editMobilePhoneModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Edit Mobile Phone</h4>
                    </div>
                    <form role="form" method="post" action="${pageContext.request.contextPath}/checkout/edit-rec-phone">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <input id="mobilePhone" name="mobilePhone" type="text" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="recId" id="recId"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button id="btnSubmitEditPhone" onclick="return checkMobilePhone();" type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal Edit Email -->
        <div class="modal fade" id="editEmailModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Edit Email Address</h4>
                    </div>
                    <form id="editEmailForm" role="form" method="post" action="${pageContext.request.contextPath}/checkout/edit-email">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <input id="emailAddress" name="emailAddress" type="email" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="recId"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button onclick="return checkEmail();" type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Billing Address Modal -->
        <div class="modal fade" id="billingAddressListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="billingAddressListContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Client>