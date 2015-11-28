<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemSupport/management/self"/>">Management List</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Management List</h2>
        <div class="row">
            <div class="col-sm-12">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <li <c:if test="${(action eq 'all') or (empty action)}">class="active"</c:if>>
                        <a href="<c:url value="/Administration/SystemSupport/management/all"/>" role="tab">
                            <i class="fa fa-home"></i> All
                        </a>
                    </li>
                    <li <c:if test="${action eq 'self'}">class="active"</c:if>>
                        <a href="<c:url value="/Administration/SystemSupport/management/self"/>" role="tab">
                            <i class="fa fa-home"></i> Assigned
                        </a>
                    </li>
                    <li <c:if test="${action eq 'resolved'}">class="active"</c:if>>
                        <a href="<c:url value="/Administration/SystemSupport/management/resolved"/>" role="tab">
                            <i class="fa fa-home"></i> Resolved
                        </a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive">
                                <thead>
                                    <tr>
                                        <th nowrap="">#</th>
                                        <th nowrap="">Subject</th>
                                        <th nowrap="">Order ID</th>
                                        <th nowrap="">Contact</th>
                                        <th nowrap="">Created Date</th>
                                        <th nowrap="">Status</th>
                                        <th nowrap="">Handled By</th>
                                        <th nowrap="">Handled Date</th>
                                        <th nowrap="">Assigned By</th>
                                        <th nowrap="">Resolved Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${issues.content}" var="iss">
                                        <tr>
                                            <td>${iss.problem.id}</td>
                                            <td>
                                                <a href="<c:url value="/Administration/SystemSupport/detail/${iss.problem.id}?rl=management"/>">${iss.problem.subject.subject}</a>
                                            </td>
                                            <td>${iss.problem.orderId}</td>
                                            <td>${iss.problem.contactData}</td>
                                            <td>${iss.problem.createdDate}</td>
                                            <td>${iss.problem.status.description}
                                            </td>
                                            <td>
                                                <c:if test="${empty iss.handledBy}">
                                                    <a href="<c:url value="/Administration/SystemSupport/management/handle/${iss.id}"/>">Handle this</a>
                                                </c:if>
                                                <c:if test="${not empty iss.handledBy}">   
                                                    ${iss.handledBy}
                                                </c:if> 
                                            </td>
                                            <td>${iss.handledDate}</td>
                                            <td nowrap="">${iss.problem.handledBy} <br/> ${iss.problem.handledDate}</td>
                                            <td>${iss.problem.closedDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="10">
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
                                                                <a href="<c:url value="/Administration/SystemSupport/list/${status}">
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

        <!-- /main-content -->
        <!-- /main -->
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
