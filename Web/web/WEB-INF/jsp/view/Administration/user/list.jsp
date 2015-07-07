<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            $(document).ready(function () {
                $('input[name=enabled]').change(function(){
                    if($(this).is(':checked')===false){
                        if(confirm('Disable this user ?')){
                            // do it
                            //alert($(this).attr('userid'))
                            document.location.href='<c:url value="/Administration/SystemUser/enable"/>'+'/'+$(this).attr('userid')+'/0';
                        }
                        else{
                            //
                            $(this).prop('checked', true);
                        }
                    }
                    else{
                        if(confirm('Enable this user ?')){
                            // do it
                            //alert($(this).attr('userid'))
                            document.location.href='<c:url value="/Administration/SystemUser/enable"/>'+'/'+$(this).attr('userid')+'/1';
                        }
                        else{
                            // roll back action
                            $(this).prop('checked', false);
                        }
                    }
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <!-- top general alert -->
        <!-- end top general alert -->

        <!-- content-wrapper -->
        <div class="col-md-10 content-wrapper">
            <div class="row">
                <div class="col-lg-4 ">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i><a href="#">Home</a></li>
                        <li><a href="#">Pages</a></li>
                        <li class="active">Blank Page</li>
                    </ul>
                </div>
            </div>

            <!-- main -->
            <div class="content">
                <div class="main-header">
                    <h2><spring:message code="message.system.user.list"/></h2>
                </div>

                <div class="main-content">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="widget widget-table">
                                <div class="widget-header">
                                    <div class="row">
                                        <div class="col-md-6"><h3><i class="fa fa-table"></i><spring:message code="message.system.user.list"/></h3></div>
                                        <div class="col-md-6">
                                            <h3 class="pull-right"><a href="#">Add New User</a></h3>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="widget-content">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th><spring:message code="message.name"/></th>
                                                <th><spring:message code="message.email"/></th>
                                                <th>Enabled</th>
                                                <th>Creaed Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ADMIN_USER_LIST}" var="u">
                                            <tr>
                                                <td>${u.id}</td>
                                                <td><a href="<c:url value="/Administration/SystemUser/detail/${u.id}"/>">${u.firstName}&nbsp;${u.middleName}&nbsp;${u.lastName}</a></td>
                                                <td>${u.email}</td>
                                                <td>
                                                    <c:if test="${not u.enabled}">
                                                        <input name="enabled" userid="${u.id}" type="checkbox"/>
                                                    </c:if>
                                                    <c:if test="${u.enabled}">
                                                        <input  name="enabled" userid="${u.id}" type="checkbox" checked=""/>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${u.createdDate}" />
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
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>