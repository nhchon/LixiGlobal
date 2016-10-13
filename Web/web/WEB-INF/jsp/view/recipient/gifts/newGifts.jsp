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
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title"><spring:message code="your-gifts" text="Your Gifts"/></h2>
                    <c:forEach var="LIXI_ORDER" items="${NEW_ORDERS}">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <spring:message code="mess.order"/> # <c:if test="${not empty LIXI_ORDER.invoice}"><b>${LIXI_ORDER.invoice.invoiceCode}</b></c:if>
                                        <c:if test="${empty LIXI_ORDER.invoice}"><b>${LIXI_ORDER.id}</b></c:if>
                                            <br/>
                                        <spring:message code="mess.ordered-on"/>: &nbsp;<fmt:formatDate pattern="MMMM dd yyyy" value="${LIXI_ORDER.modifiedDate}"/>
                                    </div>
                                    <div class="col-md-4">
                                        <div style="font-size: 16px;font-weight: bold;"><spring:message code="mess.sender" text="Sender"/>:</div>
                                        <div style="margin-bottom: 10px;margin-top: 10px;">${LIXI_ORDER.sender.fullName}</div>
                                        <div><spring:message code="message.email"/>: ${LIXI_ORDER.sender.email}</div>
                                        <div><spring:message code="message.phone"/>: ${LIXI_ORDER.sender.phone}</div>
                                    </div>
                                    <div class="col-md-4">
                                        <div style="font-size: 16px;font-weight: bold; text-align: center;"><spring:message code="mess.select-method" text="Please Select Gifting Method"/>:</div>
                                        <div style="margin-top: 10px;text-align: center;">
                                            <button class="btn btn-success pull-left btn-has-link-event" data-link="<c:url value="/recipient/address/${LIXI_ORDER.id}"/>">GIFTED</button>
                                            <button class="btn btn-danger pull-right btn-has-link-event" data-link="<c:url value="/recipient/refund/${LIXI_ORDER.id}"/>">REFUND</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- Gifts --%>
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <c:forEach var="g" items="${LIXI_ORDER.gifts}">
                                    <c:if test="${sessionScope['scopedTarget.loginedUser'].email eq g.recipientEmail}">
                                    <div class="media">
                                        <div class="media-left">
                                            <a href="#">
                                                <img class="media-object" src="${g.productImage}" style="width: 64px; height: 64px;" alt="...">
                                            </a>
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a href="<c:url value="/gifts/detail/${g.productId}"/>" target="_blank">${g.productName}</a></h4>
                                            <spring:message code="message.quantity" text="Quantity"/>: ${g.productQuantity} &nbsp; <spring:message code="message.price" text="Price"/>: VND <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/>
                                        </div>
                                    </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>