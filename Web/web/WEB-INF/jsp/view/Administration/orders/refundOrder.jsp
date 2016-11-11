<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function outOfStock(oId, recId) {
                if (confirm('Send email for Gift Unavailable to this receiver?')) {
                    document.location.href = '<c:url value="/Administration/Orders/outOfStock/"/>' + oId + '/' + recId;
                }
            }

            function updateOrderStatus(oId, recId) {

                var status = $('#recOrderStatus' + recId).val();
                var statusText = $('#recOrderStatus' + recId + ' option:selected').text();
                if (status !== '-1') {

                    if (confirm('Update status this order for this receiver to ' + statusText + "?")) {
                        postInvisibleForm('<c:url value="/Administration/Orders/updateOrderStatus"/>', {oId: oId, recId: recId, status: status, returnPage: 'refundOrders'});
                    }
                }
            }

        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/giftedOrders"/>">Order Management</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Refund Orders</h2>

        <!-- Content -->
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="<c:url value="/Administration/Orders/giftedOrders"/>"><b>Gifted Orders</b></a></li>
            <li role="presentation" class="active"><a href="<c:url value="/Administration/Orders/refundOrders"/>"><b>Refund Orders</b></a></li>
            <li role="presentation"><a href="<c:url value="/Administration/Orders/undecidedOrders"/>"><b>Undecided Orders</b></a></li>
            <li role="presentation"><a href="<c:url value="/Administration/Orders/otherOrders"/>"><b>Others</b></a></li>
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
                <c:if test="${not empty rio.gifts && rio.receiveMethod eq 'MONEY'}">
                    <div class="row alert alert-success">
                        <div class="col-md-6">
                            <b>${rio.recipient.fullName}</b>, ${rio.recipient.email}, ${rio.recipient.phone}
                            <div style="margin-top: 10px;"><b>Refund to Bank Account</b>: </div>
                            <div style="font-size:14px;">Account number: <b>${rio.recBank.soTaiKhoan}</b><br/>
                                Account name: <b>${rio.recBank.tenNguoiHuong}</b><br/>
                                <b>${rio.recBank.bankName}, ${rio.recBank.chiNhanh}, ${rio.recBank.province.name}</b>
                                <br/>
                                Total refund: <b><fmt:formatNumber value="${rio.refundAmount}" pattern="###,###.##"/> VND</b>
                                <br/>
                                Email: ${rio.recBank.recEmail} ${rio.receiveMethod}
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group">
                                <select id="recOrderStatus${rio.recipient.id}" class="form-control">
                                    <option value="-1">-- Order Status --</option>
                                    <option value="${PROCESSING}">PROCESSING</option>
                                    <option value="${PURCHASED}">PURCHASED</option>
                                    <option value="${DELIVERED}">DELIVERED</option>
                                    <option value="${UNDELIVERABLE}">UNDELIVERABLE</option>
                                    <option value="${REFUNDED}">REFUNDED</option>
                                    <option value="${CANCELED}">CANCELED</option>
                                    <option value="${COMPLETED}">COMPLETED</option>
                                </select>
                                <span class="input-group-btn" style="padding-left: 10px;">
                                    <button onclick="updateOrderStatus(${m.key.id}, ${rio.recipient.id})" class="btn btn-primary">Update Order Status</button>
                                </span>
                            </div>                                            
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:forEach>

        <!-- /main -->
    </jsp:body>
</template:Admin>
