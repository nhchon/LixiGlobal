<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/bootstrap-datepicker3.min.css"/>">
        <style type="text/css">
            .popover{
                max-width:600px;
            }
        </style>
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            
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
                <%--
                <c:if test="${empty results}">$('#searchForm').submit();</c:if>
                --%>
                
            });

            function cancel(id){
                
                if(confirm('Are you sure want to CANCEL this order id '+ id + ' ???')){
                    
                    document.location.href = '<c:url value="/Administration/Orders/cancel/"/>' + id + '/report';
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
            
        </script>    
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
                    <%--
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="firstName">Sender's First Name:</label>
                                <form:input class="form-control" path="firstName"/>
                            </div>
                            <div class="col-md-4">
                                <label for="lastName">Last Name:</label>
                                <form:input type="text" class="form-control" path="lastName"/>
                            </div>
                            <div class="col-md-4">
                                <label for="email">Email:</label>
                                <form:input type="text" class="form-control" path="email"/>
                            </div>
                        </div>
                    </div>
                    --%>
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
                                        <th style="text-align: right;">Amount</th><%-- 7 --%>
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
                                            <td style="text-align:center;">${m.key.invoice.netTransId}<br/>(${m.key.invoice.translatedStatus})</td>
                                            <td nowrap>
                                                <c:if test="${m.key.setting eq 0}">
                                                    Gift Only
                                                </c:if>
                                                <c:if test="${m.key.setting eq 1}">
                                                    Allow Refund
                                                </c:if>
                                            </td>
                                            <td>${m.key.sender.fullName}<br/><a href='<c:url value="/Administration/SystemSender/detail/${m.key.sender.id}"/>'>${m.key.sender.beautyId}</a></td>
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
                                            <td style="text-align: center;">
                                                <a href="#" data-placement="left" rel="popover" data-popover-content="#detailStatusOrder${m.key.id}">
                                                <c:if test="${m.key.lixiStatus eq PROCESSING}">
                                                    Processing<br/>
                                                    <c:if test="${m.key.lixiSubStatus eq SENT_MONEY}">(Sent Money Info)</c:if>
                                                    <c:if test="${m.key.lixiSubStatus eq SENT_INFO}">(Sent Info)</c:if>
                                                </c:if>
                                                <c:if test="${m.key.lixiStatus eq COMPLETED}">
                                                    Completed
                                                </c:if>
                                                <c:if test="${m.key.lixiStatus eq CANCELED}">
                                                    Cancelled
                                                </c:if>
                                                </a>    
                                                <div id="detailStatusOrder${m.key.id}" style="display:none;" class="table-responsive">
                                                    <table class="table table-hover table-responsive table-striped" style="font-size: 12px;">
                                                        <thead>
                                                            <tr>
                                                                <th nowrap>Receiver</th><%-- 1 --%>
                                                                <th nowrap>Item</th><%-- 2 --%>
                                                                <th nowrap>Description</th><%-- 3 --%>
                                                                <th style="text-align:right;">Status</th><%-- 4 --%>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${m.value}" var="rio" varStatus="theCount">
                                                                <tr>
                                                                    <td  colspan="4" nowrap>${rio.recipient.fullName}</td>
                                                                </tr>
                                                                <c:forEach items="${rio.gifts}" var="g" varStatus="theCount2">
                                                                    <tr>
                                                                        <td># ${g.id}</td>
                                                                        <td>${g.productQuantity}</td>
                                                                        <td>${g.productName}</td>
                                                                        <td style="text-align:right;">
                                                                            <c:choose>
                                                                                <c:when test="${g.bkStatus eq '0'}">
                                                                                    <span class="alert-danger">Processing</span>
                                                                                </c:when>
                                                                                <c:when test="${g.bkStatus eq '1'}">
                                                                                    <span class="alert-danger">Completed</span>
                                                                                </c:when>
                                                                                <c:when test="${g.bkStatus eq '2'}">
                                                                                    <span class="alert-danger">Cancelled</span>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span class="alert-danger">${g.bkStatus}</span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <br/>
                                                                            <br/>
                                                                        </td>
                                                                </tr>
                                                                </c:forEach>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                            <td style="text-align: center;">
                                                <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.modifiedDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.modifiedDate}"/>
                                            </td>
                                            <c:if test="${searchForm.status eq 'All' or searchForm.status eq PROCESSED}">
                                            <td style="text-align: right;">
                                                <c:if test="${m.key.lixiStatus eq PROCESSED and (m.key.lixiSubStatus eq SENT_MONEY or m.key.lixiSubStatus eq SENT_INFO)}">
                                                    <a href="javascript:cancel(${m.key.id});">Cancel</a>
                                                </c:if>
                                            </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <c:set var="colSpan" value="9"/>
                                    <c:if test="${searchForm.status eq 'All' or searchForm.status eq 'Processed'}">
                                        <c:set var="colSpan" value="10"/>
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
                                                                    <a href="javascript:void 0;" onclick="searchForm.elements['paging.page'].value = '${i}'; searchForm.submit();">${i}</a>
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
