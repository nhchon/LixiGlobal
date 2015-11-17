<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <div class="col-md-10 content-wrapper" style="background-color: #ffffff">
            <div class="row">
                <div class="col-lg-4 ">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                        <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
                    </ul>
                </div>
            </div>

            <!-- main -->
            <div class="content">
                <div class="main-header">
                    <h2 style="border-right:none;">Issue List</h2>
                </div>
                <div class="main-content">
                    
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
                            <c:forEach items="${issues}" var="iss">
                                <tr>
                                    <td>${iss.id}</td>
                                    <td>
                                        <a href="<c:url value="/Administration/SystemSupport/detail/${iss.id}"/>">${iss.subject.subject}</a>
                                    </td>
                                    <td>${iss.orderId}</td>
                                    <td>${iss.contactData}</td>
                                    <td>${iss.createdDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${iss.status eq 0}">
                                               Open
                                            </c:when>
                                            <c:when test="${iss.status eq 1}">
                                                In Process
                                            </c:when>
                                            <c:when test="${iss.status eq 2}">
                                                Cancel
                                            </c:when>
                                            <c:when test="${iss.status eq 3}">
                                                Closed
                                            </c:when>
                                            <c:when test="${iss.status eq 4}">
                                                Re-Open
                                            </c:when>
                                        </c:choose>                                        
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
                    </table>
                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
