<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Shipping Charged">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function deleteShippingCharged(id){
                if(confirm('Are you sure want to delete this config ???')){
                    postInvisibleForm('<c:url value="/Administration/SystemConfig/shippingCharged/delete"/>', {"id":id});
                }
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemConfig/configs"/>">Lixi Shipping Charged</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Lixi Shipping Charged</h2>
        <div class="row">
            <div class="col-md-12">
                <!-- Content -->
                <div class="table-responsive">
                    <table class="table table-hover table-responsive">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th style="text-align: center;">From Total Order</th>
                                <th></th>
                                <th style="text-align: center;">Charged Amount</th>
                                <th></th>
                                <th style="text-align: center;">To Total Order</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:url value="/Administration/SystemConfig/shippingCharged/save" var="saveShippingChargedUrl"/>
                            <form action="${saveShippingChargedUrl}" method="post">
                                <tr>
                                    <td>#</td>
                                    <td>
                                        <input type="text" name="fromTotal" value="" class="form-control"/>
                                    </td>
                                    <td style="vertical-align: middle;"><b> &lt; </b></td>
                                    <td>
                                        <input type="text" name="chargeAmount" class="form-control" />
                                    </td>
                                    <td style="vertical-align: middle;"><b> &ge; </b></td>
                                    
                                    <td>
                                        <input type="text" name="toTotal" value="" class="form-control"/>
                                    </td>
                                    <td>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-primary">Save</button>
                                    </td>
                                </tr>
                            </form>
                            <c:forEach items="${ships}" var="s" varStatus="theCount">
                                <tr>
                                    <td style="vertical-align: middle;"><b># ${s.id}</b></td>
                                    <td style="vertical-align: middle;"><fmt:formatNumber value="${s.orderFrom}" pattern="###,###.##"/></td>
                                    <td style="vertical-align: middle;"></td>
                                    <td style="vertical-align: middle;"><fmt:formatNumber value="${s.orderToEnd}" pattern="###,###.##"/></td>
                                    <td style="vertical-align: middle;"></td>
                                    <td style="vertical-align: middle;"><fmt:formatNumber value="${s.chargedAmount}" pattern="###,###.##"/></td>
                                    <td style="vertical-align: middle;"><button type="button" class="btn btn-warning" onclick="deleteShippingCharged(${s.id})">Delete</button></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- /main -->
        </jsp:body>
    </template:Admin>
