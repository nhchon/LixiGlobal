<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            $(document).ready(function () {
                $("input[name='orderId']").change(function () {
                    // Check input( $( this ).val() ) for validity here
                    //alert($(this).val())
                    $("input[name='gifts-" + $(this).val() + "']").prop("checked", $(this).is(':checked'));
                });
            });
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <div class="row">
            <div class="col-lg-4 ">
                <ul class="breadcrumb">
                    <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                    <li><a href="<c:url value="/Administration/Orders/newOrders"/>">Not Submitted</a></li>
                </ul>
            </div>
        </div>

        <!-- main -->
        <h2 class="sub-header">Orders Not Submitted Yet</h2>
        <div class="table-responsive">
            <div class="row">
                <div class="col-md-12">
                    <button type="button" class="btn btn-info active">In Process</button> 
                    <button type="button" class="btn btn-success">Processed</button> 
                    <button type="button" class="btn btn-primary">Settled</button> 
                    <button type="button" class="btn btn-danger">Completed</button> 
                </div>
            </div>
            <div class="row">
                <div class="col-md-1">#</div>
            </div>
            <form action="${pageContext.request.contextPath}/Administration/Orders/sendToBaoKim" method="post">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th class="col-md-1"><button class="btn btn-primary">Submit to BaoKim</button></th>
                            <th>Sender</th>
                            <th>Exchange</th>
                            <th>Payment method</th>
                            <th>Setting</th>
                            <th>Status</th>
                            <th>Message</th>
                            <th>Created date</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${LIXI_ORDERS.content}" var="o">
                            <tr>
                                <td style="text-align: center;"><input type="checkbox" name="orderId" value="${o.id}"/></td>
                                <td>${o.sender.firstName}&nbsp;<c:if test="${not empty o.sender.middleName}">${o.sender.middleName}&nbsp;</c:if>${o.sender.lastName}</td>
                                <td><fmt:formatNumber value="${o.lxExchangeRate.buy}" pattern="###,###.##"/> VND = 1 ${o.lxExchangeRate.currency.code}</td>
                                <td>
                                    <%-- Payment method --%>
                                    <c:if test="${not empty o.card}">
                                        <c:set var="lengthCard" value="${fn:length(o.card.cardNumber)}"/>
                                        <b>${o.card.cardTypeName}</b> ending with ${fn:substring(o.card.cardNumber, lengthCard-4, lengthCard)}
                                    </c:if>
                                    <c:if test="${not empty o.bankAccount}">
                                        <c:set var="lengthCard" value="${fn:length(o.bankAccount.checkingAccount)}"/>
                                        <b>${o.bankAccount.name}</b> ending in ${fn:substring(o.bankAccount.checkingAccount, lengthCard-4, lengthCard)}
                                    </c:if>
                                </td>
                                <td>
                                    <%-- Setting --%>
                                    ${o.settingName}
                                </td>
                                <td>
                                    <%-- Status --%>
                                    ${o.lixiStatusName}
                                </td>
                                <td><a href="javascript:void(0);">Edit</a></td>
                                <td><fmt:formatDate type="both" value="${o.modifiedDate}"/></td>
                            </tr>
                            <%-- // Gifts --%>
                            <c:forEach items="${o.gifts}" var="g">
                                <tr>
                                    <td></td>
                                    <td colspan="7">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Recipient Name</th>
                                                    <th>Product Name</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><input type="checkbox" disabled="" value="${g.id}" name="gifts-${o.id}"/></td>
                                                    <td>${g.recipient.firstName}&nbsp;<c:if test="${not empty g.recipient.middleName}">${g.recipient.middleName}&nbsp;</c:if>${g.recipient.lastName}</td> 
                                                    <td>${g.productName}</td> 
                                                    <td>${g.productQuantity} x <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND = <fmt:formatNumber value="${g.productPrice * g.productQuantity}" pattern="###,###.##"/></td> 
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </tbody>
                </table>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
        </div>
        <!-- /main -->
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
