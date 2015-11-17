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
                    <h2 style="border-right:none;">Detail Issue</h2>
                </div>
                <div class="main-content">
                    <form class="form-horizontal" role="form">
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Subject</div>
                                <div class="col-sm-10">
                                    <b>${issue.subject.subject}</b>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Content</div>
                                <div class="col-sm-10">
                                    ${issue.content}
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Belong to Order</div>
                                <div class="col-sm-10">
                                    <c:if test="${empty issue.orderId}">
                                        No Order
                                    </c:if>
                                    <c:if test="${not empty issue.orderId}">
                                        ${issue.orderId}
                                    </c:if>
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Contact Method</div>
                                <div class="col-sm-10">
                                    ${issue.contactMethod}
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Contact Data</div>
                                <div class="col-sm-10">
                                    ${issue.contactData}
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Created By</div>
                                <div class="col-sm-10">
                                    ${issue.createdBy}
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Created Date</div>
                                <div class="col-sm-10">
                                    ${issue.createdDate}
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Status</div>
                                <div class="col-sm-10">
                                    ${issue.status}
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Handle By</div>
                                <div class="col-sm-10">
                                    <c:if test="${empty issue.handledBy}">
                                        <a href="<c:url value="/Administration/SystemSupport/handle/${issue.id}"/>">Handle this</a>
                                    </c:if>
                                    <c:if test="${not empty issue.handledBy}">   
                                        ${issue.handledBy}
                                    </c:if> 
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Handled Date</div>
                                <div class="col-sm-10">
                                    ${issue.handledDate}
                                </div>
                            </div>
                        </div>        
                        <div class="row">
                            <div class="form-group">
                                <div class="col-sm-2">Closed Date</div>
                                <div class="col-sm-10">
                                    ${issue.closedDate}
                                </div>
                            </div>
                        </div>        
                    </form>
                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
