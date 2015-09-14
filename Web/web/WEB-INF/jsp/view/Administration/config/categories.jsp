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
                                    <td></td>
                                </c:forEach>
                                <th>Sort Order</th>    
                                <th><!-- Submit button --></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${VATGIA_CATEGORIES}" var="vg">
                                <form:form id="form${vg.id}" role="form" action="${pageContext.request.contextPath}/Administration/SystemConfig/categories" method="post" enctype="multipart/form-data">
                                    <tr>
                                        <td><input name="vgId" type="text" value="${vg.id}" class="form-control" readonly="" style="width:50px;"/></td>
                                        <td><input name="vgName" type="text" value="${vg.title}" class="form-control"/></td>
                                        <c:if test="${not empty vg.lixiCategories}">
                                            <c:forEach items="${vg.lixiCategories}" var="lxc">
                                                <td>
                                                    <input name="${lxc.locale.code}" type="text" value="${lxc.name}" class="form-control"/>
                                                    <input type="hidden" name="${lxc.locale.code}-id" value="${lxc.id}"/>
                                                </td>
                                                <td>
                                                    <img name="icon-${lxc.locale.code}" width="136" height="136" src="<c:url value="/showImages/"/>${lxc.icon}"/>
                                                    <input type="hidden" name="img-old-${lxc.locale.code}" value="${lxc.icon}"/>
                                                    <button type="button" onclick="removeIcon(${vg.id}, '${lxc.locale.code}');">Remove Icon</button>
                                                    <input type="file" name="img-${lxc.locale.code}" class="form-control"/>
                                                </td>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty vg.lixiCategories}">
                                            <c:forEach items="${SUPPORT_LOCALE}" var="sl">
                                                <td><input name="${sl.code}" type="text" value="" class="form-control"/></td>
                                                <td>
                                                    <input type="file" name="img" class="form-control"/>
                                                </td>
                                            </c:forEach>
                                                
                                        </c:if>
                                                <td><input type="number" class="form-control" value="${vg.sortOrder}" name="sortOrder"/></td>        
                                        <td><button class="btn btn-primary" type="submit" onclick="return validateCategoryName(${vg.id});">Save</button>
                                            <c:if test="${vg.activated eq 1}">
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
