<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Top Up">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
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
        <h2 class="sub-header">Transaction Monitor</h2>
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
                                        <th nowrap>Description</th>
                                        <th nowrap>User</th>
                                        <th nowrap>Created Date</th>
                                        <th>Process</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${monitors}" var="m">
                                        <tr id="rowTopUp${m.id}">
                                            <td>${m.id}</td>
                                            <td>${m.description}</td>
                                            <td>${m.user.email}</td>
                                            <td style="text-align: center;">
                                                <fmt:formatDate pattern="yyyy-MM-dd HH-mm" value="${m.createdDate}"/>
                                            </td>
                                            <td style="text-align: right;" nowrap>
                                                <button class="btn btn-primary" onclick="">Process It</button>
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
