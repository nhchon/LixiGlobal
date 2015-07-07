<template:Admin htmlTitle="Administration -:- Dashboard">
    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /**
             * 
             * @param {type} id
             * @returns {undefined}
             */
            function showDescription(id) {
                $('#description_' + id).show();
            }

            /**
             * 
             * @param {type} id
             * @returns {undefined}
             */
            function hideDescription(id) {
                $('#description_' + id).hide();
            }
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
                    <h2><spring:message code="message.system.user.add_new_page"/></h2>
                </div>

                <div class="main-content">
                    <div class="widget">
                        <div class="widget-header">
                            <h3><i class="fa fa-edit"></i> <spring:message code="message.system.user.add_new_form"/></h3>
                        </div>
                        <div class="widget-content">
                            <form:form modelAttribute="adminUserAddForm" role="form" class="form-horizontal">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label class="control-label sr-only" for="first-name"><spring:message code="message.first_name"/></label>
                                            <form:input path="firstName" class="form-control" placeholder='First Name'/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="firstName" /></li></ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label class="control-label sr-only" for="middle-name"><spring:message code="message.middle_name"/></label>
                                            <form:input path="middleName" class="form-control" placeholder='Middle Name'/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="middleName" /></li></ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label class="control-label sr-only" for="lastName"><spring:message code="message.last_name"/></label>
                                            <form:input path="lastName" class="form-control" placeholder='Last Name'/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="lastName" /></li></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label sr-only" for="email"><spring:message code="message.email"/></label>
                                            <form:input path="email" class="form-control" placeholder='Email'/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="email" /></li></ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label sr-only" for="phone"><spring:message code="message.phone"/></label>
                                            <form:input path="phone" class="form-control"  placeholder='Phone'/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="phone" /></li></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label sr-only" for="email"><spring:message code="message.email"/></label>
                                            <form:password path="password" class="form-control" placeholder="Password"/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="password" /></li></ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label sr-only" for="phone"><spring:message code="message.phone"/></label>
                                            <form:password path="confPassword" class="form-control" placeholder="Retype Password"/>
                                            <ul class="parsley-errors-list filled"><li class="parsley-required"><form:errors path="confPassword" /></li></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <div class="checkbox" style="padding-top: 0px;">
                                            <label>
                                                <form:checkbox path="enabled"/> <spring:message code="message.enabled"/>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="checkbox" style="padding-top: 0px;">
                                            <label>
                                                <form:checkbox path="changePasswordNextTime"/> <spring:message code="message.password_next_time"/>
                                            </label>
                                        </div>
                                    </div>
                                </div>                                        
                                <h4><b><spring:message code="message.roles"/></b></h4>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <c:forEach items="${AUTHORITIES}" var="auth">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <input name="authorities" value="${auth.authority}" type="checkbox" aria-label="..." <c:if test="${auth.checked}">checked=""</c:if> >
                                                    </span>
                                                    <input name="role_name" onmouseout="hideDescription(${auth.id});" onmouseover="showDescription(${auth.id});" type="text" class="form-control disabled" aria-label="..." readonly="" value="${auth.authority}">
                                            </div><!-- /input-group -->
                                        </c:forEach>
                                    </div>
                                    <div class="col-sm-6">
                                        <c:forEach items="${AUTHORITIES}" var="auth">
                                            <div class="media" style="display:none;" id="description_${auth.id}">
                                                <div class="media-body">
                                                    <h4 class="media-heading">${auth.authority}</h4>
                                                    <spring:message code="${auth.description}"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <br/>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <button class="btn btn-primary" type="submit">Save</button>
                                    </div>
                                </div>
                            </form:form>
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