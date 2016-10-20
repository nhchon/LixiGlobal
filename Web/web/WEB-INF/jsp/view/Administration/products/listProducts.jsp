<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">List Products</h2>
        <div class="row">
            <div class="col-md-12">
                <!-- Content -->
                <table class="table table-hover table-responsive table-striped">
                    <thead>
                        <tr>
                            <th>#ID</th>
                            <th></th>
                            <td>Name</td>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pRs.content}" var="p">
                        <tr>
                            <td>${p.id}</td>
                            <td></td>
                            <td>${p.name}</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- /main -->
    </jsp:body>
</template:Admin>
