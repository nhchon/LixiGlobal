<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var NOT_NULL_MESSAGE = '<spring:message code="validate.not_null"/>';
            
            function editMobilePhone(recId) {

                $('#phone').val($('#phone_' + recId).text());
                $('#recId').val(recId);

                $('#editMobilePhoneModal').modal();
            }
            
            function showPageBillAdd(page){
                $.get( '<c:url value="/checkout/choose-billing-address?paging.page"/>='+page, function( data ) {
                    $('#billingAddressListContent').html(data);
                    $('#billingAddressListModal').modal({show:true});
                });
            }
            
            /**
             * 
             * @param {type} baId
             * @returns {undefined}
             */
            function useThisAddress(baId){
                
                $('#billingAdd').html($('#billingAdd-'+baId).val());
                
                $('#billingAddressListModal').modal('toggle');
            }
            
            function newBillingAddress(){
                $.get( '<c:url value="/checkout/billing-address-modal"/>', function( data ) {
                    $('#billingAddressListContent').html(data);
                    $('#billingAddressListModal').modal({show:true});
                });
            }
            
            function saveNewBillingAddress(){
                
                if($.trim($('#fullName').val()) === ''){
                    
                    $('#fullName').attr("placeholder", NOT_NULL_MESSAGE);
                    $('#fullName').focus();
                    return false;
                }
                // add1
                if($.trim($('#add1').val()) === ''){
                    
                    $('#add1').attr("placeholder", NOT_NULL_MESSAGE);
                    $('#add1').focus();
                    return false;
                }
                // city
                if($.trim($('#city').val()) === ''){
                    
                    $('#city').attr("placeholder", NOT_NULL_MESSAGE);
                    $('#city').focus();
                    return false;
                }
                // state
                if($.trim($('#state').val()) === ''){
                    
                    $('#state').attr("placeholder", NOT_NULL_MESSAGE);
                    $('#state').focus();
                    return false;
                }
                // zipCode
                if($.trim($('#zipCode').val()) === ''){
                    
                    $('#zipCode').attr("placeholder", NOT_NULL_MESSAGE);
                    $('#zipCode').focus();
                    return false;
                }
                // phone
                if($.trim($('#phone').val()) === ''){

                    $('#phone').attr("placeholder", NOT_NULL_MESSAGE);
                    $('#phone').focus();
                    return false;
                }
                //
                return true;
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <form>
        <section id="place-order" class="normal-page">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <h1><spring:message code="order.place_your_order"/></h1>
                        <div class="info-bound">
                            <table class="recipient">
                                <c:set var="allRecipientTotal" value="0"/>
                                <c:forEach items="${REC_GIFTS}" var="entry" varStatus="recCount">
                                    <tr>
                                        <td><b>${recCount.count}</b></td>
                                        <td style="max-width: 250px;"><spring:message code="order.send_to"/></td>
                                        <td>${entry.key.firstName}&nbsp;${entry.key.middleName}&nbsp;${entry.key.lastName}</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Email Address</td>
                                        <td>${entry.key.email}</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Mobile Phone</td>
                                        <td id="phone_${entry.key.id}">${entry.key.phone}</td>
                                        <td style="text-align: right">
                                            <a href="javascript:editMobilePhone(${entry.key.id});"><i class="fa fa-pencil"></i> Change</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><b>Order Summary</b></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <c:set var="recipientTotal" value="0"/>
                                    <c:forEach items="${entry.value}" var="g"  varStatus="giftCount">
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
                                                        </td>
                                                        <td style="text-align: right"><a href="javascript:alert('In Dev');"><i class="fa fa-pencil"></i> Change</a></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <c:set var="recipientTotal" value="${recipientTotal + g.productPrice * g.productQuantity}"/>
                                        <c:set var="allRecipientTotal" value="${allRecipientTotal + g.productPrice * g.productQuantity}"/>
                                    </c:forEach>
                                </c:forEach>
                                <tr>
                                    <td></td>
                                    <td><b>TOTAL</b></td>
                                    <td>(in USD) <b>$<fmt:formatNumber value="${allRecipientTotal / LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/></b></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>Payment Method</td>
                                    <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.card.cardNumber)}"/>
                                    <td><b>${LIXI_ORDER.card.cardTypeName}</b> ending with ${fn:substring(LIXI_ORDER.card.cardNumber, lengthCard-4, lengthCard)}
                                    <br/>
                                    <b>Billing address:</b> <span id="billingAdd">${LIXI_ORDER.billingAddress.fullName}, ${LIXI_ORDER.billingAddress.add1}
                                    <c:if test="${not empty LIXI_ORDER.billingAddress.add2}">&nbsp; ${LIXI_ORDER.billingAddress.add2}}</c:if>
                                    , ...</span> <a href="javascript:showPageBillAdd(1);" style="font-weight:normal;">Change</a>
                                    </td>
                                    <td style="text-align: right;vertical-align: top;"><a href="<c:url value="/checkout/cards/change"/>"><i class="fa fa-pencil"></i> Change</a></td>
                                </tr>
                            </table>
                        </div>
                        <div class="btns">
                            <a href="review-cart.html" class="btn btn-primary left"><spring:message code="message.back"/></a>
                            <a href="thanks.html" class="btn btn-primary">Place Order</a>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>
        </form>
        <!-- Modal -->
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
                            <button type="submit" class="btn btn-primary">Save changes</button>
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