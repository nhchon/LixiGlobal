<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Your Gifts - Lixi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title"><spring:message code="your-gifts" text="Your Gifts"/></h2>
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
                            <c:if test="${sessionScope['scopedTarget.loginedUser'].email eq rio.recipient.email}">
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
                                        <div class="input-group pull-right">
                                            <%-- get receiver order status --%>
                                            <c:set var="recStatus" value=""/>
                                            <c:forEach var="g" items="${rio.gifts}" varStatus="gCount">
                                                <c:set var="recStatus" value="${g.bkStatus}"/>
                                            </c:forEach>
                                            <select id="recOrderStatus${rio.recipient.id}" class="form-control" disabled="">
                                                <option value="-1">-- Order Status --</option>
                                                <option value="${PROCESSING}" <c:if test="${recStatus eq PROCESSING}">selected=""</c:if>>PROCESSING</option>
                                                <option value="${PURCHASED}" <c:if test="${recStatus eq PURCHASED}">selected=""</c:if>>PURCHASED</option>
                                                <option value="${DELIVERED}" <c:if test="${recStatus eq DELIVERED}">selected=""</c:if>>DELIVERED</option>
                                                <option value="${UNDELIVERABLE}" <c:if test="${recStatus eq UNDELIVERABLE}">selected=""</c:if>>UNDELIVERABLE</option>
                                                <option value="${REFUNDED}" <c:if test="${recStatus eq REFUNDED}">selected=""</c:if>>REFUNDED</option>
                                                <option value="${CANCELED}" <c:if test="${recStatus eq CANCELED}">selected=""</c:if>>CANCELED</option>
                                                <option value="${COMPLETED}" <c:if test="${recStatus eq COMPLETED}">selected=""</c:if>>COMPLETED</option>
                                                </select>
                                        </div>                                            
                                    </div>
                                </div>
                                <c:if test="${rio.receiveMethod ne 'MONEY'}">
                                <div class="table-responsive">
                                    <table class="table table-hover table-responsive table-striped" style="margin-bottom: 0px;">
                                        <tbody>
                                            <c:forEach var="g" items="${rio.gifts}" varStatus="gCount">
                                                
                                                <tr>
                                                    <td><b>${gCount.count}.</b></td>
                                                    <td>
                                                        <img class="media-object" src="${g.productImage}" style="width: 64px; height: 64px;" alt="...">
                                                    </td>
                                                    <td>
                                                        <a href="<c:url value="/gifts/detail/${g.productId}"/>" target="_blank">${g.productName}</a><br/>
                                                        <%--
                                                        <spring:message code="message.quantity" text="Quantity"/>: ${g.productQuantity} &nbsp; <spring:message code="message.price" text="Price"/>: VND <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/>
                                                        <br/>Source: <a href="${g.productSource}" target="_blank">${g.productSource}</a>
                                                        --%>
                                                    </td>
                                                </tr>
                                                
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                </c:if>
                            </c:if>
                            </c:if>
                        </c:forEach>
                        <p>&nbsp;</p>
                    </c:forEach>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>