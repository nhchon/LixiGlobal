<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">

            jQuery(document).ready(function () {
                $('#btnSubmit').click(function () {

                    if ($('#oStatus').val() === '') {

                        alert("Please select the order's status");
                        $('#oStatus').focus();

                        return false;
                    } else {
                        return true;
                    }
                });

            });

            function sent(id) {

                overlayOn($('#rowO' + id));
                $("#orderSubmitForm input[name=id]").val(id);

                $.ajax(
                        {
                            url: '<c:url value="/Administration/Orders/submit2BK/"/>' + id,
                            type: "GET",
                            dataType: 'html',
                            success: function (data, textStatus, jqXHR)
                            {
                                //data: return data from server
                                $('#status' + id).html(data);

                                if (data.indexOf('Passed') > -1) {
                                    /* remove sent action */
                                    $('#tdAction' + id).html('');
                                }
                                /* */
                                overlayOff();
                            },
                            error: function (jqXHR, textStatus, errorThrown)
                            {
                                //if fails  
                                overlayOff();
                            }
                        });
            }

            function cancel(id) {

                if (confirm('Are you sure want to CANCEL this order id ' + id + ' ???')) {

                    document.location.href = '<c:url value="/Administration/Orders/cancel/"/>' + id + '/info';
                }
            }

            function viewRecipient(id) {
                $.get('<c:url value="/Administration/SystemRecipient/view/"/>' + id, function (data) {
                    $('#editRecipientContent').html(data);
                    $('#editRecipientModal').modal({show: true});

                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })
                });
            }

            function viewSender(id) {
                $.get('<c:url value="/Administration/SystemSender/view/"/>' + id, function (data) {
                    $('#editRecipientContent').html(data);
                    $('#editRecipientModal').modal({show: true});

                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })
                });
            }

            function getContent(oStatus) {
                $.get('<c:url value="/Administration/Orders/newOrders/ajax/"/>' + oStatus, function (data) {
                    $('#divContent').html(data);
                });
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/newOrders/-1"/>">New Orders</a></li>
        </ul>
        <h2 class="sub-header">New Orders</h2>
        <div class="row">
            <div class="col-md-12">
                <form role="form" id="reportForm" action="<c:url value="/Administration/Orders/newOrders"/>" method="get">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="search" value="true" />
                    <input type="hidden" name="paging.page"  id="paging.page" value="1"/>
                    <input type="hidden" name="paging.size"  id="paging.size" value="50"/>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="email">New Order's Status:</label>
                                <select class="form-control" id="oStatus" name="oStatus">
                                    <option value="">Please select status</option>
                                    <option value="${UN_SUBMITTED}" <c:if test="${oStatus eq UN_SUBMITTED}">selected=""</c:if>>Failed Sent</option>
                                    <option value="${SENT_INFO}" <c:if test="${oStatus eq SENT_INFO}">selected=""</c:if>>Success Sent</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <button type="submit" id="btnSubmit" class="btn btn-primary">Run Report</button>
                    </form>                
                </div>
            </div>
            <div id="divContent">
            <c:set var="transferPercent" value="95"/>
            <c:if test="${not empty sessionScope['scopedTarget.loginedUser'].configs['LIXI_BAOKIM_TRANFER_PERCENT']}">
                <c:set var="transferPercent" value="${sessionScope['scopedTarget.loginedUser'].configs['LIXI_BAOKIM_TRANFER_PERCENT']}"/>
            </c:if>
            <div class="row">
                <div class="col-sm-12">
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane fade active in">
                            <div class="table-responsive">
                                <table class="table table-hover table-responsive table-striped">
                                    <thead>
                                        <tr>
                                            <th nowrap>Date</th><%-- 1 --%>
                                            <th nowrap style="text-align:center;">Order</th><%-- 2 --%>
                                            <th nowrap>Transaction No</th><%-- 3 --%>
                                            <th nowrap>Option</th><%-- 4 --%>
                                            <th>Sender</th><%-- 5 --%>
                                            <th style="text-align: center;">Receiver(s)</th><%-- 6 --%>
                                            <th style="text-align: right;">Amount</th><%-- 7 --%>
                                            <th>Status</th><%-- 8 --%>
                                            <th style="text-align: right;">Action</th><%-- 9 --%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="countRec" value="0"/>
                                        <c:set var="totalAmountVnd" value="0"/>
                                        <c:set var="totalAmountUsd" value="0"/>
                                        <c:forEach items="${mOs}" var="m" varStatus="theCount">
                                            <c:set var="countRec" value="${theCount.count}"/>
                                            <tr id="rowO${m.key.id}">
                                                <td><fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/></td>
                                                <td nowrap style="text-align:center;">
                                                    <a href="<c:url value="/Administration/Orders/detail/${m.key.id}"/>">
                                                        ${m.key.invoice.invoiceCode}
                                                    </a>
                                                    <br/>
                                                    1 USD = ${m.key.lxExchangeRate.buy} VND
                                                </td>
                                                <td>${m.key.invoice.netTransId}</td>
                                                <td nowrap>
                                                    <c:if test="${m.key.setting eq 0}">
                                                        Gift Only
                                                    </c:if>
                                                    <c:if test="${m.key.setting eq 1}">
                                                        Allow Refund
                                                    </c:if>
                                                </td>
                                                <td>${m.key.sender.fullName}<br/><a href="javascript:viewSender(${m.key.sender.id});">${m.key.sender.beautyId}</a></td>
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
                                                <td id="status${m.key.id}">
                                                    <c:forEach items="${m.value}" var="rio">
                                                        <c:if test="${not empty rio.gifts}">
                                                            <c:choose>
                                                                <c:when test="${rio.bkStatus eq 'Not Sent'}">
                                                                    <span class="alert-danger">${rio.bkStatus}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="alert-success">${rio.bkStatus}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <br/><br/>
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td style="text-align: right;" id="tdAction${m.key.id}">
                                                    <c:if test="${oStatus eq UN_SUBMITTED}">
                                                        <a href="javascript:sent(${m.key.id});">Send</a>
                                                    </c:if>
                                                    <c:if test="${oStatus eq SENT_INFO}"><a href="javascript:cancel(${m.key.id});">Cancel</a></c:if>
                                                    </td>
                                                </tr>
                                        </c:forEach>
                                    </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="9">
                                            <%-- Paging --%>
                                            <nav>
                                                <ul class="pagination pull-right">
                                                    <c:forEach begin="1" end="${pOrder.totalPages}" var="i">
                                                        <c:choose>
                                                            <c:when test="${(i - 1) == pOrder.number}">
                                                                <li class="active">
                                                                    <a href="javascript:void(0)">${i}</a>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li>
                                                                    <a href="<c:url value="/Administration/SystemSender/report/${status}">
                                                                       <c:param name="paging.page" value="${i}" />
                                                                       <c:param name="paging.size" value="50" />
                                                                   </c:url>">${i}</a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </ul>
                                            </nav>
                                        </td>
                                    </tr>
                                </tfoot>
                                    
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8"></div>
                <div class="col-md-4">
                    <table class="table table-responsive" style="font-size: 14px;">
                        <thead>
                        <th colspan="3">Summary:</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Total:</td>
                                <td style="text-align: right;">${countRec}</td>
                                <td>Receivers</td>
                            </tr>
                            <tr>
                                <td>Total Amount(fee, tax,...):</td>
                                <td style="text-align: right;"><fmt:formatNumber value="${totalAmountUsd}" pattern="###,###.##"/></td>
                                <td>USD</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td style="text-align: right;"><fmt:formatNumber value="${totalAmountVnd}" pattern="###,###.##"/></td>
                                <td>VND</td>
                            </tr>
                            <c:if test="${not empty VCB}">
                                <tr>
                                    <td nowrap>Current FX Rate<br/>(${VCB.time})</td>
                                        <c:set var="currentFX" value="0"/>
                                        <c:forEach items="${VCB.exrates}" var="ex">
                                            <c:if test="${ex.code == 'USD'}">
                                                <c:set var="currentFX" value="${ex.buy}"/>
                                            </c:if>
                                        </c:forEach>                            
                                    <td nowrap style="text-align: right;">1 USD = <fmt:formatNumber value="${currentFX}" pattern="###,###.##"/></td>
                                    <td>VND</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
