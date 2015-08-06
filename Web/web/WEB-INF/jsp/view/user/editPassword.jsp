<template:Client htmlTitle="LiXi Global - Change Your Password">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class="section-85-0">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-8 col-md-8 col-sm-10 col-xs-12">
                        <c:if test="${validationErrors != null}">
                            <div class="msg msg-error">
                                <ul>
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${editSuccess eq 0 || param.editSuccess eq 0}">
                            <div class="alert alert-danger">
                                <spring:message code="message.wrong_password"/>
                            </div>
                        </c:if>
                        <spring:message code="message.password_format" var="passwordMessage"/>
                        <form:form class="form-horizontal" modelAttribute="userEditPasswordForm">
                            <fieldset>
                                <legend><spring:message code="message.change_password"/></legend>
                                <div class="desc">
                                    <spring:message code="message.change_password_desc"/>
                                </div>
                                <br/>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="currentPassword" class="control-label">Current password</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:password  path="currentPassword" class="form-control"/>
                                        <span class="help-block errors "><form:errors path="currentPassword" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="password" class="control-label">New password</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:password path="password" class="form-control" placeholder="${placeholder}"/>
                                        <span class="help-block errors "><form:errors path="password" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="confPassword" class="control-label">Reenter new password:</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:password path="confPassword" class="form-control"/>
                                        <span class="help-block errors "><form:errors path="confPassword" /></span>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <button id="btnSubmit" class="btn btn-primary">Save Changes</button>
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