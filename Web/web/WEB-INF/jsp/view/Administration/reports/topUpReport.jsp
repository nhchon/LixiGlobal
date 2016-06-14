<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Top Up">
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/bootstrap-datepicker3.min.css"/>">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">

            jQuery(document).ready(function () {
                $('#btnSubmit').click(function () {

                    if ($('#status').val() === '') {

                        alert('Please select the status');
                        $('#status').focus();

                        return false;
                    }

                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();

                    if (fromDate === '' && toDate === '') {
                        alert('Please input from date and/or end date');
                        $('#fromDate').focus();
                        return false;
                    }

                    if ((fromDate !== '' && toDate !== '') && (fromDate > toDate)) {

                        alert('The value of from date must be smaller or equal end date');
                        $('#fromDate').focus();
                        return false;
                    }

                    return true;
                });
            });
            
            function viewRecipient(id) {
                $.get('<c:url value="/Administration/SystemRecipient/view/"/>' + id, function (data) {
                    $('#editRecipientContent').html(data);
                    $('#editRecipientModal').modal({show: true});

                    $('#editRecipientModal').on('shown.bs.modal', function () {
                        // TODO
                    })
                });
            }
            
            function jump(page, size){
                $('#paging.page').val(page);
                $('#paging.size').val(size);
                
                $('#reportForm').submit();
            }
        </script>
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-datepicker.min.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemTopUp/report"/>">Top Up Reports</a></li>
        </ul>

        <!-- main -->
        <div class="row">
            <div class="col-md-9"><h2 class="sub-header">Top Up Reports</h2></div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-10" style="padding-right: 0px;">
                        <input id="topUpBalance" type="text" class="form-control" style="margin-top: 20px; text-align: center; font-weight: bold;" readonly="" value="${topUpBalance}"/>
                    </div>
                    <div class="col-md-2" style="margin-top: 30px;padding-left:5px;">
                        <b>VND</b>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form role="form" id="reportForm" action="<c:url value="/Administration/SystemTopUp/report"/>" method="get">
                    <input type="hidden" name="search" value="true" />
                    <input type="hidden" name="paging.page"  id="paging.page" value="1"/>
                    <input type="hidden" name="paging.size"  id="paging.size" value="50"/>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="email">TopUp's Status:</label>
                                <select class="form-control" id="status" name="status">
                                    <option value="">Please select status</option>
                                    <option value="All" <c:if test="${status eq 'All'}">selected=""</c:if>>All</option>
                                    <option value="${UN_SUBMITTED}" <c:if test="${status eq UN_SUBMITTED}">selected=""</c:if>>Failed Sent</option>
                                    <option value="${COMPLETED}" <c:if test="${status eq COMPLETED}">selected=""</c:if>>Success Sent</option>
                                    <option value="${CANCELED}" <c:if test="${status eq CANCELED}">selected=""</c:if>>Canceled</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="pwd">From Date:</label>
                                <div class="input-group date" data-provide="datepicker" data-date-auto-close="true"  data-date-end-date="new Date()" data-date="new Date()" data-date-format="yyyy-mm-dd">
                                    <input type="text" class="form-control datepicker" id="fromDate" name="fromDate" value="${fromDate}">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label for="pwd">To Date:</label>
                                <div class="input-group date" data-provide="datepicker" data-date-auto-close="true" data-date="new Date()" data-date-format="yyyy-mm-dd">
                                    <input type="text" class="form-control" id="toDate" name="toDate" value="${toDate}">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" id="btnSubmit" class="btn btn-primary">Run Report</button>
                </form>                
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Order ID</th>
                                        <th>Trans ID</th>
                                        <th>Sender</th>
                                        <th>Receiver</th>
                                        <th>Phone</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th style="text-align: center;">Status Date</th>
                                        <th>Message</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="transNum" value="0"/>
                                    <c:set var="customerPurchaseVnd" value="0"/>
                                    <c:set var="customerPurchaseUsd" value="0"/>
                                    <c:forEach items="${topUps.content}" var="t" varStatus="theCount">
                                        <c:set var="transNum" value="${theCount.count}"/>
                                        <c:set var="customerPurchaseVnd" value="${customerPurchaseVnd + t.amount}"/>
                                        <c:set var="customerPurchaseUsd" value="${customerPurchaseUsd + t.amountUsd}"/>
                                        <tr id="rowTopUp${t.id}">
                                            <td>${t.id}</td>
                                            <td nowrap style="text-align:center;">
                                                <a href="<c:url value="/Administration/Orders/detail/${t.order.id}"/>">
                                                    ${t.order.invoice.invoiceCode}
                                                </a>
                                                <br/>
                                                1 USD = ${t.order.lxExchangeRate.buy} VND
                                            </td>
                                            <td>${t.order.invoice.netTransId}<br/>(${t.order.invoice.translatedStatus})</td>
                                            <td>${t.order.sender.fullName}<br/><a href='<c:url value="/Administration/SystemSender/detail/${t.order.sender.id}"/>'>${t.order.sender.beautyId}</a></td>
                                            <td>${t.recipient.fullName}<br/><a href="javascript:viewRecipient(${t.recipient.id});">${t.recipient.beautyId}</a></td>
                                            <td>${t.phone}</td>
                                            <td style="text-align: center;">
                                                VND <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/>
                                                <br/>
                                                USD <fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/>
                                            </td>
                                            <td id="status${t.id}">
                                                <c:choose>
                                                    <c:when test="${t.status eq UN_SUBMITTED}">
                                                        Not Sent
                                                    </c:when>
                                                    <c:when test="${t.status eq COMPLETED}">
                                                        Success sent
                                                    </c:when>
                                                    <c:when test="${t.status eq CANCELED}">
                                                        Canceled
                                                    </c:when>
                                                </c:choose>                                                
                                            </td>
                                            <td id="statusDate${t.id}" style="text-align: center;">
                                                <fmt:formatDate value="${t.modifiedDate}" pattern="MM/dd/yyyy"/>
                                                <br/>
                                                <fmt:formatDate value="${t.modifiedDate}" pattern="HH:mm:ss"/>
                                            </td>
                                            <td id="vtcMessage${t.id}">${t.responseMessage}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="10">
                                            <%-- Paging --%>
                                            <nav>
                                                <ul class="pagination pull-right">
                                                    <c:forEach begin="1" end="${topUps.totalPages}" var="i">
                                                        <c:choose>
                                                            <c:when test="${(i - 1) == topUps.number}">
                                                                <li class="active">
                                                                    <a href="javascript:void(0)">${i}</a>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li>
                                                                    <a href="javascript:jump(${i}, 50);">${i}</a>
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
                            <td>Count</td>
                            <td style="text-align: right;">${transNum}</td>
                            <td>Transactions</td>
                        </tr>
                        <tr>
                            <td>Customer Purchase</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${customerPurchaseVnd}" pattern="###,###.##"/></td>
                            <td>VND</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="text-align: right;"><fmt:formatNumber value="${customerPurchaseUsd}" pattern="###,###.##"/></td>
                            <td>USD</td>
                        </tr>
                        <%-- Sent status --%>
                        <c:if test="${status eq '1'}">
                        <tr>
                            <td>Paid to VTC</td>
                            <td style="text-align: right;">
                                <c:set var="paidToVTCVnd" value="${(customerPurchaseVnd * 95.0)/100.0}"/>
                                <c:set var="paidToVTCUsd" value="${(customerPurchaseUsd * 95.0)/100.0}"/>
                                <fmt:formatNumber value="${paidToVTCVnd}" pattern="###,###.##"/>
                            </td>
                            <td>VND (95%)</td>
                        </tr>
                        <tr>
                            <td>Profit</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${customerPurchaseVnd - paidToVTCVnd}" pattern="###,###.##"/></td>
                            <td>VND</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td style="text-align: right;"><fmt:formatNumber value="${customerPurchaseUsd - paidToVTCUsd}" pattern="###,###.##"/></td>
                            <td>USD</td>
                        </tr>
                        </c:if>
                        <tr>
                            <td nowrap>Current FX Rate<%--<br/>(${VCB.time})--%></td>
                            <%--
                            <c:if test="${not empty VCB}">
                                <c:set var="currentFX" value="0"/>
                                <c:forEach items="${VCB.exrates}" var="ex">
                                <c:if test="${ex.code == 'USD'}">
                                    <c:set var="currentFX" value="${ex.buy}"/>
                                </c:if>
                                </c:forEach>
                            </c:if>
                            --%>
                            <td nowrap style="text-align: right;">1 USD = <fmt:formatNumber value="${currentFX}" pattern="###,###.##"/></td>
                            <td>VND</td>
                        </tr>
                    </tbody>
                </table>
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
