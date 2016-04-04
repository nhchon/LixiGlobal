<%-- 
    Document   : monitor_part_backup
    Created on : Apr 2, 2016, 11:05:06 AM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
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
        
    </body>
</html>
