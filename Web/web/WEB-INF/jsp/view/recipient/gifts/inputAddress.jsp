<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Receiver's Address - Lixi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            $(document).ready(function () {
                $("input[name='recAddRadio']").click(function () {
                    if($(this).prop("checked")){
                        if($(this).val()==0){
                            $('#otherAddForm').fadeIn("slow");
                            //
                            $("button[name='btnDelete']").hide();
                        }
                        else{
                            $('#otherAddForm').fadeOut();
                            //
                            $("button[name='btnDelete']").hide();
                            $('#btnDelete'+$(this).val()).show();
                        }
                    }
                });
                
                // submit address
                $('#btnSubmit').click(function(){
                    $("input[name='recAddRadio']").each(function(){
                    if($(this).prop("checked")){
                        if($(this).val()==0){
                            // new address, submit form
                            $('#recipientAddressForm').submit();
                            return false;
                        }
                        else{
                            postInvisibleForm('<c:url value="/recipient/selectedAddress"/>', {recAddId: $(this).val(), oId:$('#oId').val()});
                            return false;
                        }
                    }
                    });
                });
                // delete
                $("button[name='btnDelete']").click(function(){
                    var selectedId = 0;
                    $("input[name='recAddRadio']").each(function(){
                        if($(this).prop("checked")){
                            selectedId = $(this).val();
                            //break;
                        }
                    });
                    
                    postInvisibleForm('<c:url value="/recipient/deleteAddress"/>', {id: selectedId, oId:$('#oId').val()});
                });
            });
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
                                    <c:if test="${not empty recAdds}">
                                        <c:forEach items="${recAdds}" var="rAdd">
                                            <div class="row" style="margin-bottom: 10px;">
                                                <div class="col-md-1" style="padding-right: 0px; width: 40px;">
                                                    <input type="radio"  name="recAddRadio" value="${rAdd.id}">
                                                </div>
                                                <div class="col-md-9" style="padding-left: 0px;">
                                                    ${rAdd.name}<br/>
                                                    ${rAdd.address}, ${rAdd.ward}, ${rAdd.district}, ${rAdd.province.name}<br/>
                                                    <spring:message code="message.phone"/>:&nbsp;${rAdd.phone}
                                                </div>
                                                <div class="col-md-2">
                                                    <button name="btnDelete" id="btnDelete${rAdd.id}" class="btn btn-warning" style="display: none;"><spring:message code="message.delete"/></button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="col-md-1" style="padding-right: 0px; width: 40px;">
                                                <input type="radio" name="recAddRadio" value="0" checked="">
                                            </div>
                                            <div class="col-md-11" style="padding-left: 0px;">
                                                <spring:message code="new-add" text="Thêm địa chỉ khác"/>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${validationErrors != null}">
                                        <div class="msg msg-error">
                                            <ul>
                                                <c:forEach items="${validationErrors}" var="error">
                                                    <li><c:out value="${error.message}" /></li>
                                                    </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                    <div id="otherAddForm">
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
                                                        
                                                        <%--<button class="btn btn-warning" type="button" onclick="location.href = '<c:url value="/recipient/gifts"/>'"><spring:message code="message.cancel"/></button>--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </form:form>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-md-12"><button id="btnSubmit" class="btn btn-primary" type="button" onclick="" style="width:300px;"><spring:message code="message.save"/></button></div>
                                    </div>
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