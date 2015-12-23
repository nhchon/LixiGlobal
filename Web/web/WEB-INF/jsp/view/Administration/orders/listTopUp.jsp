<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Top Up">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function submit2VTC(id){
                if(confirm('Send tthis top up to VTC ?')){
                    document.location.href = '<c:url value="/Administration/SystemTopUp/send2VTC"/>' + "/" + id;
                }
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/SystemTopUp/list"/>">Top Up Mobile List</a></li>
        </ul>

        <!-- main -->
        <h2 class="sub-header">Top Up Mobile List</h2>
        <div class="row">
            <div class="col-sm-12">
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="table-responsive">
                            <table class="table table-hover table-responsive">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Order ID</th>
                                        <th>Authorize Trans ID</th>
                                        <th>Receiver</th>
                                        <th>Phone</th>
                                        <th>Amount</th>
                                        <th>Submitted</th>
                                        <th>Response message</th>
                                        <th style="width:98px;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${topUps}" var="t">
                                        <tr>
                                            <td>${t.id}</td>
                                            <td>${t.order.id}</td>
                                            <td>${t.order.invoice.netTransId}</td>
                                            <td>${t.recipient.fullName}</td>
                                            <td>${t.phone}</td>
                                            <td>$${t.amount}</td>
                                            <td>
                                                <c:if test="${t.isSubmitted eq 0}">
                                                    Not yet submitted
                                                </c:if>
                                                <c:if test="${t.isSubmitted eq -1}">
                                                    Submit failed
                                                </c:if>
                                            </td>
                                            <td>${t.responseMessage}</td>
                                            <td style="text-align: right;"><button onclick="submit2VTC(${t.id})" class="btn btn-warning" style="width:98px;">Send To VTC</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="9">
                                            
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
