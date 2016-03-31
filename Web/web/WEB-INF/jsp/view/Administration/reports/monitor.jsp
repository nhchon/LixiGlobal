<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- List Transaction Monitor">
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script type="text/javascript">
            function gotIt(id){
                overlayOn($('#rowMonitor'+id));
                $.ajax(
                {
                    url: '<c:url value="/Administration/TransactionMonitor/process/"/>' + id,
                    type: "GET",
                    dataType: 'json',
                    success: function (data, textStatus, jqXHR)
                    {
                        //data: return data from server
                        if (data.error === '1') {
                            
                            alert('There is something wrong. Please try again!');
                        }
                        else {
                            $('#rowMonitor'+id).remove();
                        }
                        overlayOff();
                    },
                    error: function (jqXHR, textStatus, errorThrown)
                    {
                        //if fails  
                        overlayOff();
                    }
                });
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <%@include  file="/WEB-INF/jsp/view/Administration/add-on/order_status.jsp" %>
        <!-- content-wrapper -->
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
            <li><a href="<c:url value="/Administration/TransactionMonitor/report"/>">Transaction Monitor</a></li>
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
                                        <th style="text-align: right;">Process</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${monitors}" var="m">
                                        <tr id="rowMonitor${m.id}">
                                            <td>${m.id}</td>
                                            <td>${m.description}</td>
                                            <td><a href="<c:url value="/Administration/SystemSender/detail/${m.user.id}"/>">${m.user.email}</a></td>
                                            <td>
                                                <fmt:formatDate pattern="yyyy-MM-dd HH-mm" value="${m.createdDate}"/>
                                            </td>
                                            <td style="text-align: right;" nowrap>
                                                <button class="btn btn-primary btn-sm" onclick="gotIt(${m.id})">Got It</button>
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
