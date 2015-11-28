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
            <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Issue List</h2>
        <div class="row">
            <div class="col-sm-12">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <c:forEach items="${statuses}" var="s" varStatus="theCount">
                        <li <c:if test="${s.code eq status}">class="active"</c:if>>
                            <a href="<c:url value="/Administration/SystemSupport/list/${s.code}"/>" role="tab">
                                <i class="fa fa-home"></i> ${s.description}
                            </a>
                        </li>
                    </c:forEach>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Subject</th>
                                        <th>Order ID</th>
                                        <th>Contact</th>
                                        <th>Created Date</th>
                                        <th>Status</th>
                                        <th>Handled By</th>
                                        <th>Handled Date</th>
                                        <th>Closed Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${issues.content}" var="iss">
                                        <tr>
                                            <td>${iss.id}</td>
                                            <td>
                                                <a href="<c:url value="/Administration/SystemSupport/detail/${iss.id}?rl=list"/>">${iss.subject.subject}</a>
                                            </td>
                                            <td>${iss.orderId}</td>
                                            <td>${iss.contactData}</td>
                                            <td>${iss.createdDate}</td>
                                            <td>${iss.status.description}
                                            </td>
                                            <td>
                                                <c:if test="${empty iss.handledBy}">
                                                    <a href="<c:url value="/Administration/SystemSupport/handle/${iss.id}"/>">Handle this</a>
                                                </c:if>
                                                <c:if test="${not empty iss.handledBy}">   
                                                    ${iss.handledBy}
                                                </c:if> 
                                            </td>
                                            <td>${iss.handledDate}</td>
                                            <td>${iss.closedDate}</td>
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
