<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <div class="row">
            <div class="col-sm-12 ">
                <ul class="breadcrumb">
                    <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                    <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
                </ul>
            </div>
        </div>

        <!-- main -->
        <h2 class="sub-header">Detail Issue</h2>
        <div class="row">
            <div class="col-sm-12 ">
                <c:url value="/Administration/SystemSupport/changeStatus" var="changeStatusFormUrl"/>
                <form class="form-horizontal" role="form" method="post" action="${changeStatusFormUrl}">
                        <div class="form-group">
                            <div class="col-sm-2">Subject</div>
                            <div class="col-sm-10">
                                <b>${issue.subject.subject}</b>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">Content</div>
                            <div class="col-sm-10">
                                ${issue.content}
                            </div>
                        </div>
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
                        <div class="form-group">
                            <div class="col-sm-2">Contact Method</div>
                            <div class="col-sm-10">
                                ${issue.contactMethod}
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">Contact Data</div>
                            <div class="col-sm-10">
                                ${issue.contactData}
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">Created By</div>
                            <div class="col-sm-10">
                                ${issue.createdBy}
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">Created Date</div>
                            <div class="col-sm-10">
                                ${issue.createdDate}
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">Status</div>
                            <div class="col-sm-2">
                                <security:authentication property="principal.username" var="loginedUser"/>
                                <select name="status" class="form-control" <c:if test="${issue.handledBy ne loginedUser}">disabled=""</c:if>>
                                    <option value="0" <c:if test="${issue.status eq 0}">selected=""</c:if>>Open</option>
                                    <option value="1" <c:if test="${issue.status eq 1}">selected=""</c:if>>In Process</option>
                                    <option value="2" <c:if test="${issue.status eq 2}">selected=""</c:if>>Cancel</option>
                                    <option value="3" <c:if test="${issue.status eq 3}">selected=""</c:if>>Closed</option>
                                    <option value="4" <c:if test="${issue.status eq 4}">selected=""</c:if>>Re-Open</option>
                                    </select>

                                </div>
                                <div class="col-sm-2">
                                <c:if test="${issue.handledBy eq loginedUser}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <input type="hidden" name="probId" value="${issue.id}"/>
                                    <button type="submit" class="btn btn-primary">Change</button>
                                </c:if>
                            </div>    
                        </div>
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
                        <div class="form-group">
                            <div class="col-sm-2">Handled Date</div>
                            <div class="col-sm-10">
                                ${issue.handledDate}
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2">Closed Date</div>
                            <div class="col-sm-10">
                                ${issue.closedDate}
                            </div>
                        </div>
                    <h3>Comments</h3>
                    <c:forEach items="${issue.comments}" var="c" varStatus="theCount">
                            <div class="form-group">
                                <div class="col-sm-1">${theCount.count}</div>
                                <div class="col-sm-11">
                                    ${c.content}
                                </div>
                            </div>
                    </c:forEach>
                </form>
                <c:url value="/Administration/SystemSupport/addAComment" var="commentFormUrl"/>
                <form role="form" method="post" action="${commentFormUrl}">
                    <div class="form-group">
                        <label for="email">Add new comment:</label>
                        <textarea name="comment" rows="5" class="form-control"></textarea>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="probId" value="${issue.id}"/>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div></div>
        <!-- /main -->
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
