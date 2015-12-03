<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <!-- Javascript -->
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
            
            function removeIcon(formId, code){
            
                var formId = "form"+formId;
                var oForm = document.getElementById(formId);
                
                oForm.elements["img-old-"+code].value = "";
                oForm.elements["icon-"+code].src = "<c:url value="/resource/theme/assets/lixiglobal/img/no_image.jpg"/>";
            }
        </script>    
    </jsp:attribute>
    <jsp:body>
        <!-- content-wrapper -->
            <div class="row">
                <div class="col-lg-4 ">
                    <ul class="breadcrumb">
                        <li><i class="fa fa-home"></i><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                        <li><a href="<c:url value="/Administration/SystemConfig/categories"/>"><spring:message code="message.categories"/></a></li>
                    </ul>
                </div>
            </div>

            <!-- main -->
                    <h2 class="sub-header"><spring:message code="message.categories"/></h2>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>VG's ID</th>
                                <th>VG's Name</th>
                                <th>Code</th>
                                <th>English</th>
                                <th>Vietnam</th>
                                <th></th>    
                                <th><!-- Submit button --></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${VATGIA_CATEGORIES}" var="vg">
                                <form:form id="form${vg.id}" role="form" action="${pageContext.request.contextPath}/Administration/SystemConfig/categories" method="post">
                                    <tr>
                                        <td><input type="text" class="form-control" value="<c:if test="${not empty vg.lixiCategory}">${vg.lixiCategory.id}</c:if>" readonly="" style="width:50px;"/></td>
                                        <td><input name="vgId" type="text" value="${vg.id}" class="form-control" readonly="" style="width:50px;"/></td>
                                        <td><input name="vgName" type="text" value="${vg.title}" class="form-control"/></td>
                                        <td><input type="text" name="code" value="${vg.lixiCategory.code}" class="form-control"/></td>
                                        <c:if test="${not empty vg.lixiCategory}">
                                            <td><input name="english" type="text" value="${vg.lixiCategory.english}" class="form-control"/></td>
                                            <td><input name="vietnam" type="text" value="${vg.lixiCategory.vietnam}" class="form-control"/>
                                                <input type="hidden" name="lxId" value="${vg.lixiCategory.id}"/>
                                            </td>
                                        </c:if>
                                        <c:if test="${empty vg.lixiCategory}">
                                            <td><input type="text" name="english" value="" class="form-control"/></td>
                                            <td>
                                                <input type="text" name="vietname" class="form-control"/>
                                            </td>
                                        </c:if>
                                        <td></td>        
                                        <td></td>    
                                    </tr>
                                </form:form>
                            </c:forEach>
                        </tbody>
                    </table>    
                </div>
            <!-- /main -->
        <!-- /content-wrapper -->
    </jsp:body>
</template:Admin>
