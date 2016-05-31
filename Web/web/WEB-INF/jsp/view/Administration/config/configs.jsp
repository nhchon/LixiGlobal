<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function deleteConfig(id){
                if(confirm('Are you sure want to delete this config ???')){
                    document.location.href = '<c:url value="/Administration/SystemConfig/configs/delete/"/>' + id;
                }
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemConfig/configs"/>">Lixi Configuration Parameters</a></li>
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
                                    <td><input type="text" name="name" value="${c.name}" class="form-control" readonly=""/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.name eq 'VTC_AUTO'}">
                                                <select class="form-control" name="value">
                                                    <option value="YES" <c:if test="${c.value eq 'YES'}">selected=""</c:if>>YES</option>
                                                    <option value="NO" <c:if test="${c.value eq 'NO'}">selected=""</c:if>>NO</option>
                                                </select>
                                            </c:when>
                                            <c:when test="${c.name eq 'LIXI_BAOKIM_TRANFER_PERCENT'}">
                                                <input type="number" name="value" value="${c.value}" class="form-control"/>
                                            </c:when>
                                            <c:when test="${c.name eq 'LIXI_ADMINISTRATOR_EMAIL'}">
                                                <input type="text" name="value" value="${c.value}" class="form-control"/>
                                                <div class="help-block">Split by ; if we have multi addresses</div>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="text" name="value" value="${c.value}" class="form-control"/>
                                            </c:otherwise>
                                        </c:choose>   
                                    </td>
                                    <td>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="id" value="${c.id}" />
                                        <button type="submit" class="btn btn-warning">Change</button>
                                        <button type="button" class="btn btn-default" onclick="deleteConfig(${c.id})">Delete</button>
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
