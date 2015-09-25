<template:Client htmlTitle="LiXi Global - Add Additional Recipient?">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var CONFIRM_MESSAGE = "<spring:message code="gift.delete_confirm"/>";
            var oldText = [];
            var newText;
            
            $(document).ready(function () {
                
            });
            
            function changeHtml(id){
                
                oldText[id] = $('#quantity-text-'+id).text();
                //alert(oldText[id]);
                $('#quantity-text-'+id).html(generateQuantityHtmlBox(oldText[id], id));
                // hide
                $('#changeDeleteLine-'+id).hide();
                // show
                $('#saveDiscardLine-'+id).show();
            }
            
            function discard(id){
                
                $('#quantity-text-'+id).html(oldText[id]);
                // show
                $('#changeDeleteLine-'+id).show();
                // hide
                $('#saveDiscardLine-'+id).hide();
            }
            
            function generateQuantityHtmlBox(q, id){
                var html = "<select class='form-control' id='quantity-"+id+"'>";
                for(i=1;i<=5;i++){
                    html += "<option value="+i + (i==q?" selected":"")+">"+i+"</option>";
                }
                html += "</select>";
                return html;
            }
            
            function confirmDeleteItem(id) {

                if (confirm(CONFIRM_MESSAGE)) {
                    document.location.href = "<c:url value="/gifts/delete?gift="/>" + id;
                }

            }
            
            /**
             * 
             * @param {type} id
             * @returns {undefined}             
             * */
            function updateQUantity(id){
                
                document.location.href = "<c:url value="/gifts/update"/>" + "/" + id + "/" + $('#quantity-'+id).val();
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="email-already-in-use" class="normal-page">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <h1>Summary</h1>
                        <c:if test="${wrong eq 1 || param.wrong eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.there_is_something_wrong"/>
                            </div>
                        </c:if>
                        
                        <c:if test="${exceed eq 1 || param.exceed eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.exceeded">
                                    <spring:argument value="${EXCEEDED_VND}"/>
                                    <spring:argument value="${EXCEEDED_USD}"/>
                                </spring:message>
                            </div>
                        </c:if>
                        <c:if test="${empty REC_GIFTS}">
                            <div class="msg msg-error">
                                Sorry ! There is no item in your order
                            </div>
                        </c:if>
                        <br/>
                        <c:if test="${not empty REC_GIFTS}">
                        <div class="row">
                            <div class="col-lg-2 col-md-2">
                                <spring:message code="message.exchange_rate"/>:
                            </div>
                            <div class="col-lg-10 col-md-10">
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                    <input type="text" class="form-control" id="rate-from" value="1 ${LIXI_ORDER.lxExchangeRate.currency.code}" readonly=""/>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2" style="text-align: center;">
                                    <img alt="" src="<c:url value="/resource/theme/assets/lixiglobal/img/currency.exchange.jpg"/>" />
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5">
                                    <input type="text" class="form-control" name="exchangeRate" id="exchangeRate" value="${LIXI_ORDER.lxExchangeRate.buy} VND" readonly=""/>
                                </div>

                            </div>
                        </div>
                                <br/>
                        <div class="row">
                            <div class="col-lg-12">
                                <table class="table">
                                    <thead>
                                    <th>Name</th>
                                    <th>Gift</th>
                                    <th>Quantity</th>
                                    <th style="text-align: right;">Price</th>
                                    <th style="text-align: right;">Total</th>
                                    <th></th>
                                    </thead>
                                    <tbody>
                                        <c:set var="total" value="0"/>
                                        <c:set var="totalInUSD" value="0"/>
                                        <c:forEach items="${REC_GIFTS}" var="entry">
                                            <tr style="background-color: #f9f9f9;">
                                                <td class="col-md-5" colspan="2">
                                                    <strong>${entry.recipient.firstName}&nbsp;${entry.recipient.middleName}&nbsp;${entry.recipient.lastName}</strong>
                                                    <a href="<c:url value="/gifts/add-more/${entry.recipient.id}"/>" class="btn btn-sm btn-danger">Delete</a>
                                                    <a href="<c:url value="/gifts/add-more/${entry.recipient.id}"/>" class="btn btn-sm btn-success">Buy More</a>
                                                </td>
                                                <td class="col-md-2"></td>
                                                <td class="col-md-1"></td>
                                                <td class="col-md-2" style="text-align: right;"></td>
                                                <td class="col-md-2" style="text-align: right;"></td>
                                                <%--<td class="col-md-3" style="text-align: right;"></td>--%>
                                            </tr>
                                            <c:forEach items="${entry.gifts}" var="g">
                                                <c:if test="${g.productId > 0}">
                                                <tr>
                                                    <td class="col-md-2"></td>
                                                    <td class="col-md-2">${g.productName}</td>
                                                    <td class="col-md-2">
                                                        <span class="editableCss" style="font-weight: bold;" id="quantity-text-${g.id}">${g.productQuantity}</span><br/>
                                                        <span id="changeDeleteLine-${g.id}"><a href="javascript:changeHtml(${g.id});" style="font-weight: normal;">Change</a>  - <a href="javascript:confirmDeleteItem(${g.id});" style="font-weight:normal;">Delete</a></span>
                                                        <span id="saveDiscardLine-${g.id}" style="display: none;"><a href="javascript:updateQUantity(${g.id});" style="font-weight: normal;">Update</a>  - <a href="javascript:discard(${g.id})" style="font-weight:normal;">Delete</a></span>
                                                    </td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <c:set var="priceInUSD" value="${g.getPriceInUSD(LIXI_ORDER.lxExchangeRate.buy)}"/>
                                                        <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND<br/>
                                                        <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> USD
                                                    </td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <fmt:formatNumber value="${g.productPrice * g.productQuantity}" pattern="###,###.##"/> VND<br/>
                                                        <fmt:formatNumber value="${g.productQuantity * priceInUSD}" pattern="###,###.##"/> USD
                                                    </td>
                                                    <c:set var="total" value="${total + g.productPrice * g.productQuantity}"/>
                                                    <c:set var="totalInUSD" value="${totalInUSD + (priceInUSD * g.productQuantity)}"/>
                                                </tr>
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach items="${entry.topUpMobilePhones}" var="t">
                                                <tr>
                                                    <td class="col-md-2"></td>
                                                    <td class="col-md-2">Top Up</td>
                                                    <td class="col-md-2">
                                                        <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/>
                                                    </td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <fmt:formatNumber value="${t.amount * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/> VND<br/>
                                                        <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> USD
                                                    </td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <fmt:formatNumber value="${t.amount * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/> VND<br/>
                                                        <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> USD
                                                    </td>
                                                    <c:set var="total" value="${total + (t.amount * LIXI_ORDER.lxExchangeRate.buy)}"/>
                                                    <c:set var="totalInUSD" value="${totalInUSD + t.amount}"/>
                                                </tr>
                                            </c:forEach>    
                                            <c:forEach items="${entry.buyPhoneCards}" var="p">
                                                <tr>
                                                    <td class="col-md-2"></td>
                                                    <td class="col-md-2">Phone Card</td>
                                                    <td class="col-md-2">
                                                        <fmt:formatNumber value="${p.numOfCard}" pattern="###,###.##"/>
                                                    </td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <c:set var="valueInUSD" value="${p.getValueInUSD(LIXI_ORDER.lxExchangeRate.buy)}"/>
                                                        <fmt:formatNumber value="${p.valueOfCard}" pattern="###,###.##"/> VND<br/>
                                                        <fmt:formatNumber value="${valueInUSD}" pattern="###,###.##"/> USD
                                                    </td>
                                                    <td class="col-md-3" style="text-align: right;">
                                                        <fmt:formatNumber value="${p.numOfCard * p.valueOfCard}" pattern="###,###.##"/> VND<br/>
                                                        <fmt:formatNumber value="${(valueInUSD * p.numOfCard)}" pattern="###,###.##"/> USD
                                                    </td>
                                                    <c:set var="total" value="${total + (p.numOfCard * p.valueOfCard)}"/>
                                                    <c:set var="totalInUSD" value="${totalInUSD + (valueInUSD * p.numOfCard)}"/>
                                                </tr>
                                            </c:forEach>    
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="4">
                                                <div class="row">
                                                    <div class="col-lg-6">Your maximum payment amount:</div>
                                                    <div class="col-lg-3" style="padding-left: 0px;text-align: right;">
                                                        <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount * LIXI_ORDER.lxExchangeRate.buy}" pattern="###,###.##"/>&nbsp;VND</strong>
                                                        <br/>
                                                        <strong><fmt:formatNumber value="${USER_MAXIMUM_PAYMENT.amount}" pattern="###,###.##"/>&nbsp;${USER_MAXIMUM_PAYMENT.code}</strong>
                                                    </div>
                                                </div>
                                            </td>
                                            <td style="text-align: right;">
                                                <strong><fmt:formatNumber value="${total}" pattern="###,###.##"/></strong> VND<br/>
                                                <strong><fmt:formatNumber value="${totalInUSD}" pattern="###,###.##"/></strong> USD
                                                </td>
                                            <td></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        </c:if>                    
                        <h1>Add Additional Recipient?</h1>
                        <br />
                        <p>Do you want to send a gift to another person?</p>
                        <div class="btns">
                            <a href="<c:url value="/gifts/recipient"/>" class="btn btn-primary">Yes, I do</a>
                            <c:if test="${not empty REC_GIFTS}"><a href="<c:url value="/checkout/payment-method/change"/>" class="btn btn-primary">No, thank you</a></c:if>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>