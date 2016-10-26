<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Receiver's Address - Lixi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            $(document).ready(function () {
                $("input[name='recBankRadio']").click(function () {
                    if($(this).prop("checked")){
                        if($(this).val()==0){
                            $('#otherBankForm').fadeIn("slow");
                            //
                            $("button[name='btnDelete']").hide();
                        }
                        else{
                            $('#otherBankForm').fadeOut();
                            $("button[name='btnDelete']").hide();
                            $('#btnDelete'+$(this).val()).show();
                        }
                    }
                });
                
                // submit address
                $('#btnSubmit').click(function(){
                    $("input[name='recBankRadio']").each(function(){
                    if($(this).prop("checked")){
                        if($(this).val()==0){
                            // new address, submit form
                            $('#recBankForm').submit();
                            return false;
                        }
                        else{
                            postInvisibleForm('<c:url value="/recipient/selectedBankAccount"/>', {recBankId: $(this).val(), oId:$('#oId').val()});
                            return false;
                        }
                    }
                    });
                });
                
                // delete
                $("button[name='btnDelete']").click(function(){
                    var selectedId = 0;
                    $("input[name='recBankRadio']").each(function(){
                        if($(this).prop("checked")){
                            selectedId = $(this).val();
                            //break;
                        }
                    });
                    
                    postInvisibleForm('<c:url value="/recipient/deleteBankAccount"/>', {id: selectedId, oId:$('#oId').val()});
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
                                <div class="panel-heading"><h3 class="title"><spring:message code="bank-address" text="Nhập thông tin tài khoản nhận tiền"/></h3></div>
                                <div class="panel-body">
                                    <c:if test="${not empty rbs}">
                                        <c:forEach items="${rbs}" var="rBank">
                                            <div class="row" style="margin-bottom: 10px;">
                                                <div class="col-md-1" style="padding-right: 0px; width: 40px;">
                                                    <input type="radio"  name="recBankRadio" value="${rBank.id}">
                                                </div>
                                                <div class="col-md-9" style="padding-left: 0px;">
                                                    ${rBank.soTaiKhoan}<br/>
                                                    ${rBank.tenNguoiHuong}<br/>
                                                    ${rBank.bankName}, ${rBank.chiNhanh}, ${rBank.province.name}
                                                </div>
                                                <div class="col-md-2">
                                                    <button name="btnDelete" id="btnDelete${rBank.id}" class="btn btn-warning" style="display: none;"><spring:message code="message.delete"/></button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="row" style="margin-top: 10px;">
                                            <div class="col-md-1" style="padding-right: 0px; width: 40px;">
                                                <input type="radio" name="recBankRadio" value="0" checked="">
                                            </div>
                                            <div class="col-md-11" style="padding-left: 0px;">
                                                <spring:message code="new-bank" text="Thêm tài khoản khác"/>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div id="otherBankForm">
                                        <c:url value="/recipient/refund" var="recBankSubmitUrl"/>
                                        <form:form method="post" modelAttribute="recBankForm" action="${recBankSubmitUrl}">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><spring:message code="rec-bank-account-number" text="Bank Account Number"/></label>
                                                        <form:input type="text" path="soTaiKhoan" class="form-control"/>
                                                        <div class="has-error"><form:errors path="soTaiKhoan" cssClass="help-block" element="div"/></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><spring:message code="rec-bank-account-name" text="Bank Account Name"/>:</label>
                                                        <form:input type="text" path="tenNguoiHuong" class="form-control"/>
                                                        <div class="has-error"><form:errors path="tenNguoiHuong" cssClass="help-block" element="div"/></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label><spring:message code="bank-name" text="Bank Name"/>:</label>
                                                        <form:input type="text" path="bankName" class="form-control"/>
                                                        <div class="has-error"><form:errors path="bankName" cssClass="help-block" element="div"/></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><spring:message code="province" text="Province"/></label>
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
                                                        <label><spring:message code="chi-nhanh" text="Brand Name"/></label>
                                                        <form:input type="text" path="chiNhanh" class="form-control"/>
                                                        <div class="has-error"><form:errors path="chiNhanh" cssClass="help-block" element="div"/></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <form:hidden path="oId"/>
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
                                            <c:forEach var="g" items="${rio.gifts}">
                                                <tr>
                                                    <td>${g.productName}</td>
                                                    <td>${g.productQuantity}</td>
                                                    <td><fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/></td>
                                                </tr>
                                            </c:forEach>
                                                <tr>
                                                    <td style="text-align: right;">
                                                        <spring:message code="shipping-charge" text="Shipping charge"/>
                                                    </td>
                                                    <td colspan="2" style="text-align: right;">
                                                        $<fmt:formatNumber minFractionDigits="2" value="${rio.shippingChargeAmount}" pattern="###,###.##"/>
                                                        =
                                                        <fmt:formatNumber maxFractionDigits="0" value="${rio.shippingChargeAmountVnd}" pattern="###,###"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right;">
                                                        <b><spring:message code="total-refund" text="Total Refund"/></b>
                                                    </td>
                                                    <td colspan="2" style="text-align: right;">
                                                        <b><fmt:formatNumber maxFractionDigits="0" value="${totalRefund}" pattern="###,###"/></b>
                                                    </td>
                                                </tr>
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