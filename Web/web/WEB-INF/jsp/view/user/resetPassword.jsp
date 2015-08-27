<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/password-assistance.css"/>" type="text/css" />
        <style>
            .progress{
                margin-bottom: 0px;
            }
        </style>
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/plugins/pwstrength/pwstrength.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var CAPTCHA_MESSAGE = '<spring:message code="validate.captcha_required"/>'
            var CONTEXT_PATH = '${pageContext.request.contextPath}';
            $(document).ready(function () {
                "use strict";
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
            
            function validResetPassForm(){
                
                // Ok
                return true;
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="password-assistance">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
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
                            <fieldset>
                                <legend>Reset Your Password</legend>
                                <div class="desc">
                                    Please enter your new password.
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="email" class="control-label">Your new password</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:password path="password" class="form-control" placeholder="${passwordMessage}"/>
                                        <span class="help-block errors"><form:errors path="password" /></span>
                                        <div class="pwstrength_viewport_progress"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="confPassword" class="control-label">Retype your new password</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <form:password path="confPassword" class="form-control" placeholder="${passwordMessage}"/>
                                        <span class="help-block errors"><form:errors path="confPassword" /></span>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <form:hidden path="code"/>
                                        <button type="submit" class="btn btn-primary">Change Password</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form:form>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>