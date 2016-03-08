<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Sender Detail">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function doAction(id, action) {

                overlayOn($('#rowSender' + id));

                $.ajax(
                        {
                            url: '<c:url value="/Administration/SystemSender/action/"/>' + id + '/' + action,
                            type: "GET",
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR)
                            {
                                //data: return data from server
                                /* */
                                if (data.error === '0') {

                                    if (action === 'On') {
                                        /* */
                                        $('#tdStatus' + id).html('Active')
                                        $('#tdAction' + id).html('On | <a href="javascript:doAction(' + id + ', \'Off\');">Off</a>');
                                    } else if (action === 'Off') {
                                        /* */
                                        $('#tdStatus' + id).html('Deactivated');
                                        $('#tdAction' + id).html('<a href="javascript:doAction(' + id + ', \'On\');">Off</a> | On');
                                    }
                                }

                                overlayOff();
                            },
                            error: function (jqXHR, textStatus, errorThrown)
                            {
                                //if fails  
                                overlayOff();
                            }
                        });
            }

        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemSender/detail/${sender.id}"/>">Sender Detail</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Sender Detail</h2>
        <div class="row">
            <div class="col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover table-responsive table-striped">
                        <thead>
                            <tr>
                                <th nowrap>#</th><%-- 1 --%>
                                <th nowrap>Authorize Profile Id</th><%-- 2 --%>
                                <th nowrap>First Name</th><%-- 3 --%>
                                <th nowrap>Middle Name</th><%-- 4 --%>
                                <th nowrap>Last Name</th><%-- 5 --%>
                                <th nowrap>Email/Phone</th><%-- 6 --%>
                                <th nowrap>Created Date</th><%-- 7 --%>
                                <th nowrap>Status</th>
                                <th nowrap style="text-align: right;">Action</th><%-- 8 --%>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="rowSender${sender.id}">
                                <td>${sender.id}</td>
                                <td>${sender.authorizeProfileId}</td>
                                <td>${sender.firstName}</td>
                                <td>${sender.middleName}</td>
                                <td>${sender.lastName}</td>
                                <td>${sender.email} / ${sender.phone}</td>
                                <td>
                                    <fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${sender.createdDate}"/>
                                </td>
                                <td id="tdStatus${sender.id}" nowrap>
                                    <c:if test="${sender.activated eq true}">
                                        Active
                                    </c:if>
                                    <c:if test="${sender.activated eq false}">
                                        Deactivated
                                    </c:if>
                                </td>
                                <td id="tdAction${sender.id}" style="text-align: right;">
                                    <c:if test="${sender.activated eq true}">
                                        On
                                        |
                                        <a href="javascript:doAction(${sender.id}, 'Off');">Off</a>
                                    </c:if>
                                    <c:if test="${sender.activated eq false}">
                                        <a href="javascript:doAction(${sender.id}, 'On');">On</a>
                                        |
                                        Off
                                    </c:if>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <h3>Cards</h3>
        <div class="row">
            <div class="col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover table-responsive table-striped">
                        <thead>
                            <tr>
                                <th style="text-align: left;">#</th>
                                <th>name of card </th>
                                <th>expires on</th>
                                <th>Billing Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sender.userCards}" var="c">
                                <c:set var="lengthCard" value="${fn:length(c.cardNumber)}"/>
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.cardType eq 1}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-visa.png"/>"/>
                                            </c:when>
                                            <c:when test="${c.cardType eq 2}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-master.png"/>"/>
                                            </c:when>
                                            <c:when test="${c.cardType eq 3}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-discover.png"/>"/>
                                            </c:when>
                                            <c:when test="${c.cardType eq 4}">
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/card-amex.jpg"/>"/>
                                            </c:when>
                                        </c:choose>                                                    
                                        <span class="text-uppercase">Ending in ${fn:substring(c.cardNumber, lengthCard-4, lengthCard)}</span>
                                    </td>
                                    <td>${c.cardName}</td>
                                    <td>
                                        <c:if test="${c.expMonth < 10}">0${c.expMonth}</c:if><c:if test="${c.expMonth >= 10}">${c.expMonth}</c:if>/${c.expYear}
                                        </td>
                                        <td>
                                                <b>${c.billingAddress.firstName}&nbsp;${c.billingAddress.lastName}</b><br/>
                                        ${c.billingAddress.address}<br/>
                                        ${c.billingAddress.city}, ${c.billingAddress.state}, ${c.billingAddress.zipCode}, ${c.billingAddress.country}<br/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
        <h3>Receivers</h3>
        <div class="row">
            <div class="col-sm-12">
                <div class="table-responsive">
                    <table class="table table-hover table-responsive table-striped">
                        <thead>
                            <tr>
                                <th nowrap>#</th><%-- 1 --%>
                                <th nowrap>First Name</th><%-- 2 --%>
                                <th nowrap>Middle Name</th><%-- 3 --%>
                                <th nowrap>Last Name</th><%-- 4 --%>
                                <th nowrap>Email</th><%-- 5 --%>
                                <th nowrap>Phone</th><%-- 6 --%>
                                <th nowrap>Created Date</th><%-- 7 --%>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sender.recipients}" var="r">
                                <tr>
                                    <td>${r.id}</td><%-- 1 --%>
                                    <td>${r.firstName}</td><%-- 2 --%>
                                    <td>${r.middleName}</td><%-- 3 --%>
                                    <td>${r.lastName}</td><%-- 4 --%>
                                    <td>${r.email}</td><%-- 5 --%>
                                    <td>(${r.dialCode})&nbsp; ${r.phone}</td><%-- 6 --%>
                                    <td><fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${r.modifiedDate}"/></td>
                                </tr>

                                <c:forEach items="${r.processedOrders}" var="pO">
                                    <tr>
                                        <td colspan="7">
                                            <h4>Order #${pO.invoice.invoiceCode} </h4>
                                            <table class="table table-hover table-responsive table-striped" style="width:50%;">
                                                <thead>
                                                    <tr>
                                                        <th nowrap>Order</th><%-- 1 --%>
                                                        <th nowrap>Date</th><%-- 2 --%>
                                                        <th nowrap>Transaction No</th><%-- 3 --%>
                                                        <th nowrap>Option</th><%-- 4 --%>
                                                        <th>Status</th><%-- 5 --%>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td nowrap>
                                                            <a href="<c:url value="/Administration/Orders/detail/${pO.id}"/>">
                                                                ${pO.invoice.invoiceCode}
                                                            </a>
                                                            <br/>
                                                            1 USD = ${pO.lxExchangeRate.buy} VND
                                                        </td>
                                                        <td><fmt:formatDate pattern="MM/dd/yyyy" value="${pO.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${pO.createdDate}"/></td>
                                                        <td>${pO.invoice.netTransId} <br/>(${pO.invoice.translatedStatus})</td>
                                                        <td nowrap>
                                                            <c:if test="${pO.setting eq 0}">
                                                                Gift Only
                                                            </c:if>
                                                            <c:if test="${pO.setting eq 1}">
                                                                Allow Refund
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <c:if test="${pO.lixiStatus eq PROCESSED}">
                                                                Processed<br/>
                                                                <c:if test="${pO.lixiSubStatus eq SENT_MONEY}">(Sent Money Info)</c:if>
                                                                <c:if test="${pO.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                                            </c:if>
                                                            <c:if test="${pO.lixiStatus eq COMPLETED}">
                                                                Completed
                                                            </c:if>
                                                            <c:if test="${pO.lixiStatus eq CANCELED}">
                                                                Cancelled
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="table table-hover table-responsive table-striped" style="margin-bottom:0px;">
                                                <c:forEach items="${pO.gifts}" var="g" varStatus="theCount2">
                                                    <c:if test="${g.recipient.id eq r.id}">
                                                    <tr>
                                                        <td></td>
                                                        <td>${g.productQuantity}</td>
                                                        <td>${g.productName}</td>
                                                        <td style="text-align: right;">
                                                            <fmt:formatNumber value="${g.productPrice}" pattern="###,###.##"/> VND
                                                            <br/>
                                                            <fmt:formatNumber value="${g.usdPrice}" pattern="###,###.##"/> USD
                                                        </td>
                                                    </tr>
                                                    </c:if>
                                                </c:forEach>
                                                <c:forEach items="${pO.topUpMobilePhones}" var="t" varStatus="theCount2">
                                                    <c:if test="${t.recipient.id eq r.id}"></c:if>
                                                    <tr>
                                                        <td></td>
                                                        <td>1</td>
                                                        <td>Top Up Mobile Minutes ${t.phone}</td>
                                                        <td style="text-align: right;">
                                                            <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/> VND
                                                            <br/>
                                                            <fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/> USD
                                                        </td>
                                                </tr>
                                                </c:forEach>
                                                    
                                            </table>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
