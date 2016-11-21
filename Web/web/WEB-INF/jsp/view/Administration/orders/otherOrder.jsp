<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function updateOrderStatus(oId, recId) {

                var status = $('#recOrderStatus' + recId).val();
                var statusText = $('#recOrderStatus' + recId + ' option:selected').text();
                if (status !== '-1') {

                    if (confirm('Update status this order for this receiver to ' + statusText + "?")) {
                        postInvisibleForm('<c:url value="/Administration/Orders/updateOrderStatus"/>', {oId: oId, recId: recId, status: status, returnPage: 'others'});
                    }
                }
            }

        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/otherGiftedOrders"/>">Order Management</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Other Orders</h2>

        <!-- Content -->
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="<c:url value="/Administration/Orders/giftedOrders"/>"><b>Gifted Orders</b></a></li>
            <li role="presentation"><a href="<c:url value="/Administration/Orders/refundOrders"/>"><b>Refund Orders</b></a></li>
            <li role="presentation"><a href="<c:url value="/Administration/Orders/undecidedOrders"/>"><b>Undecided Orders</b></a></li>
            <li role="presentation" class="active"><a href="<c:url value="/Administration/Orders/otherOrders"/>"><b>Others</b></a></li>
        </ul>
        <p>&nbsp;</p>
        <c:forEach items="${mOs}" var="m" varStatus="theCount">
            <div class="row">
                <div class="col-md-4">
                    <div style="font-size: 16px;font-weight: bold;">
                        <spring:message code="mess.order"/> # <c:if test="${not empty m.key.invoice}"><b>${m.key.invoice.invoiceCode}</b></c:if>
                        <c:if test="${empty m.key.invoice}"><b>${m.key.id}</b></c:if>
                        </div>
                        <div style="margin-bottom: 10px;margin-top: 10px;"><spring:message code="mess.ordered-on"/>: &nbsp;<fmt:formatDate pattern="MMMM dd yyyy" value="${m.key.modifiedDate}"/></div>
                </div>
                <div class="col-md-8">
                    <div style="font-size: 16px;font-weight: bold;"><spring:message code="mess.sender" text="Sender"/>:</div>
                    <div style="margin-bottom: 10px;margin-top: 10px;">${m.key.sender.fullName}
                        ${m.key.sender.email}, ${m.key.sender.phone}

                    </div>
                </div>
            </div>
            <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                <c:if test="${not empty rio.gifts}">
                    <div class="row alert alert-success">
                        <div class="col-md-6">
                            <b>${rio.recipient.fullName}</b>, ${rio.recipient.email}, ${rio.recipient.phone}
                            
                            <c:if test="${rio.receiveMethod eq 'GIFT'}">
                            <div style="margin-top: 10px;">Delivery Address: </div>
                            <div><b>${rio.recAdd.name}</b><br/>
                                ${rio.recAdd.address}, ${rio.recAdd.ward}, ${rio.recAdd.district}<br/>
                                ${rio.recAdd.province.name}
                                <br/>
                                Email: ${rio.recAdd.email}, Phone: ${rio.recAdd.phone}
                            </div>
                            </c:if>
                            
                            <c:if test="${rio.receiveMethod eq 'MONEY'}">
                            <div style="margin-top: 10px;"><b>Refund to Bank Account</b>: </div>
                            <div style="font-size:14px;">Account number: <b>${rio.recBank.soTaiKhoan}</b><br/>
                                Account name: <b>${rio.recBank.tenNguoiHuong}</b><br/>
                                <b>${rio.recBank.bankName}, ${rio.recBank.chiNhanh}, ${rio.recBank.province.name}</b>
                                <br/>
                                Total refund: <b><fmt:formatNumber value="${rio.refundAmount}" pattern="###,###.##"/> VND</b>
                                <br/>
                                Email: ${rio.recBank.recEmail}
                            </div>
                                
                            </c:if>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group">
                                <%-- get receiver order status --%>
                                <c:set var="recStatus" value=""/>
                                <c:forEach var="g" items="${rio.gifts}" varStatus="gCount">
                                    <c:set var="recStatus" value="${g.bkStatus}"/>
                                </c:forEach>
                                <select id="recOrderStatus${rio.recipient.id}" class="form-control">
                                    <option value="-1">-- Order Status --</option>
                                    <option value="${PROCESSING}" <c:if test="${recStatus eq PROCESSING}">selected=""</c:if>>PROCESSING</option>
                                    <option value="${PURCHASED}" <c:if test="${recStatus eq PURCHASED}">selected=""</c:if>>PURCHASED</option>
                                    <option value="${DELIVERED}" <c:if test="${recStatus eq DELIVERED}">selected=""</c:if>>DELIVERED</option>
                                    <option value="${UNDELIVERABLE}" <c:if test="${recStatus eq UNDELIVERABLE}">selected=""</c:if>>UNDELIVERABLE</option>
                                    <option value="${REFUNDED}" <c:if test="${recStatus eq REFUNDED}">selected=""</c:if>>REFUNDED</option>
                                    <option value="${CANCELED}" <c:if test="${recStatus eq CANCELED}">selected=""</c:if>>CANCELED</option>
                                    <option value="${COMPLETED}" <c:if test="${recStatus eq COMPLETED}">selected=""</c:if>>COMPLETED</option>
                                    </select>
                                    <span class="input-group-btn" style="padding-left: 10px;">
                                        <button onclick="updateOrderStatus(${m.key.id}, ${rio.recipient.id})" class="btn btn-primary">Update Order Status</button>
                                </span>
                            </div>                                            
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover table-responsive table-striped">
                            <tbody>
                                <c:forEach var="g" items="${rio.gifts}" varStatus="gCount">
                                    <c:if test="${rio.receiveMethod ne 'MONEY'}">
                                    <tr>
                                        <td><b>${gCount.count}.</b></td>
                                        <td>
                                            <img class="media-object" src="${g.productImage}" style="width: 64px; height: 64px;" alt="...">
                                        </td>
                                        <td>
                                            <a href="<c:url value="/gifts/detail/${g.productId}"/>" target="_blank">${g.productName}</a><br/>
                                            <spring:message code="message.quantity" text="Quantity"/>: ${g.productQuantity} &nbsp; <spring:message code="message.price" text="Price"/>: VND <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/>
                                            <br/>Source: <a href="${g.productSource}" target="_blank">${g.productSource}</a>
                                        </td>
                                    </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>
        <div class="row">
            <div class="col-md-12">
                <%-- Paging --%>
                <nav>
                    <ul class="pagination pull-right">
                        <c:forEach begin="1" end="${pOs.totalPages}" var="i">
                            <c:choose>
                                <c:when test="${(i - 1) == pOs.number}">
                                    <li class="active">
                                        <a href="javascript:void(0)">${i}</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <a href="<c:url value="/Administration/Orders/otherOrders">
                                               <c:param name="paging.page" value="${i}" />
                                               <c:param name="paging.sort" value="id,DESC" />
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
        <!-- /main -->
    </jsp:body>
</template:Admin>