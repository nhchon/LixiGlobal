<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Top Up">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            
            function cancel(id){
                overlayOn($('#rowTopUp'+id));
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
                            
                            $('#status'+id).html('Canceled');
                            $('#statusDate'+id).html(data.statusDate);
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
            
            function check(id){
                overlayOn($('#rowTopUp'+id));
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
                            
                            if(data.status === 'In Progress' || data.status === 'Processed'){
                                if(confirm('This transaction ' + data.orderId + ' is in ' + data.status + '. Are you sure want to Cancel this top up ?')){
                                    
                                    cancel(id);
                                }
                            }
                            else{
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
            
            function sent(id){
                overlayOn($('#rowTopUp'+id));
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
                            
                            if(data.status === 'Declined' || data.status === 'Refunded'){
                                alert('Can not sent this top up of order Id '+ data.orderId+'. The transaction is in ' + data.status)
                            }
                            else{
                                alert(data.vtcMessage);
                                $('#vtcMessage'+id).html(data.vtcMessage);
                            }
                        }
                        else {
                            $('#status'+id).html('Sent');
                            $('#statusDate'+id).html(data.statusDate);
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
                var fields = {id:0};
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
            });
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemTopUp/list"/>">Top Up Mobile List</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Top Up Mobile List</h2>
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
                                        <th nowrap>Order ID</th>
                                        <th nowrap>Trans ID</th>
                                        <th nowrap>Modified Date</th>
                                        <th>Receiver</th>
                                        <th>Phone</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th nowrap>Sent Date</th>
                                        <th>Message</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${topUps}" var="t">
                                        <tr id="rowTopUp${t.id}">
                                            <td>${t.id}</td>
                                            <td>${t.order.invoice.invoiceCode}</td>
                                            <td>${t.order.invoice.netTransId}</td>
                                            <td style="text-align: center;">
                                                <fmt:formatDate pattern="yyyy-MM-dd" value="${t.modifiedDate}"/>
                                                <br/>
                                                <fmt:formatDate pattern="HH-mm" value="${t.modifiedDate}"/>
                                            </td>
                                            <td>${t.recipient.fullName}</td>
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
                                                        Completed
                                                    </c:when>
                                                    <c:when test="${t.status eq CANCELED}">
                                                        Canceled
                                                    </c:when>
                                                </c:choose>                                                
                                            </td>
                                            <td id="statusDate${t.id}">
                                            </td>
                                            <td id="vtcMessage${t.id}">${t.responseMessage}</td>
                                            <td style="text-align: right;" nowrap>
                                                <button class="btn btn-primary" onclick="sent(${t.id})">Send</button>
                                                <button class="btn btn-warning" onclick="check(${t.id})">Cancel</button>
                                            </td>
                                        </tr>
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
