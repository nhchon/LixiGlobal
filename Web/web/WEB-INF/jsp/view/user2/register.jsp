<template:Client htmlTitle="Home - Lixi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            var FIRST_NAME_MESSAGE = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_MESSAGE = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var PASS_MESSAGE = '<spring:message code="validate.password_required"/>';
            var PHONE_REQUIRED = '<spring:message code="validate.phone_required" text="The phone number is required."/>';
            var PASSWORD_ASSISTANCE_PATH = '<c:url value="/user/passwordAssistance"/>';
            
            jQuery(document).ready(function () {
                LixiGlobal.RegisterPage.init();
                $("#phone").mask("(999) 999-999?9");
            })
        </script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/register.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default section-wrapper" style="padding:62px 0;">
            <div class="container">
                <div class="row">
                    <div class="row-height">
                        <div class="col-md-6 col-height border-right">
                            <div class="login-wrapper">
                                <c:if test="${validationErrors != null}">
                                    <div class="alert-message" style="min-height:45px;">
                                        <h4 class="text-red">There was problem</h4>
                                        <c:forEach items="${validationErrors}" var="error">
                                            <div><c:out value="${error.message}" /></div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <c:if test="${notActivated eq 1}">
                                    <div class="alert alert-danger" role="alert">
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        <span class="sr-only">Error:</span>
                                        <c:url value="/user/registrationConfirm/not-activated-yet" var="registrationConfirm"/>
                                        <spring:message code="signin.not_activated" arguments="${registrationConfirm}"/>
                                    </div>
                                </c:if>
                                <c:if test="${notEnabled eq 1}">
                                    <div class="alert alert-danger" role="alert">
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        <span class="sr-only">Error:</span>
                                        <spring:message code="signin.not_enabled"/>
                                    </div>
                                </c:if>
                                <c:if test="${signInFailed eq 1 || param.signInFailed eq 1}">
                                    <div class="alert alert-danger" role="alert">
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        <span class="sr-only">Error:</span>
                                        <spring:message code="signin.failed"/>
                                    </div>
                                </c:if>
                                <c:if test="${param.signInFailed eq 2}">
                                    <div class="alert alert-danger" role="alert">
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        <span class="sr-only">Error:</span>
                                        <spring:message code="sess-expired"/>
                                    </div>
                                </c:if>
                                <c:if test="${param.signInFailed eq 3}">
                                    <div class="alert alert-danger" role="alert">
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        <span class="sr-only">Error:</span>
                                        <spring:message code="please-sign-in"/>
                                    </div>
                                </c:if>

                                <h3 class="title"><spring:message code="mess.login"/></h3>
                                <c:url value="/user/signIn" var="signInFormUrl"/>
                                <form:form method="post" action="${signInFormUrl}" cssClass="form-horizontal" modelAttribute="userSignInForm" autocomplete="off">
                                    <p><spring:message code="mess.if-already-registered"/></p>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <form:input path="email" cssErrorClass="form-control input-error" cssClass="form-control" required="true" placeholder="User Name"/>
                                            <div class="has-error"><form:errors path="email" cssClass="error-message" element="div"/></div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <form:password path="password" cssErrorClass="form-control input-error" cssClass="form-control" required="true" placeholder="Password"/>
                                            <div class="has-error"><form:errors path="password" cssClass="help-block" element="div"/></div>
                                        </div>
                                    </div>
                                    <p>
                                        <a href="#"  data-toggle="modal" data-target="#myModal"><spring:message code="mess.forgot-pass"/>?</a>
                                    </p>
                                    <div class="button-control">
                                        <input type="hidden" name="nextUrl" value="${param.nextUrl}"/>
                                        <button type="submit" class="btn btn-primary"><spring:message code="mess.clogin"/></button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                        <div class="col-md-6 col-height">
                            <div class="register-wrapper">
                                <h3 class="title"><spring:message code="mess.new-to-lixi"/>?</h3>
                                <c:if test="${action eq 'login'}"><button id="btnShowRegister" type="button" class="btn btn-primary"><spring:message code="mess.c-create-account"/></button></c:if>
                                <div id="divRegister" style="display: <c:if test="${action eq 'login'}">none;</c:if>">
                                    <h4><spring:message code="mess.c-create-account-with-lixi"/></h4>
                                    <p><sup>*</sup><spring:message code="mess.all-fields-required"/></p>
                                    <%-- place holder message --%>
                                    <spring:message code="message.first_name" var="firstNameMessage"/>
                                    <spring:message code="message.middle_ini" var="middleMessage"/>
                                    <spring:message code="message.last_name" var="lastNameMessage"/>
                                    <spring:message code="message.email_place_holder" var="emailMessage"/>
                                    <spring:message code="signup.retype_email" var="retypeEmailMessage"/>
                                    <spring:message code="message.password_format" var="passwordMessage"/>
                                    <spring:message code="mess.re-your-pass" var="reTypePass"/>
                                    <spring:message code="phone-example" var="phoneMessage"/>
                                    <c:url value="/user/signUp" var="signUpFormUrl"/>
                                    <form:form class="form-horizontal" action="${signUpFormUrl}" modelAttribute="userSignUpForm" cssClass="register-form">
                                        <div class="form-group">
                                            <form:input class="form-control" path="firstName" placeholder="${firstNameMessage}"/>
                                            <div class="has-error"><form:errors path="firstName" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="form-group">
                                            <form:input path="middleName" class="form-control" placeholder="${middleMessage}"/>
                                            <div class="has-error"><form:errors path="middleName" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="form-group">
                                            <form:input path="lastName" class="form-control" placeholder="${lastNameMessage}"/>
                                            <div class="has-error"><form:errors path="lastName" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="email" class="form-control" path="email" placeholder="${emailMessage}"/>
                                            <div class="has-error"><form:errors path="email" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="password" id="passwordSignUp" class="form-control" path="password" placeholder="${passwordMessage}"/>
                                            <div class="has-error"><form:errors path="password" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="password" class="form-control" path="confPassword" placeholder="${reTypePass}"/>
                                            <div class="has-error"><form:errors path="confPassword" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-2" style="padding-right: 0px;">
                                                    <form:select class="form-control" path="dialCode">
                                                        <option value="+1" <c:if test="${userSignUpForm.dialCode eq '+1'}">selected=""</c:if>>+1</option>
                                                        <option value="+84" <c:if test="${userSignUpForm.dialCode eq '+84'}">selected=""</c:if>>+84</option>
                                                    </form:select>
                                                    </div>
                                                <div class="col-md-10" style="padding-left: 0px;">
                                                    <form:input path="phone" class="form-control" placeholder="${phoneMessage}"/>
                                                    <div class="has-error"><form:errors path="phone" cssClass="help-block" element="div"/></div>
                                                </div>
                                            </div>
                                            <%--<form:input class="form-control bfh-phone" data-format="+1 (ddd) ddd-dddd" path="phone" placeholder="${phoneMessage}"/>--%>
                                            <%--<div class="has-error"><form:errors path="phone" cssClass="help-block" element="div"/></div>--%>
                                        </div>
                                        <div class="checkbox">
                                            <c:url value="/support/terms" var="termsUrl"/>
                                            <c:url value="/support/privacy" var="privacyUrl"/>
                                            <label><form:checkbox path="agree" checked="" value="yes"/> <spring:message code="regis.agree" arguments="${termsUrl}, ${privacyUrl}"></spring:message></label>
                                            <div class="has-error"><form:errors path="agree" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="button-control">
                                            <button type="submit" class="btn btn-primary"><spring:message code="mess.c-create-account"/></button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 id="headerForgotPassword" class="modal-title"><spring:message code="message.forgot_password"/></h4>
                            <p id="descForgotPassword"><spring:message code="message.forgot_password_no_problem" text=""/></p>
                        </div>
                        <div class="modal-body" id="resetPasswordBody">
                            <form role="form">
                                <div class="form-group">
                                    <label for="email"><spring:message code="mess.email-address"/>:</label>
                                    <input type="email" class="form-control" id="email4ResetPassword" placeholder="your.name@example.com">
                                </div>
                                    <button id="resetPasswordBtn" type="button" class="btn btn-primary"><spring:message code="mess.send-reset-pass-link"/></button>
                                <input type="hidden" id="csrfSpring" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </form>
                        </div>
                        <div class="modal-footer">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>            
