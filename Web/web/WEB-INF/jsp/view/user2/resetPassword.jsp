<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <style>
            .progress{
                margin-bottom: 0px;
            }
        </style>
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/pwstrength/pwstrength.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var CAPTCHA_MESSAGE = '<spring:message code="validate.captcha_required"/>'
            var CONTEXT_PATH = '${pageContext.request.contextPath}';
            $(document).ready(function () {
                //"use strict";
                var options = {};
                options.ui = {
                    showVerdictsInsideProgressBar: true,
                    viewports: {
                        progress: ".pwstrength_viewport_progress"
                    }
                };
                options.common = {
                    debug: true,
                    minChar: 8,
                    usernameField: '#email'
                };
                $(':password').pwstrength(options);
            });

            function validResetPassForm() {

                // Ok
                return true;
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <c:if test="${validationErrors != null}"><div class="msg msg-error">
                            <ul>
                                <c:forEach items="${validationErrors}" var="error">
                                    <li><c:out value="${error.message}" /></li>
                                    </c:forEach>
                            </ul>
                        </div></c:if>
                    <c:if test="${codeIsInvalid == 'yes'}">
                        <div class="msg msg-error">There is something wrong. Please try again !</div>
                    </c:if>
                    <spring:message code="message.password_format" var="passwordMessage"/>
                    <form:form onsubmit="return validResetPassForm();" class="form-horizontal" modelAttribute="userResetPasswordForm">
                            <h2 class="title">Reset Your Password</h2>
                            <div class="desc">
                                Please enter your new password.
                            </div>
                            <div class="form-group">
                                <div class="col-md-3">
                                    <label for="email" class="control-label">Your new password</label>
                                </div>
                                <div class="col-md-6">
                                    <form:password path="password" class="form-control" placeholder="${passwordMessage}"/>
                                    <div class="has-error"><form:errors path="password"  cssClass="help-block"  element="div"/></div>
                                    <div class="pwstrength_viewport_progress"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-3">
                                    <label for="confPassword" class="control-label">Retype your new password</label>
                                </div>
                                <div class="col-md-6">
                                    <form:password path="confPassword" class="form-control" placeholder="${passwordMessage}"/>
                                    <div class="has-error"><form:errors path="confPassword" cssClass="help-block"  element="div"/></div>
                                </div>
                            </div>
                            <div class="form-group right">
                                <div class="col-md-3"></div>
                                <div class="col-md-9">
                                    <form:hidden path="code"/>
                                    <button type="submit" class="btn btn-primary">Change Password</button>
                                </div>
                            </div>
                    </form:form>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>