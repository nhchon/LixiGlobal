<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/change-login-email.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="change-login-email">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-8 col-md-8 col-sm-10 col-xs-12">
                        <c:if test="${validationErrors != null}">
                            <div class="msg msg-error">
                                <ul style="margin-bottom: 0px;">
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${reUseEmail eq 1 || param.reUseEmail eq 1}">
                            <div class="alert alert-danger">
                                <spring:message code="validate.email.inuse_param" arguments="${userEditEmailForm.email}"/>
                            </div>
                        </c:if>
                        <c:if test="${editSuccess eq 0 || param.editSuccess eq 0}">
                            <div class="alert alert-danger">
                                <spring:message code="message.wrong_password"/>
                            </div>
                        </c:if>
                        <form:form  class="form-horizontal" modelAttribute="userEditEmailForm">
                            <fieldset>
                                <legend>Change Email</legend>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="email" class="control-label">Old email address</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        ${USER_LOGIN_EMAIL}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="email" class="control-label">New email address</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:input path="email" class="form-control"/>
                                        <span class="help-block errors "><form:errors path="email" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="confEmail" class="control-label">Re-enter new e-mail:</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:input path="confEmail" class="form-control"/>
                                        <span class="help-block errors "><form:errors path="confEmail" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="password" class="control-label">Enter your password</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:password path="password" class="form-control" />
                                        <span class="help-block errors "><form:errors path="password" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5"></div>
                                    <div class="col-lg-7">
                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form:form>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>