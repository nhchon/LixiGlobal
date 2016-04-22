<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            jQuery(document).ready(function () {

                $('#timeCombo').change(function () {

                    document.location.href = '<c:url value="/user/orderHistory"/>' + '/' + this.value;

                });
            });
            
            function toogleTrans(){
                if($('#transInfo').is(":visible")){
                    
                    $('#iconTrans').removeClass();
                    $('#iconTrans').addClass("fa fa-caret-right");
                    //
                    $('#transInfo').hide();
                }
                else{
                    $('#iconTrans').removeClass();
                    $('#iconTrans').addClass("fa fa-caret-down");
                    //
                    $('#transInfo').show();
                }
            }
            
            function callPrint(){
                //alert('hello');
                window.focus();
                window.print();
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title"><spring:message code="mess.order-detail"/></h2>
                    <div class="row" style="font-size: 16px;margin-bottom: 10px;">
                        <div class="col-md-3" style="">
                            <spring:message code="mess.ordered-on"/> <fmt:formatDate pattern="MMMM dd yyyy" value="${LIXI_ORDER.modifiedDate}"/>
                        </div>
                        <div class="col-md-3" style="">
                            <spring:message code="mess.order"/> # <c:if test="${not empty LIXI_ORDER.invoice}">${LIXI_ORDER.invoice.invoiceCode}</c:if>
                            <c:if test="${empty LIXI_ORDER.invoice}">${LIXI_ORDER.id}</c:if>
                        </div>
                        <div class="col-md-6" style="text-align: right;">
                            <button class="btn btn-default" onclick="callPrint()"><spring:message code="mess.view-print-inv"/></button>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div style="font-size: 16px;font-weight: bold;"><spring:message code="mess.rec-s"/>:</div>
                                    <c:forEach items="${REC_GIFTS}" var="rio" varStatus="theValueCount">
                                        <div style="margin-bottom: 10px;margin-top: 10px;">${theValueCount.count}. ${rio.recipient.firstName}&nbsp;${rio.recipient.middleName}&nbsp;${rio.recipient.lastName}</div>
                                        <div><spring:message code="message.email"/>: ${rio.recipient.email}</div>
                                        <div><spring:message code="message.phone"/>: ${rio.recipient.phone}</div>
                                    </c:forEach>
                                </div>
                                <div class="col-md-5">
                                    <div style="font-size: 16px;font-weight: bold;"><spring:message code="mess.payment-method"/></div>
                                    <div style="margin-bottom: 10px;margin-top: 10px;">
                                        <c:if test="${not empty LIXI_ORDER.card}">
                                            <c:set var="lengthCard" value="${fn:length(LIXI_ORDER.card.cardNumber)}"/>
                                        </c:if>
                                        <c:choose>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 1}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-visa.png"/>"/>
                                            </c:when>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 2}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-master.png"/>"/>
                                            </c:when>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 3}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-discover.png"/>"/>
                                            </c:when>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 4}">
                                                <img width="47" height="29" src="<c:url value="/resource/theme/assets/lixi-global/images/card-amex.jpg"/>"/>
                                            </c:when>
                                        </c:choose>                                                    
                                        <span><sup>***</sup>${fn:substring(LIXI_ORDER.card.cardNumber, lengthCard-4, lengthCard)}</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div style="font-size: 16px;font-weight: bold;"><spring:message code="mess.order-summary"/></div>
                                    <div style="margin-top: 10px;">
                                        <table style="width: 100%">
                                            <tr>
                                                <td><spring:message code="mess.gift-price"/></td>
                                                <td style="text-align: right;">
                                                    USD <fmt:formatNumber value="${LIXI_GIFT_PRICE}" pattern="###,###.##"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><spring:message code="mess.card-process-fee"/></td>
                                                <td style="text-align: right;"><fmt:formatNumber value="${CARD_PROCESSING_FEE_THIRD_PARTY}" pattern="###,###.##"/></td>
                                            </tr>
                                            <tr>
                                                <td><spring:message code="mess.lixi-handle-fee"/></td>
                                                <td style="text-align: right;"><fmt:formatNumber value="${LIXI_HANDLING_FEE_TOTAL}" pattern="###,###.##"/></td>
                                            </tr>
                                            <tr>
                                                <td style="padding-top: 10px;"><spring:message code="mess.total-before-tax"/></td>
                                                <td style="padding-top: 10px;text-align: right;"><fmt:formatNumber value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/></td>
                                            </tr>
                                            <tr>
                                                <td><spring:message code="mess.sale-tax"/></td>
                                                <td style="text-align: right;">0.0</td>
                                            </tr>
                                            <tr>
                                                <td style="padding-top: 10px;"><b><spring:message code="mess.grand-tax"/></b></td>
                                                <td style="padding-top: 10px;text-align: right;">USD <fmt:formatNumber value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>    
                            </div>
                        </div>
                        <div class="panel-footer" style="background-color: #fff;">
                            <i id="iconTrans" class="fa fa-caret-right"></i> <a href="javascript:toogleTrans();"><spring:message code="mess.transactions"/></a>
                            <div class="row" id="transInfo" style="display: none;">
                                <div class="col-md-12">
                                    <c:if test="${not empty LIXI_ORDER.card}">
                                        <c:choose>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 1}">
                                                Visa Card
                                            </c:when>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 2}">
                                                Master Card
                                            </c:when>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 3}">
                                                Discover Card
                                            </c:when>
                                            <c:when test="${LIXI_ORDER.card.cardType eq 4}">
                                                American Express
                                            </c:when>
                                        </c:choose>
                                         ending in ${fn:substring(LIXI_ORDER.card.cardNumber, lengthCard-4, lengthCard)} : $<fmt:formatNumber value="${LIXI_FINAL_TOTAL}" pattern="###,###.##"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>                        
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <c:forEach items="${REC_GIFTS}" var="rio" varStatus="theValueCount">
                                <ul class="nav nav-pills" role="tablist">
                                    <li role="presentation" class="active"><a href="#">${rio.recipient.firstName}&nbsp;${rio.recipient.middleName}&nbsp;${rio.recipient.lastName} <span class="badge">${fn:length(rio.gifts) + fn:length(rio.topUpMobilePhones)}</span></a></li>
                                </ul>
                                <div>&nbsp;</div>
                                <c:forEach items="${rio.gifts}" var="g">
                                    <div class="row" style="margin-bottom: 5px;">
                                        <div class="col-md-2" style="padding-left:50px;">
                                            <img width="122" height="107" src="<c:url value="${g.productImage}"/>"/>
                                        </div>
                                        <div class="col-md-1" style="padding-top:40px;text-align: center;">
                                            ${g.productQuantity}
                                        </div>
                                        <div class="col-md-6" style="padding-top:40px;">
                                            ${g.productName}
                                        </div>
                                        <div class="col-md-3" style="padding-top:40px;text-align: right;">
                                            USD <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/> - VND <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:forEach items="${rio.topUpMobilePhones}" var="t">
                                    <div class="row" style="margin-bottom: 5px;margin-top: 20px;">
                                        <div class="col-md-2" style="padding-left:50px;">
                                            <spring:message code="mess.top-up"/>
                                        </div>
                                        <div class="col-md-1" style="text-align: center;">1</div>
                                        <div class="col-md-6">
                                            <spring:message code="mess.top-up-for"/> ${t.phone}
                                        </div>
                                        <div class="col-md-3" style="text-align: right;">
                                            USD <fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/> - VND <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <c:if test="${theValueCount.count < fn:length(REC_GIFTS)}">
                                    <div class="row">
                                        <div class="col-md-12"><hr style="height:1px;border:none;color:#333;background-color:#333;"/></div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>