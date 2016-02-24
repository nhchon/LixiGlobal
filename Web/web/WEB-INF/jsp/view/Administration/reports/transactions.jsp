<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
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

                    if ((fromDate !== '' && toDate !== '') && (fromDate > toDate)) {

                        alert('The value of from date must be smaller or equal end date');
                        $('#fromDate').focus();
                        return false;
                    }

                    return true;
                });
                
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
        <%-- EnumLixiOrderStatus.java --%>
        <c:set var="UNFINISHED" value="-9"/>
        <c:set var="NOT_YET_SUBMITTED" value="-8"/>
        <c:set var="SENT_INFO" value="-7"/>
        <c:set var="SENT_MONEY" value="-6"/>
        <c:set var="PROCESSING" value="0"/>
        <c:set var="COMPLETED" value="1"/>
        <c:set var="CANCELED" value="2"/>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/Orders/report"/>">Transaction Report</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Transaction Report</h2>
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
                                    <option value="Processed" <c:if test="${searchForm.status eq 'Processed'}">selected=""</c:if>>Processed</option>
                                    <option value="Completed" <c:if test="${searchForm.status eq 'Completed'}">selected=""</c:if>>Completed</option>
                                    <option value="Cancelled" <c:if test="${searchForm.status eq 'Cancelled'}">selected=""</c:if>>Cancelled</option>
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
        <c:set var="transferPercent" value="95"/>
        <c:if test="${not empty sessionScope['scopedTarget.loginedUser'].configs['LIXI_BAOKIM_TRANFER_PERCENT']}">
            <c:set var="transferPercent" value="${sessionScope['scopedTarget.loginedUser'].configs['LIXI_BAOKIM_TRANFER_PERCENT']}"/>
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
                                        <th nowrap>Transaction No</th><%-- 3 --%>
                                        <th nowrap>Option</th><%-- 4 --%>
                                        <th>Sender</th><%-- 5 --%>
                                        <th style="text-align: center;">Receiver(s)</th><%-- 6 --%>
                                        <th style="text-align: right;">Amount</th><%-- 7 --%>
                                        <th style="text-align: center;">Last Modified Date</th><%-- 8 --%>
                                        <c:if test="${searchForm.status eq 'All' or searchForm.status eq 'Processed'}">
                                        <th style="text-align: right;">Action</th><%-- 9 --%>    
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
                                            <td style="text-align: center;">
                                                <fmt:formatDate pattern="MM/dd/yyyy" value="${m.key.modifiedDate}"/><br/><fmt:formatDate pattern="HH:mm:ss" value="${m.key.modifiedDate}"/>
                                            </td>
                                            <c:if test="${searchForm.status eq 'All' or searchForm.status eq 'Processed'}">
                                            <td style="text-align: right;">
                                                <c:if test="${m.key.lixiStatus eq SENT_MONEY}">
                                                    <a href="javascript:cancel(${m.key.id});">Cancel</a>
                                                </c:if>
                                            </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <c:set var="colSpan" value="8"/>
                                    <c:if test="${searchForm.status eq 'All' or searchForm.status eq 'Processed'}">
                                        <c:set var="colSpan" value="9"/>
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
