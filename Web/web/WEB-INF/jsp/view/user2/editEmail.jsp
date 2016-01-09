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
        <section class="main-section bg-default">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
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
                        <h2 class="title">Change Email</h2>
                    <form:form  modelAttribute="userEditEmailForm"  role="form">
                        <div class="form-group">
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label for="email" class="control-label">Old email address</label>
                                <input type="text" class="form-control" readonly="" disabled="" value="${USER_LOGIN_EMAIL}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label for="email" class="control-label">New email address</label>
                                <form:input path="email" class="form-control"/>
                                <div class="has-error"><form:errors path="email"  cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label for="confEmail" class="control-label">Re-enter new e-mail:</label>
                                <form:input path="confEmail" class="form-control"/>
                                <div class="has-error"><form:errors path="confEmail"  cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label for="password" class="control-label">Enter your password</label>
                                <form:password path="password" class="form-control" />
                                <div class="has-error"><form:errors path="password"  cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-8">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                <button type="button" class="btn btn-warning btn-has-link-event" data-link="<c:url value="/user/yourAccount"/>">Cancel</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>