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
            <li><a href="<c:url value="/Administration/SystemFee/list"/>">Fees</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Lixi Configuration Parameters</h2>
        <div class="row">
            <div class="col-md-12">
                <!-- Content -->
                <div class="table-responsive">
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Value</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:url value="/Administration/SystemConfig/configs/save" var="saveFeeUrl"/>
                            <form action="${saveFeeUrl}" method="post">
                                <tr>
                                    <td>#</td>
                                    <td>
                                        <input type="text" name="name" value="" class="form-control"/>
                                    </td>
                                    <td>
                                        <input type="text" name="value" class="form-control" />
                                    </td>
                                    <td>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="id" value="0" />
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </td>
                                </tr>
                            </form>
                            <c:forEach items="${configs}" var="c" varStatus="theCount">
                            <form action="${saveFeeUrl}" method="post">
                                <tr>
                                    <td><b>${c.id}</b></td>
                                    <td><input type="text" name="name" value="${c.name}" class="form-control"/></td>
                                    <td><input type="text" name="value" value="${c.value}" class="form-control"/></td>
                                    <td>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="id" value="${c.id}" />
                                        <button type="submit" class="btn btn-warning">Save</button>
                                        <button type="button" class="btn btn-default" onclick="document.location.href='<c:url value="/Administration/SystemConfig/configs/delete/${c.id}"/>'">Delete</button>
                                    </td>
                                </tr>
                            </form>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- /main -->
        </jsp:body>
    </template:Admin>
