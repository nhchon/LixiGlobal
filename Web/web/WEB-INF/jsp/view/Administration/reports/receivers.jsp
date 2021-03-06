<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Receiver Reports">
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

                        //return false;
                    }

                    document.location.href = '<c:url value="/Administration/SystemRecipient/report/"/>' + $('#oStatus').val();
                });
            });
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemRecipient/report"/>">Receiver Reports</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Receiver Reports</h2>
        <div class="row">
            <div class="col-md-12">
                <form role="form" id="reportForm" action="<c:url value="/Administration/SystemSender/report"/>" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="paging.page"  id="paging.page" value="1"/>
                    <input type="hidden" name="paging.size"  id="paging.size" value="50"/>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="email">Order's Status:</label>
                                <select class="form-control" id="oStatus" name="oStatus">
                                    <option value="">Please select status</option>
                                    <option value="In Progress" <c:if test="${oStatus eq 'In Progress'}">selected=""</c:if>>In Progress</option>
                                    <option value="Declined" <c:if test="${oStatus eq 'Declined'}">selected=""</c:if>>Declined</option>
                                    <option value="Refunded" <c:if test="${oStatus eq 'Refunded'}">selected=""</c:if>>Refunded</option>
                                    <option value="0" <c:if test="${oStatus eq '0'}">selected=""</c:if>>Processed</option>
                                    <option value="1" <c:if test="${oStatus eq '1'}">selected=""</c:if>>Completed</option>
                                    <option value="2" <c:if test="${oStatus eq '2'}">selected=""</c:if>>Cancelled</option>
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
                                        <th nowrap>Sender</th>
                                        <th nowrap>Receiver</th>
                                        <th>Email/Phone</th>
                                        <th style="text-align: right;">Amount</th>
                                        <th nowrap style="text-align: right;">No. of Transac</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="countRec" value="0"/>
                                    <c:set var="totalAmountVnd" value="0"/>
                                    <c:forEach items="${rS}" var="r" varStatus="theCount">
                                        <c:set var="countRec" value="${theCount.count}"/>
                                        <c:set var="totalAmountVnd" value="${totalAmountVnd + r.sumAll}"/>
                                        <tr>
                                            <td>${r.beautyId}</td>
                                            <td><fmt:formatDate pattern="MM/dd/yyyy" value="${r.modifiedDate}"/></td>
                                            <td>${r.sender.fullName}</td>
                                            <td>
                                                ${r.fullName}
                                            </td>
                                            <td>${r.email}<br/>${r.phone}</td>
                                            <td nowrap style="text-align: right;"><fmt:formatNumber value="${r.sumAll}" pattern="###,###.##"/> VND</td>
                                            <td style="text-align: right;"></td>
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
                                                                    <a href="<c:url value="/Administration/SystemRecipient/report">
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
                            <td>Total Amount:</td>
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
                                            
    </jsp:body>
</template:Admin>
