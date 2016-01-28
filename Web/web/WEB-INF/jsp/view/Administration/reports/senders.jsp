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

                        //return false;
                    }

                    document.location.href = '<c:url value="/Administration/SystemSender/report/"/>' + $('#status').val();
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
            <li><a href="<c:url value="/Administration/SystemSender/report"/>">Sender Reports</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Sender Reports</h2>
        <div class="row">
            <div class="col-md-12">
                <form role="form" id="reportForm" action="<c:url value="/Administration/SystemSender/report"/>" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="paging.page"  id="paging.page" value="${pagingPage}"/>
                    <input type="hidden" name="paging.size"  id="paging.size" value="${pagingSize}"/>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="email">Sender's Status:</label>
                                <select class="form-control" id="status" name="status">
                                    <option value="">Please select status</option>
                                    <option value="1" <c:if test="${status eq '1'}">selected=""</c:if>>Active</option>
                                    <option value="0" <c:if test="${status eq '0'}">selected=""</c:if>>Deactivated</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <button type="button" id="btnSubmit" class="btn btn-primary">Run Report</button>
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
                                        <th>#ID</th>
                                        <th nowrap>Date Created</th>
                                        <th nowrap>Name</th>
                                        <th nowrap>User Name/Phone</th>
                                        <th nowrap>Amount</th>
                                        <th nowrap>Status</th>
                                        <th nowrap>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="countS" value="0"/>
                                    <c:set var="totalAmountUsd" value="0"/>
                                    <c:forEach items="${rS}" var="s" varStatus="theCount">
                                        <c:set var="countS" value="${theCount.count}"/>
                                        <c:set var="totalAmountUsd" value="${totalAmountUsd + s.sumAll}"/>
                                        <tr>
                                            <td>${s.beautyId}</td>
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${s.createdDate}"/></td>
                                            <td>${s.fullName}</td>
                                            <td>
                                                ${s.email}<br/>${s.phone}
                                            </td>
                                            <td><fmt:formatNumber value="${s.sumAll}" pattern="###,###.##"/> USD</td>
                                            <td nowrap>
                                                <c:if test="${s.activated eq true}">
                                                    Active
                                                </c:if>
                                                <c:if test="${s.activated eq false}">
                                                    Deactivated
                                                </c:if>
                                            </td>
                                            <td>
                                                <a href="javascript:alert('In Implementation');">On</a>
                                                |
                                                <a href="javascript:alert('In Implementation');">Off</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="7">
                                            <%-- Paging --%>
                                            <nav>
                                                <ul class="pagination pull-right">
                                                    <c:forEach begin="1" end="${pRs.totalPages}" var="i">
                                                        <c:choose>
                                                            <c:when test="${(i - 1) == pRs.number}">
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
                            <td style="text-align: right;">${countS}</td>
                            <td nowrap>
                                <c:if test="${status eq 1}">
                                    Active Users
                                </c:if>
                                <c:if test="${status eq 0}">
                                    Deactivated Users
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td>Total Amount:</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${totalAmountUsd}" pattern="###,###.##"/></td>
                            <td>USD</td>
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
    </jsp:body>
</template:Admin>