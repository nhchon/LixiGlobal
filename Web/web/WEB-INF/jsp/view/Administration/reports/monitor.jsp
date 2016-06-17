<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Transaction Monitor">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function gotIt(id){
                overlayOn($('#rowMonitor'+id));
                $.ajax(
                {
                    url: '<c:url value="/Administration/TransactionMonitor/process/"/>' + id,
                    type: "GET",
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        if (data.error === '1') {
                            
                            alert('There is something wrong. Please try again!');
                        }
                        else {
                            $('#rowMonitor'+id).remove();
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
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/monitor_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/TransactionMonitor/report"/>">Transaction Monitor</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Transaction Monitor</h2>
        <security:authentication property="principal.configs['LIXI_BAOKIM_TRANFER_PERCENT']" var="transferPercent" />
        <c:if test="${empty transferPercent}">
            <c:set var="transferPercent" value="95"/>
        </c:if>
        <div class="row">
            <div class="col-sm-12">
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive table-striped">
                                <thead>
                                    <tr>
                                        <th nowrap>Date</th><%-- 1 --%>
                                        <th nowrap style="text-align:center;">Transaction No</th><%-- 3 --%>
                                        <th nowrap style="text-align:center;">Order</th><%-- 2 --%>
                                        <th nowrap>Option</th><%-- 4 --%>
                                        <th>Sender</th><%-- 5 --%>
                                        <th style="text-align: center;">Receiver(s)</th><%-- 6 --%>
                                        <th style="text-align: right;">Amount</th><%-- 7 --%>
                                        <th style="text-align: right;">Status</th><%-- 8 --%>
                                        <th style="text-align: right;">#</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="countRec" value="0"/>
                                    <c:set var="totalAmountVnd" value="0"/>
                                    <c:set var="totalAmountUsd" value="0"/>
                                    <c:forEach items="${mOs}" var="m" varStatus="theCount">
                                        <c:set var="countRec" value="${theCount.count}"/>
                                        <tr id="rowO${m.key.id}" class="warning">
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/>
                                            </td>
                                            <td style="text-align:center;"><b>${m.key.invoice.netTransId}</b></td>
                                            <td nowrap style="text-align:center;"><a href="<c:url value="/Administration/Orders/detail/${m.key.id}"/>">
                                                    ${m.key.invoice.invoiceCode}
                                                </a>
                                                <br/>
                                                1 USD = ${m.key.lxExchangeRate.buy} VND
                                            </td>
                                            <td nowrap>
                                                <c:if test="${m.key.setting eq 0}">
                                                    Gift Only
                                                </c:if>
                                                <c:if test="${m.key.setting eq 1}">
                                                    Allow Refund
                                                </c:if>
                                            </td>
                                            <td>${m.key.sender.fullName}<br/><a href="<c:url value="/Administration/SystemSender/detail/${m.key.sender.id}"/>">${m.key.sender.beautyId}</a></td>
                                            <td style="text-align: center;">
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
                                            <td style="text-align: right;">
                                                ${m.key.invoice.invoiceStatus}
                                            </td>
                                            <td style="text-align: right;" nowrap>
                                                <button class="btn btn-primary btn-sm" onclick="alert('In Implementation')">Check</button>
                                            </td>
                                        </tr>
                                        <c:if test="${m.key.invoice.monitored ne 0}">
                                            <tr class="danger">
                                                <td colspan="9">
                                                    <c:if test="${m.key.invoice.monitored eq OVER_100_USD}">
                                                        *** Giao dịch trên 100$
                                                    </c:if>
                                                    <c:if test="${m.key.invoice.monitored eq NAME_ON_CARD_WRONG}">
                                                        *** Thông tin trên thẻ không trùng với người gửi
                                                    </c:if>
                                                    <c:if test="${m.key.invoice.monitored eq OVER_MAX_NUM_ORDER}">
                                                        *** Người gửi có từ 3 transaction trong trạng thái In Progress
                                                    </c:if>
                                                </td>
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
    </jsp:body>
</template:Admin>
