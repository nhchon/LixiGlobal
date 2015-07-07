<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/jquery.dataTables.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.colVis.bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.colReorder.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/exts/dataTables.tableTools.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/datatable/dataTables.bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/king-table.js"/>"></script>
        <script type="text/javascript">
            var supportLocale = [];
            <c:forEach items="${SUPPORT_LOCALE}" var="sl" varStatus="status">
            supportLocale[${status.index}] = '${sl.code}';
            </c:forEach>
            /**
             * 
             * @param {Int} id
             * @returns {Boolean}
             */
            function validateCategoryName(id){
                var formId = "form"+id;
                var oForm = document.getElementById(formId);
                for(index = 0; index < supportLocale.length; index++) {
                    if($.trim(oForm.elements[supportLocale[index]].value) === ''){
                        alert('<spring:message code="validate.thethingtosavemustnotbenull"/>');
                        oForm.elements[supportLocale[index]].focus();
                        return false;
                    }
                }
                //alert(oForm.elements[supportLocale[0]].value)
                //alert("#"+formId+" input[name="+supportLocale[0]+"]")
                //alert( $("#"+formId+" input[name="+supportLocale[0]+"]").val() );
                return true;
            }
            
            function deleteCategory(vgId){
                
                if(confirm('<spring:message code="message.want_to_delete"/>')){
                    document.location.href = '<c:url value="/Administration/SystemConfig/categories"/>/del/'+vgId;
                }
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
        <div class="col-md-10 content-wrapper" style="background-color: #ffffff">
            <div class="row">
                <div class="col-lg-4 ">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                        <li><a href="<c:url value="/Administration/SystemConfig/categories"/>"><spring:message code="message.categories"/></a></li>
                    </ul>
                </div>
            </div>

            <!-- main -->
            <div class="content">
                <div class="main-header">
                    <h2 style="border-right:none;"><spring:message code="message.categories"/></h2>
                </div>
                <div class="main-content">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th></th>
                                <th><spring:message code="message.vat_gia_category_name"/></th>
                                    <c:forEach items="${SUPPORT_LOCALE}" var="sl">
                                    <th>${sl.name}</th>
                                    </c:forEach>
                                <th><!-- Submit button --></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${VATGIA_CATEGORIES}" var="vg">
                                <form:form id="form${vg.id}" role="form" action="${pageContext.request.contextPath}/Administration/SystemConfig/categories" method="post">
                                    <tr>
                                        <td><input name="vgId" type="text" value="${vg.id}" class="form-control" readonly="" style="width:50px;"/></td>
                                        <td><input name="vgName" type="text" value="${vg.title}" class="form-control"/></td>
                                            <c:if test="${not empty vg.lixiCategoryList}">
                                                <c:forEach items="${vg.lixiCategoryList}" var="lxc">
                                                <td>
                                                    <input name="${lxc.localeCode.code}" type="text" value="${lxc.name}" class="form-control"/>
                                                    <input type="hidden" name="${lxc.localeCode.code}-id" value="${lxc.id}"/>
                                                </td>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty vg.lixiCategoryList}">
                                            <c:forEach items="${SUPPORT_LOCALE}" var="sl">
                                                <td><input name="${sl.code}" type="text" value="" class="form-control"/></td>
                                                </c:forEach>
                                            </c:if>
                                                <td><button class="btn btn-primary" type="submit" onclick="return validateCategoryName(${vg.id});">Save</button>
                                            <c:if test="${not empty vg.lixiCategoryList}">
                                                <button class="btn btn-warning" type="button" onclick="deleteCategory(${vg.id});">Delete</button>
                                            </c:if>
                                        </td>    
                                    </tr>
                                </form:form>
                            </c:forEach>
                        </tbody>
                    </table>    
                </div>
                <!-- /main-content -->
            </div>
            <!-- /main -->
        </div>
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
