<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Gifted Orders</h2>
        <div class="row" style="font-size:14px;">
            <div class="col-md-12">
                <!-- Content -->

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
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <select class="form-control">
                                            <option>-- Order Status --</option>
                                        </select>
                                        <span class="input-group-btn" style="padding-left: 10px;">
                                            <button class="btn btn-primary">Update Order Status</button>
                                            &nbsp;
                                            <button class="btn btn-danger" style="margin-left:5px;">Out of Stock</button>
                                        </span>
                                    </div>                                            
                                </div>
                            </div>
                            <c:forEach var="g" items="${rio.gifts}">
                                <div class="media">
                                    <div class="media-left">
                                        <a href="#">
                                            <img class="media-object" src="${g.productImage}" style="width: 64px; height: 64px;" alt="...">
                                        </a>
                                    </div>
                                    <div class="media-body">
                                        <h5 class="media-heading"><a href="<c:url value="/gifts/detail/${g.productId}"/>" target="_blank">${g.productName}</a></h5>
                                        <spring:message code="message.quantity" text="Quantity"/>: ${g.productQuantity} &nbsp; <spring:message code="message.price" text="Price"/>: VND <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/>
                                        <br/>Source: <a href="${g.productSource}" target="_blank">${g.productSource}</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </div>
        </div>

        <!-- /main -->
    </jsp:body>
</template:Admin>
