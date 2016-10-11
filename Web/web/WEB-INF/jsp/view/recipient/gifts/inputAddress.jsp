<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Receiver's Address - Lixi Global">

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
                    <div class="row">
                        <div class="col-md-8">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h3 class="title"><spring:message code="gift-address" text="Nhập địa chỉ giao hàng"/></h3></div>
                                <div class="panel-body">
                                    <c:if test="${validationErrors != null}">
                                        <div class="msg msg-error">
                                            <ul>
                                                <c:forEach items="${validationErrors}" var="error">
                                                    <li><c:out value="${error.message}" /></li>
                                                    </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                    <c:url value="/recipient/address" var="recAddSubmitUrl"/>
                                    <form:form method="post" modelAttribute="recipientAddressForm" action="${recAddSubmitUrl}">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label><spring:message code="message.name"/>:</label>
                                                    <form:input type="text" path="recName" class="form-control"/>
                                                    <div class="has-error"><form:errors path="recName" cssClass="help-block" element="div"/></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Receiver's Address</label>
                                                    <form:input type="text" path="recAddress" class="form-control"/>
                                                    <div class="has-error"><form:errors path="recAddress" cssClass="help-block" element="div"/></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label>Province</label>
                                                    <form:select path="recProvince" class="form-control">
                                                        <c:forEach items="${provinces}" var="p">
                                                            <option value="${p.id}">${p.name}</option>
                                                        </c:forEach>
                                                    </form:select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label><spring:message code="mess.district" text="Quận/huyện"/></label>
                                                    <form:input type="text" path="recDist" class="form-control"/>
                                                    <div class="has-error"><form:errors path="recDist" cssClass="help-block" element="div"/></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label><spring:message code="mess.ward" text="Phường, xã"/></label>
                                                    <form:input type="text" path="recWard" class="form-control"/>
                                                    <div class="has-error"><form:errors path="recWard" cssClass="help-block" element="div"/></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label><spring:message code="mess.cell-phone" text="Điện thoại di động"/></label>
                                                    <form:input type="text" path="recPhone" class="form-control"/>
                                                    <div class="has-error"><form:errors path="recPhone" cssClass="help-block" element="div"/></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="form-group">
                                                    <form:hidden path="oId"/>
                                                    <button class="btn btn-primary" type="submit" style="width:300px;"><spring:message code="message.save"/></button>
                                                    <%--<button class="btn btn-warning" type="button" onclick="location.href = '<c:url value="/recipient/gifts"/>'"><spring:message code="message.cancel"/></button>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h3 class="title"><spring:message code="gift-info" text="Thông tin đơn hàng"/></h3></div>
                                <div class="panel-body">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th><spring:message code="san-pham" text="Sản phẩm"/></th>
                                                <th><spring:message code="quantity"/></th>
                                                <th><spring:message code="message.price"/></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="g" items="${order.gifts}">
                                                <c:if test="${sessionScope['scopedTarget.loginedUser'].email eq g.recipientEmail}">
                                                    <tr>
                                                        <td>${g.productName}</td>
                                                        <td>${g.productQuantity}</td>
                                                        <td><fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>