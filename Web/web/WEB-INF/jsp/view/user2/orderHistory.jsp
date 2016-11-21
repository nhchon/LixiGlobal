<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var CANCEL_ORDER_MESSAGE = '<spring:message code="message.cancel_order" text="Are you sure want to cancel this order ?"/>';
            jQuery(document).ready(function () {

                $('#timeCombo').change(function () {

                    document.location.href = '<c:url value="/user/orderHistory"/>' + '/' + this.value;

                });
            });

            function cancelOrder(id) {
                if (confirm(CANCEL_ORDER_MESSAGE)) {
                    document.location.href = '<c:url value="/user/cancelOrder"/>' + '/' + id;
                }
            }
            
            function toogleDetail(id){
                if($('#panelBody'+id).is(":visible")){
                    
                    $('#iconDetail'+id).removeClass();
                    $('#iconDetail'+id).addClass("fa fa-caret-down");
                    //
                    $('#panelBody'+id).hide();
                }
                else{
                    $('#iconDetail'+id).removeClass();
                    $('#iconDetail'+id).addClass("fa fa-caret-up");
                    //
                    $('#panelBody'+id).show();
                }
            }
            
            function showTopUpAlreadySentModal(){
                $('#topUpSentModal').modal('show');
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title"><spring:message code="mess.order-history"/></h2>
                    <h4 class="title">
                        <c:if test="${not empty orders.content}">${fn:length(orders.content)}&nbsp;<spring:message code="mess.order-place-in"/></c:if>
                        <c:if test="${empty orders.content}"><spring:message code="mess.no-order-place-in"/></c:if>
                        </h4>
                        <div class="form-group">
                            <select id="timeCombo" class="selectpicker">
                                <option value="lastWeek" <c:if test="${when eq 'lastWeek'}">selected=""</c:if>>Last week</option>
                            <option value="last30Days" <c:if test="${when eq 'last30Days'}">selected=""</c:if>>Last 30 days</option>
                            <option value="last6Months" <c:if test="${when eq 'last6Months'}">selected=""</c:if>>Last 6 months</option>
                            <option value="allOrders" <c:if test="${when eq 'allOrders'}">selected=""</c:if>>All</option>
                            </select>
                        </div>
                    <c:if test="${param.voidRs eq 3}">
                        <div class="alert alert-danger" role="alert"><spring:message code="err.unvoid-order"/></div>
                    </c:if>
                    <c:if test="${param.voidRs eq 1}">
                        <div class="alert alert-success" role="alert"><spring:message code="err.void-order"/></div>
                    </c:if>
                    <c:if test="${param.voidRs eq 0}">
                        <div class="alert alert-danger" role="alert"><spring:message code="mess.order-processed"/>. <spring:message code="mess.no-longer-cancelled"/>.</div>
                    </c:if>
                    <c:forEach items="${mOs}" var="m">
                        <%--<c:if test="${m.key.invoice.netTransStatus ne 'beforePayment' && m.key.invoice.netTransStatus ne 'paymentError' && m.key.invoice.netTransStatus ne 'voidedByUser'}">--%>
                        <c:if test="${not empty m.key.invoice}">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div style="font-size:15px;">
                                                <b><spring:message code="mess.order-number"/>:</b> ${m.key.invoice.invoiceCode}
                                            </div>
                                            <div style="font-size:14px;padding-top: 8px;">
                                                <a href="<c:url value="/user/orderDetail/${m.key.id}"/>"><spring:message code="mess.order-detail"/></a>
                                                <c:if test="${m.key.invoice.translatedStatus eq 'In Progress'}">
                                                    <%-- empty gift means just topup --%>
                                                    <c:if test="${not empty m.key.gifts}">
                                                        <c:if test="${not empty m.key.topUpMobilePhones}">
                                                        | <a href="javascript:showTopUpAlreadySentModal();"><spring:message code="mess.cancel-order"/></a>
                                                        </c:if>
                                                        <c:if test="${empty m.key.topUpMobilePhones}">
                                                        | <a href="javascript:cancelOrder(${m.key.id});"><spring:message code="mess.cancel-order"/></a>
                                                        </c:if>
                                                    </c:if>
                                                </c:if>
                                                <c:if test="${m.key.invoice.translatedStatus eq 'Complete'}">
                                                    | <a href="javascript:void(0);" ><spring:message code="mess.order-again"/></a>
                                                </c:if>    
                                            </div>
                                        </div>
                                        <div class="col-md-2" style="text-align:center;">
                                            <div style="font-size:15px;"><spring:message code="mess.order-date"/></div>
                                            <div style="font-size:14px;padding-top: 8px;">
                                                <c:choose>
                                                    <c:when test="${not empty m.key.invoice.invoiceDate}">
                                                        <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.invoice.invoiceDate}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="col-md-2" style="text-align:center;">
                                            <div style="font-size:15px;"><spring:message code="mess.status"/></div>
                                            <div style="font-size:14px;padding-top: 8px;">
                                                ${m.key.invoice.translatedStatus}
                                                <c:set var="lastCheck" value="Last check: "/>
                                                <c:if test="${m.key.invoice.netTransStatus eq 'settledSuccessfully'}">
                                                    <c:set var="lastCheck" value=""/>
                                                </c:if>
                                                <c:if test="${empty m.key.invoice}">
                                                    &nbsp;(${lastCheck}<fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.modifiedDate}"/>)
                                                </c:if>
                                                <c:if test="${not empty m.key.invoice}">
                                                    <c:if test="${empty m.key.invoice.netTransStatus}">
                                                        &nbsp;(${lastCheck}<fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.invoice.invoiceDate}"/>)
                                                    </c:if>
                                                    <c:if test="${not empty m.key.invoice.netTransStatus}">
                                                        &nbsp;(${lastCheck}<fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.invoice.lastCheckDate}"/>)
                                                    </c:if>             
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-md-1" style="text-align:center;">
                                            <div style="font-size:15px;text-transform: uppercase;"><spring:message code="mess.o-d"/></div>
                                            <div style="font-size:14px;padding-top: 8px;">
                                                <c:choose>
                                                    <c:when test="${m.key.lixiStatus eq PROCESSING}">
                                                        <spring:message code="o-processing" text="Processing"/><br/>
                                                        <c:if test="${order.lixiSubStatus eq SENT_MONEY}">(Sent Money)</c:if>
                                                        <c:if test="${order.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                                    </c:when>
                                                    <c:when test="${m.key.lixiStatus eq COMPLETED}">
                                                        <spring:message code="o-completed" text="Completed"/>
                                                    </c:when>
                                                    <c:when test="${m.key.lixiStatus eq CANCELED}">
                                                        <spring:message code="o-cancelled" text="Cancelled"/>
                                                    </c:when>
                                                    <c:when test="${m.key.lixiStatus eq PURCHASED}">
                                                        <spring:message code="o-purchased" text="Purchased"/>
                                                    </c:when>
                                                    <c:when test="${m.key.lixiStatus eq DELIVERED}">
                                                        <spring:message code="o-delivered" text="Delivered"/>
                                                    </c:when>
                                                    <c:when test="${m.key.lixiStatus eq UNDELIVERABLE}">
                                                        <spring:message code="o-undelivered" text="Undeliverable"/>
                                                    </c:when>
                                                    <c:when test="${m.key.lixiStatus eq REFUNDED}">
                                                        <spring:message code="o-refuned" text="Refunded"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${m.key.lixiStatus}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="col-md-2" style="text-align:center;">
                                            <div style="font-size:15px;text-transform: uppercase;"><spring:message code="total" text="Total"/></div>
                                            <div style="font-size:14px;padding-top: 8px;">
                                                <c:if test="${empty m.key.invoice}">
                                                    --
                                                </c:if>
                                                <c:if test="${not empty m.key.invoice}">    
                                                    USD <fmt:formatNumber minFractionDigits="2" value="${m.key.invoice.totalAmount}" pattern="###,###.##"/> - 
                                                    <fmt:formatNumber value="${m.key.invoice.totalAmountVnd}" pattern="###,###.##"/> VND
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="col-md-2" style="text-align: center;">
                                            <div style="font-size:15px;text-transform: uppercase;"><spring:message code="setting" text="Setting"/> <span class="pull-right"><a href="javascript:toogleDetail(${m.key.id})"><i id="iconDetail${m.key.id}" class="fa fa-caret-down"></i></a></span></div>
                                            <div style="font-size:14px;padding-top: 8px;">
                                                <c:if test="${m.key.setting eq 0}">
                                                    <spring:message code="gift.gift_only" text="Gift Only"/>
                                                </c:if>
                                                <c:if test="${m.key.setting eq 1}">
                                                    <spring:message code="gift.allow_refund" text="Allow Refund"/>
                                                </c:if>
                                            </div>    
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body"  style="display:none;"  id="panelBody${m.key.id}">
                                    <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                        <b>${rio.recipient.firstName}&nbsp;${rio.recipient.middleName}&nbsp;${rio.recipient.lastName}</b> <span class="badge">${fn:length(rio.gifts) + fn:length(rio.topUpMobilePhones)}</span>
                                        <div>&nbsp;</div>
                                        <c:forEach items="${rio.gifts}" var="g">
                                            <div class="row" style="margin-bottom: 5px;">
                                                <div class="col-md-3" style="padding-left:50px;">
                                                    <img width="122" height="107" src="<c:url value="${g.productImage}"/>"/>
                                                </div>
                                                <div class="col-md-2" style="padding-top:40px;text-align: center;">
                                                    ${g.productQuantity}
                                                </div>
                                                <div class="col-md-4" style="padding-top:40px;">
                                                    ${g.productName}
                                                </div>
                                                <div class="col-md-3" style="padding-top:40px;text-align: center;">
                                                    USD <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> - VND <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:forEach items="${rio.topUpMobilePhones}" var="t">
                                            <div class="row" style="margin-bottom: 5px;">
                                                <div class="col-md-3" style="padding-left:50px;">
                                                    <spring:message code="mess.top-up"/>
                                                </div>
                                                <div class="col-md-2" style="text-align: center;">
                                                    1
                                                </div>
                                                <div class="col-md-4">
                                                    ${t.phone}
                                                </div>
                                                <div class="col-md-3" style="text-align: center;">
                                                    USD <fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/> - VND <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${theValueCount.count < fn:length(m.value)}">
                                            <div class="row">
                                                <div class="col-md-12"><hr style="height:1px;border:none;color:#333;background-color:#333;"/></div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    <div class="row">
                        <div class="col-md-12" style="text-align: right;">
                            <%-- Paging --%>
                            <nav>
                                <ul class="pagination pull-right">
                                    <c:forEach begin="1" end="${orders.totalPages}" var="i">
                                        <c:choose>
                                            <c:when test="${(i - 1) == orders.number}">
                                                <li class="active">
                                                    <a href="javascript:void(0)">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li>
                                                    <a href="<c:url value="/user/orderHistory/${when}">
                                                           <c:param name="paging.page" value="${i}" />
                                                           <c:param name="paging.size" value="50" />
                                                       </c:url>">${i}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </ul>
                            </nav>                                
                        </div>
                    </div>
                </div>
            </div>
            <div id="topUpSentModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><spring:message code="message.alert"/></h4>
                        </div>
                        <div class="modal-body">
                            <p><spring:message code="topup-already-sent-1"/></p>
                            (<spring:message code="topup-already-sent-2"/>)
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="message.ok"/></button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>