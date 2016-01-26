<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Top Up">
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/bootstrap-datepicker3.min.css"/>">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">

            function cancel(id) {
                overlayOn($('#rowTopUp' + id));
                $("#topUpForm input[name=id]").val(id);

                $.ajax(
                        {
                            url: '<c:url value="/Administration/SystemTopUp/cancel"/>',
                            type: "POST",
                            data: $('#topUpForm').serializeArray(),
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR)
                            {
                                //data: return data from server
                                if (data.error === '0') {

                                    $('#status' + id).html('Canceled');
                                    $('#statusDate' + id).html(data.statusDate);
                                }
                                else {
                                    alert('There is something wrong ! Please try again !');
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

            function check(id) {
                overlayOn($('#rowTopUp' + id));
                $("#topUpForm input[name=id]").val(id);
                $.ajax(
                        {
                            url: '<c:url value="/Administration/SystemTopUp/check"/>',
                            type: "POST",
                            data: $('#topUpForm').serializeArray(),
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR)
                            {
                                //data: return data from server
                                if (data.error === '0') {

                                    if (data.status === 'In Progress' || data.status === 'Processed') {
                                        if (confirm('This transaction ' + data.orderId + ' is in ' + data.status + '. Are you sure want to Cancel this top up ?')) {

                                            cancel(id);
                                        }
                                    }
                                    else {
                                        cancel(id);
                                    }
                                }
                                else {
                                    alert('There is something wrong ! Please try again !');
                                    overlayOff();
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown)
                            {
                                //if fails  
                                overlayOff();
                            }
                        });
            }
            function sent(id) {
                overlayOn($('#rowTopUp' + id));
                $("#topUpForm input[name=id]").val(id);
                $.ajax(
                        {
                            url: '<c:url value="/Administration/SystemTopUp/send"/>',
                            type: "POST",
                            data: $('#topUpForm').serializeArray(),
                            dataType: 'json',
                            success: function (data, textStatus, jqXHR)
                            {
                                //data: return data from server
                                if (data.error === '1') {

                                    if (data.status === 'Declined' || data.status === 'Refunded') {
                                        alert('Can not sent this top up of order Id ' + data.orderId + '. The transaction is in ' + data.status)
                                    }
                                    else {
                                        alert(data.vtcMessage);
                                        $('#vtcMessage' + id).html(data.vtcMessage);
                                    }
                                }
                                else {
                                    $('#status' + id).html('Sent');
                                    $('#statusDate' + id).html(data.statusDate);
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
            jQuery(document).ready(function () {
                var url = '';
                var fields = {id: 0};
                var form = $('<form id="topUpForm" method="post"></form>')
                        .attr({action: url, style: 'display: none;'});
                for (var key in fields) {
                    if (fields.hasOwnProperty(key))
                        form.append($('<input type="hidden">').attr({
                            name: key, value: fields[key]
                        }));
                }
                form.append($('<input type="hidden">').attr({
                    name: '${_csrf.parameterName}', value: '${_csrf.token}'
                }));
                $('body').append(form);

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

                    if (fromDate > toDate) {

                        alert('The value of from date must be smaller or equal end date');
                        $('#fromDate').focus();
                        return false;
                    }

                    return true;
                });
            });
            
            function jump(page, size){
                $('#paging.page').val(page);
                $('#paging.size').val(size);
                
                $('#reportForm').submit();
            }
        </script>
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-datepicker.min.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemTopUp/report"/>">Top Up Reports</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Top Up Reports</h2>
        <div class="row">
            <div class="col-md-12">
                <form role="form" id="reportForm" action="<c:url value="/Administration/SystemTopUp/report"/>" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="paging.page"  id="paging.page" value="${pagingPage}"/>
                    <input type="hidden" name="paging.size"  id="paging.size" value="${pagingSize}"/>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="email">TopUp's Status:</label>
                                <select class="form-control" id="status" name="status">
                                    <option value="">Please select status</option>
                                    <option value="-1" <c:if test="${status eq '-1'}">selected=""</c:if>>Sent failed</option>
                                    <option value="0" <c:if test="${status eq '0'}">selected=""</c:if>>Not yet send</option>
                                    <option value="1" <c:if test="${status eq '1'}">selected=""</c:if>>Sent</option>
                                    <option value="2" <c:if test="${status eq '2'}">selected=""</c:if>>Canceled</option>
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
                                <div class="input-group date" data-provide="datepicker" data-date-auto-close="true" data-date-end-date="new Date()" data-date="new Date()" data-date-format="yyyy-mm-dd">
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
                                        <th>Receiver</th>
                                        <th>Phone</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th style="text-align: center;">Status Date</th>
                                        <th>Message</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${topUps.content}" var="t">
                                        <tr id="rowTopUp${t.id}">
                                            <td>${t.id}</td>
                                            <td>${t.order.invoice.invoiceCode}</td>
                                            <td>${t.order.invoice.netTransId}</td>
                                            <td>${t.recipient.fullName}</td>
                                            <td>${t.phone}</td>
                                            <td style="text-align: center;">
                                                VND <fmt:formatNumber value="${t.amount}" pattern="###,###.##"/>
                                                <br/>
                                                USD <fmt:formatNumber value="${t.amountUsd}" pattern="###,###.##"/>
                                            </td>
                                            <td id="status${t.id}">
                                                <c:choose>
                                                    <c:when test="${t.isSubmitted eq 0}">
                                                        Not Sent
                                                    </c:when>
                                                    <c:when test="${t.isSubmitted eq -1}">
                                                        Sent Failed
                                                    </c:when>
                                                    <c:when test="${t.isSubmitted eq 1}">
                                                        Sent
                                                    </c:when>
                                                    <c:when test="${t.isSubmitted eq 2}">
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
                                        <td colspan="9">
                                            <%-- Paging --%>
                                            <nav>
                                                <ul class="pagination pull-right">
                                                    <c:forEach begin="1" end="${issues.totalPages}" var="i">
                                                        <c:choose>
                                                            <c:when test="${(i - 1) == issues.number}">
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

    </jsp:body>
</template:Admin>
