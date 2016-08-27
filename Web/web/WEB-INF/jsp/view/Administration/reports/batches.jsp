<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- New Orders">
    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/bootstrap-datepicker3.min.css"/>">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            
            jQuery(document).ready(function () {
                
                // reset value
                $('#status').change(function(){
                    if($(this).value !== 'Other'){
                        $('#fromDate').val('');
                        $('#toDate').val('');
                    }
                });
                
                $('#btnSubmit').click(function () {

                    if ($('#status').val() === '') {

                        alert('Please select the status');
                        $('#status').focus();

                        return false;
                    }

                    var fromDate = $('#fromDate').val();
                    var toDate = $('#toDate').val();
                    if($('#status').val() === 'Other'){
                        
                        if (fromDate === ''){
                            alert('Please input fromDate');
                             $('#fromDate').focus();
                            return false;
                        }
                        
                        if (toDate === ''){
                            alert('Please input toDate');
                            $('#toDate').focus();
                            return false;
                        }
                        
                        if ((fromDate !== '' && toDate !== '') && (fromDate > toDate)) {

                            alert('The value of from date must be smaller or equal end date');
                            $('#fromDate').focus();
                            return false;
                        }
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
        <h2 class="sub-header">Batch Report</h2>
        <div class="row">
            <div class="col-md-12">
                <form:form modelAttribute="searchForm" method="get">
                    <input type="hidden" name="search" value="true" />
                    <input type="hidden" name="paging.page"  id="paging.page" value="1"/>
                    <input type="hidden" name="paging.size"  id="paging.size" value="50"/>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="status">Batch Status:</label>
                                <form:select class="form-control" path="status">
                                    <option value="">Please select status</option>
                                    <option value="Latest" <c:if test="${searchForm.status eq 'Latest'}">selected=""</c:if>>Latest</option>
                                    <option value="Weekly" <c:if test="${searchForm.status eq 'Weekly'}">selected=""</c:if>>Weekly</option>
                                    <option value="Monthly" <c:if test="${searchForm.status eq 'Monthly'}">selected=""</c:if>>Monthly</option>
                                    <option value="Other" <c:if test="${searchForm.status eq 'Other'}">selected=""</c:if>>Other</option>
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
                </form:form>                
            </div>
        </div>
        
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
                                        <th nowrap>#</th><%-- 1 --%>
                                        <th nowrap>File Name</th><%-- 2 --%>
                                        <th nowrap>Date</th><%-- 3 --%>
                                        <th nowrap>Time</th><%-- 4 --%>
                                        <th nowrap style="text-align:right;">Total</th><%-- 5 --%>
                                        <th nowrap style="text-align:right;">Margin</th><%-- 6 --%>
                                        <th nowrap style="text-align:right;">Ship. Charged</th><%-- 7 --%>
                                        <th nowrap style="text-align:right;">Export to Excel</th><%-- 8 --%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${results.content}" var="b" varStatus="theCount">
                                        <tr id="rowO${b.id}">
                                            <td>${b.id}</td>
                                            <td><a href="<c:url value="/Administration/SystemBatch/view/${b.id}"/>">${b.name}</a></td>
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${b.createdDate}"/></td>
                                            <td><fmt:formatDate pattern="HH:mm:ss" value="${b.createdDate}"/>
                                            </td>
                                            <td style="text-align:right;">
                                                <fmt:formatNumber value="${b.sumVnd}" pattern="###,###.##"/> VND<br/>
                                                <fmt:formatNumber value="${b.sumUsd}" pattern="###,###.##"/> USD
                                            </td>
                                            <td style="text-align:right;">
                                                <fmt:formatNumber value="${b.vndMargin}" pattern="###,###.##"/> VND<br/>
                                            </td>
                                            <td style="text-align:right;">
                                                <fmt:formatNumber value="${b.vndShip}" pattern="###,###.##"/> VND<br/>
                                                <fmt:formatNumber value="${b.usdShip}" pattern="###,###.##"/> USD
                                            </td>
                                            <td nowrap style="text-align:right;">
                                                <button type="button" onclick="alert('In Working')" class="btn btn-primary">Export</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="8">
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
        <div class="modal fade" id="editRecipientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content" id="editRecipientContent">
                </div>
            </div>
        </div>
    </jsp:body>
</template:Admin>
