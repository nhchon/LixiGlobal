<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/bootstrap-datepicker3.min.css"/>">
        <style type="text/css">
            .popover{
                max-width:650px;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixi-global/js/recipient.js"/>"></script>
        <script type="text/javascript">
            var SOMETHING_WRONG_ERROR = '<spring:message code="validate.there_is_something_wrong"/>';
            
            jQuery(document).ready(function () {
                $(function(){
                    $('[rel="popover"]').popover({
                        container: 'body',
                        html: true,
                        placement:'left',
                        title : 'Details <a href="#" class="close" data-dismiss="alert">&times;</a>',
                        content: function () {
                            var clone = $($(this).data('popover-content')).clone(true).css("display", "block");//removeClass('hide');
                            return clone;
                        }
                    }).click(function(e) {
                        e.preventDefault();
                    });
                    $(document).on("click", ".popover .close" , function(e){
                        $(this).parents(".popover").popover('hide');
                    });
                });
                
                $('#btnSubmit').click(function () {

                    if ($('#status').val() === '') {

                        alert('Please select the status');
                        $('#status').focus();

                        return false;
                    }

                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();

                    if ((fromDate !== '' && toDate !== '') && (fromDate > toDate)) {

                        alert('The value of from date must be smaller or equal end date');
                        $('#fromDate').focus();
                        return false;
                    }

                    return true;
                });
            });

            function reSendOrder(id){
                if(confirm('Are you sure want to re-send this order?')){
                overlayOn($('#rowO' + id));
                $.ajax(
                {
                    url: '<c:url value="/Administration/Orders/reSendOrder/"/>' + id,
                    type: "GET",
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        $('#status' + id).html(data);

                        if (data.error === '0') {
                            alert('Re-Send the Order success');
                        }
                        else{
                            alert('Re-Send the Order failed');
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
            }
            
            function cancel(id){
                
                if(confirm('Are you sure want to CANCEL this order id '+ id + ' ???')){
                    
                    document.location.href = '<c:url value="/Administration/Orders/cancel/"/>' + id + '/report';
                }
            }
            
            function viewRecipient(id) {
                $.get('<c:url value="/Administration/SystemRecipient/edit/"/>' + id, function (data) {
                    enableEditRecipientHtmlContent(data);
                });
            }
            
            function enableEditRecipientHtmlContent(data) {

                $('#editRecipientContent').html(data);
                $('#editRecipientModal').modal({show: true});

                // handler submit form
                //callback handler for form submit
                $("#chooseRecipientForm").submit(function (e)
                {
                    //alert('hi');
                    var postData = $(this).serializeArray();
                    var formURL = $(this).attr("action");
                    $.ajax(
                    {
                        url: formURL,
                        type: "POST",
                        data: postData,
                        dataType: 'json',
                        success: function (data, textStatus, jqXHR)
                        {
                            //data: return data from server
                            if (data.error === '0') {
                                var recId = $("#chooseRecipientForm #recId").val();
                                var name = $("#chooseRecipientForm #firstName").val() + " " + $("#chooseRecipientForm #middleName").val() + " " + $("#chooseRecipientForm #lastName").val();
                                if(recId > 0){
                                    $('#rec'+recId).html(name);
                                }
                                // hide popup
                                $('#editRecipientModal').modal('hide');
                            }
                            else {
                                alert(SOMETHING_WRONG_ERROR);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown)
                        {
                            //if fails      
                        }
                    });
                    if (typeof e !== 'undefined') {
                        e.preventDefault(); //STOP default action
                        //e.unbind(); //unbind. to stop multiple form submit.
                    }
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
            
        </script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.maskedinput.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-datepicker.min.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/report"/>">Transaction Report</a></li>
        </ul>

        <!-- main -->
        <div class="row">
            <div class="col-md-9"><h2 class="sub-header">Transaction Report</h2></div>
            <div class="col-md-3">
                <div class="row" id="rowBaoKimStatus">
                    <div class="col-md-6" style="padding-right: 0px;"></div>
                    <div class="col-md-6" style="padding-right: 0px;text-align: center;">
                        <div class="btn-group" id="toggle_event_editing">
                            <button id="btnOff" type="button" class="btn btn-default disabled">OFF</button>
                            <button id="btnOn" type="button" class="btn btn-info disabled">ON</button>
                        </div>
                        <p style="margin-top: 10px;"><a href="javascript:checkBaoKimStatus();">BaoKim System Status</a></p>
                    </div>
                </div>
            </div>
        </div>        
        <div class="row">
            <div class="col-md-12">
                <form:form modelAttribute="searchForm" method="get">
                    <input type="hidden" name="search" value="true" />
                    <input type="hidden" name="paging.page"  id="paging.page" value="1"/>
                    <input type="hidden" name="paging.size"  id="paging.size" value="50"/>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="status">Order ID:</label>
                                <form:input type="number" class="form-control" path="orderId"/>
                                <div class="help-block">just number, no need 000 ... </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="status">Transaction Status:</label>
                                <form:select class="form-control" path="status">
                                    <option value="">Please select status</option>
                                    <option value="All" <c:if test="${searchForm.status eq 'All'}">selected=""</c:if>>All</option>
                                    <option value="${PROCESSED}" <c:if test="${searchForm.status eq PROCESSED}">selected=""</c:if>>Processed</option>
                                    <option value="${COMPLETED}" <c:if test="${searchForm.status eq COMPLETED}">selected=""</c:if>>Completed</option>
                                    <option value="${CANCELED}" <c:if test="${searchForm.status eq CANCELED}">selected=""</c:if>>Cancelled</option>
                                </form:select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="fromDate">From Date:</label>
                                <div class="input-group date" data-provide="datepicker" data-date-auto-close="true"  data-date-end-date="new Date()" data-date="new Date()" data-date-format="yyyy-mm-dd">
                                    <form:input type="text" class="form-control datepicker" path="fromDate" value="${fromDate}"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label for="toDate">To Date:</label>
                                <div class="input-group date" data-provide="datepicker" data-date-auto-close="true" data-date="new Date()" data-date-format="yyyy-mm-dd">
                                    <form:input type="text" class="form-control" path="toDate" value="${toDate}"/>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" id="btnSubmit" class="btn btn-primary">Run Report</button>
                    <p class="help-block">Gift Margin(*): For ONLY Allow Refund Orders, but Gifted by each user</p>
                </form:form>                
            </div>
        </div>
        
        <c:url value="/Administration/Orders/report" var="postOrderReport"/>
        
        <security:authentication property="principal.configs['LIXI_BAOKIM_TRANFER_PERCENT']" var="transferPercent" />
        <c:if test="${empty transferPercent}">
            <c:set var="transferPercent" value="95"/>
        </c:if>
        
        <form action="${postOrderReport}" method="post" onsubmit="return checkForm()">
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
                                        <th nowrap style="text-align:center;">Order</th><%-- 2 --%>
                                        <th nowrap style="text-align:center;">Transaction No</th><%-- 3 --%>
                                        <th nowrap>Option</th><%-- 4 --%>
                                        <th>Sender</th><%-- 5 --%>
                                        <th style="text-align: center;">Receiver(s)</th><%-- 6 --%>
                                        <th style="text-align: right;" nowrap>Amount<br/>(incl. shipping)</th><%-- 7 --%>
                                        <th nowrap style="text-align:right;" title="For Allow Refund Orders, but Gifted by user">G. Margin(*)</th>
                                        <th style="text-align: center;">Status</th><%-- 8 --%>
                                        <th style="text-align: center;">Last Modified Date</th><%-- 9 --%>
                                        <c:if test="${searchForm.status eq 'All' or searchForm.status eq PROCESSED}">
                                        <th style="text-align: right;">Action</th><%-- 10 --%>    
                                        </c:if>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="countRec" value="0"/>
                                    <c:set var="totalAmountVnd" value="0"/>
                                    <c:set var="totalAmountUsd" value="0"/>
                                    <c:forEach items="${mOs}" var="m" varStatus="theCount">
                                        <c:set var="totalGiftMargin" value="0"/>
                                        <c:set var="countRec" value="${theCount.count}"/>
                                        <tr id="rowO${m.key.id}">
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.createdDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.createdDate}"/>
                                            </td>
                                            <td nowrap style="text-align:center;"><a href="<c:url value="/Administration/Orders/detail/${m.key.id}"/>">
                                                    ${m.key.invoice.invoiceCode}
                                                </a>
                                                <br/>
                                                1 USD = ${m.key.lxExchangeRate.buy} VND
                                            </td>
                                            <td style="text-align:center;">
                                                ${m.key.invoice.netTransId}<br/>(${m.key.invoice.translatedStatus})</td>
                                            <td nowrap>
                                                <c:if test="${m.key.setting eq 0}">
                                                    Gift Only
                                                </c:if>
                                                <c:if test="${m.key.setting eq 1}">
                                                    Allow Refund
                                                </c:if>
                                            </td>
                                            <td>${m.key.sender.fullName}<br/><a href='<c:url value="/Administration/SystemSender/detail/${m.key.sender.id}"/>'>${m.key.sender.beautyId}</a></td>
                                            <td style="text-align: center;" nowrap>
                                                <c:forEach items="${m.value}" var="rio" varStatus="theValueCount">
                                                    <c:if test="${not empty rio.gifts}">
                                                    <span id="rec${rio.recipient.id}">${rio.recipient.fullName}</span><br/><a href="javascript:viewRecipient(${rio.recipient.id});">${rio.recipient.beautyId}</a><br/>
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td style="text-align: right;" nowrap>
                                                <c:forEach items="${m.value}" var="rio">
                                                    <c:if test="${not empty rio.gifts}">
                                                        <c:set var="totalGiftMargin" value="${totalGiftMargin + rio.giftMargin}"/>
                                                        <fmt:formatNumber value="${rio.giftTotal.usd + rio.shippingChargeAmount}" pattern="###,###.##"/> USD<br/>
                                                        <fmt:formatNumber value="${rio.giftTotal.vnd + (rio.shippingChargeAmount * m.key.lxExchangeRate.buy)}" pattern="###,###.##"/> VND<br/>
                                                        <c:set var="totalAmountVnd" value="${totalAmountVnd + rio.giftTotal.vnd}"/>
                                                        <c:set var="totalAmountUsd" value="${totalAmountUsd + rio.giftTotal.usd}"/>
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td id="giftMargin${m.key.id}" style="text-align:right;"></td>
                                            <td style="text-align: center;">
                                                <a href="#" data-placement="left" rel="popover" data-popover-content="#detailStatusOrder${m.key.id}">
                                                    <c:choose>
                                                        <c:when test="${m.key.lixiStatus eq PROCESSING}">
                                                            Processing<br/>
                                                            <c:if test="${m.key.lixiSubStatus eq SENT_MONEY}">(Sent Money Info)</c:if>
                                                            <c:if test="${m.key.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                                        </c:when>
                                                        <c:when test="${m.key.lixiStatus eq COMPLETED}">
                                                            Completed
                                                        </c:when>
                                                        <c:when test="${m.key.lixiStatus eq CANCELED}">
                                                            Cancelled
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${m.key.lixiStatus}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>    
                                                <%@include  file="/WEB-INF/jsp/view/Administration/reports/detailStatusOrder.jsp" %>
                                            </td>
                                            <td style="text-align: center;">
                                                <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.modifiedDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.modifiedDate}"/>
                                            </td>
                                            <c:if test="${searchForm.status eq 'All' or searchForm.status eq PROCESSED}">
                                            <td style="text-align: right;">
                                                <c:if test="${m.key.lixiStatus eq PROCESSED}">
                                                    <a href="javascript:reSendOrder(${m.key.id});">Re-Send</a> | 
                                                </c:if>
                                                <c:if test="${m.key.lixiStatus eq PROCESSED and (m.key.lixiSubStatus eq SENT_MONEY or m.key.lixiSubStatus eq SENT_INFO)}">
                                                    <a href="javascript:cancel(${m.key.id});">Cancel</a>
                                                </c:if>
                                            </td>
                                            </c:if>
                                        </tr>
                                        <script>document.getElementById('giftMargin${m.key.id}').innerHTML='<fmt:formatNumber value="${totalGiftMargin}" pattern="###,###.##"/> VND';</script>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <c:set var="colSpan" value="10"/>
                                    <c:if test="${searchForm.status eq 'All' or searchForm.status eq 'Processed'}">
                                        <c:set var="colSpan" value="11"/>
                                    </c:if>
                                    <tr>
                                        <td colspan="${colSpan}">
                                            <%-- Paging --%>
                                            <nav>
                                                <ul class="pagination pull-right">
                                                    <c:forEach begin="1" end="${results.totalPages}" var="i">
                                                        <c:choose>
                                                            <c:when test="${(i - 1) == results.number}">
                                                                <li class="active">
                                                                    <a href="javascript:void(0)">${i}</a>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li>
                                                                    <a href="javascript:void(0);" onclick="searchForm.elements['paging.page'].value = '${i}'; searchForm.submit();">${i}</a>
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
        </form>
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
