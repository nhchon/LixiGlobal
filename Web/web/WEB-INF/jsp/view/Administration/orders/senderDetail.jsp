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
                                <th nowrap style="text-align:center;">Name</th><%-- 3 --%>
                                <th nowrap style="text-align:center;">Email/Phone</th><%-- 6 --%>
                                <th nowrap>Total Amount</th><%-- 7 --%>
                                <th nowrap>Graders</th>
                                <th nowrap style="text-align: right;">Status</th>
                                <th nowrap style="text-align: right;">Action</th><%-- 8 --%>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="rowSender${sender.id}">
                                <td>${sender.id}</td>
                                <td>${sender.authorizeProfileId}</td>
                                <td style="text-align:center;">${sender.fullName}<br/><fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${sender.createdDate}"/></td>
                                <td style="text-align:center;">${sender.email} <br/> ${sender.phone}</td>
                                <td></td>
                                <td></td>
                                <td id="tdStatus${sender.id}" nowrap style="text-align: right;">
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
        <h3>Orders</h3>
        <div class="row">
            <div class="col-sm-12">
                <div class="table-responsive">
                    <c:set var="countRec" value="0"/>
                    <c:set var="totalAmountVnd" value="0"/>
                    <c:set var="totalAmountUsd" value="0"/>
                    <c:forEach items="${mOs}" var="m" varStatus="theCount">
                        <table class="table table-hover table-responsive table-striped">
                            <thead>
                                <tr>
                                    <th nowrap>Order # <a href="<c:url value="/Administration/Orders/detail/${m.key.id}"/>">${m.key.invoice.invoiceCode}</a>
                                    </th><%-- 1 --%>
                                    <th style="text-align: right;">Amount</th><%-- 2 --%>
                                    <th nowrap style="text-align: center;">Transaction</th><%-- 3 --%>
                                    <th nowrap style="text-align: center;">Option</th><%-- 4 --%>
                                    <th style="text-align: center;">Status</th><%-- 5 --%>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="countRec" value="${theCount.count}"/>
                                <tr id="rowO${m.key.id}">
                                    <td nowrap>
                                        <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                            <c:if test="${not empty rio.gifts}">
                                                ${rio.recipient.fullName}<br/><a href="javascript:viewRecipient(${rio.recipient.id});">${rio.recipient.beautyId}</a><br/>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td style="text-align: right;">
                                        <c:forEach items="${m.value}" var="rio">
                                            <c:if test="${not empty rio.gifts}">
                                                <fmt:formatNumber value="${rio.giftTotal.usd}" pattern="###,###.##"/> USD<br/>
                                                <c:if test="${m.key.setting eq 0}">
                                                    <fmt:formatNumber value="${rio.giftTotal.vnd * transferPercent/100.0}" pattern="###,###.##"/> VND (${transferPercent}%)<br/>
                                                    <c:set var="totalAmountVnd" value="${totalAmountVnd + rio.giftTotal.vnd * transferPercent/100.0}"/>
                                                </c:if>
                                                <c:if test="${m.key.setting eq 1}">
                                                    <fmt:formatNumber value="${rio.giftTotal.vnd}" pattern="###,###.##"/> VND<br/>
                                                    <c:set var="totalAmountVnd" value="${totalAmountVnd + rio.giftTotal.vnd}"/>
                                                </c:if>
                                                <c:set var="totalAmountUsd" value="${totalAmountUsd + rio.giftTotal.usd}"/>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td style="text-align: center;">${m.key.invoice.netTransId}<br/> ${m.key.invoice.translatedStatus}</td>
                                    <td nowrap style="text-align: center;">
                                        <c:if test="${m.key.setting eq 0}">
                                            Gift Only
                                        </c:if>
                                        <c:if test="${m.key.setting eq 1}">
                                            Allow Refund
                                        </c:if>
                                        <br/><fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/>
                                    </td>
                                    <td id="status${m.key.id}"  style="text-align: center;">
                                        <c:if test="${m.key.lixiStatus eq PROCESSED}">
                                            Processed<br/>
                                            <c:if test="${m.key.lixiSubStatus eq SENT_MONEY}">(Sent Money Info)</c:if>
                                            <c:if test="${m.key.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                        </c:if>
                                        <c:if test="${m.key.lixiStatus eq COMPLETED}">
                                            Completed
                                        </c:if>
                                        <c:if test="${m.key.lixiStatus eq CANCELED}">
                                            Cancelled
                                        </c:if>
                                    </td>
                                    </tr>
                                </tbody>
                            </table>
                    </c:forEach>
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
