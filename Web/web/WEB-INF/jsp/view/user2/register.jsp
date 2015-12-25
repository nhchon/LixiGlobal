<template:Client htmlTitle="Home - LiXi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/register.js"/>"></script>
        <script type="text/javascript">
            var FIRST_NAME_MESSAGE = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_MESSAGE = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var PASS_MESSAGE = '<spring:message code="validate.password_required"/>';
            jQuery(document).ready(function () {
                LixiGlobal.RegisterPage.init();
            })
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default section-wrapper" style="padding:62px 0;">
            <div class="container">
                <div class="row">
                    <div class="row-height">
                        <div class="col-md-6 col-height border-right">
                            <div class="login-wrapper">
                                <c:if test="${validationErrors != null}">
                                    <div class="alert-message">
                                        <h4 class="text-red">There was problem</h4>
                                        <c:forEach items="${validationErrors}" var="error">
                                            <div><c:out value="${error.message}" /></div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <c:if test="${notActivated eq 1}">
                                    <div class="alert-message">
                                        <c:url value="/user/registrationConfirm/not-activated-yet" var="registrationConfirm"/>
                                        <spring:message code="signin.not_activated" arguments="${registrationConfirm}"/>
                                    </div>
                                </c:if>
                                <c:if test="${notEnabled eq 1}">
                                    <div class="alert-message">
                                        <spring:message code="signin.not_enabled"/>
                                    </div>
                                </c:if>
                                <c:if test="${signInFailed eq 1 || param.signInFailed eq 1}">
                                    <div class="alert alert-warning alert-dismissible bg-white" role="alert">
                                    <div class="alert-message">
                                        <spring:message code="signin.failed"/>
                                    </div>
                                    </div>
                                </c:if>
                                
                                <h3 class="title">Login</h3>
                                <c:url value="/user/signIn" var="signInFormUrl"/>
                                <form:form method="post" action="${signInFormUrl}" cssClass="form-horizontal" modelAttribute="userSignInForm" autocomplete="off">
                                    <p>If you have already registered with LIXI GLOBAL, please sign in here</p>
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
                                        <a href="#">Forgotten your password?</a>
                                    </p>
                                    <div class="button-control">
                                        <button type="submit" class="btn btn-primary">LOGIN</button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                        <div class="col-md-6 col-height">
                            <div class="register-wrapper">
                                <h3 class="title">New to Lixi.Global?</h3>
                                <c:if test="${action eq 'login'}"><button id="btnShowRegister" type="button" class="btn btn-primary">CREATE ACCOUNT</button></c:if>
                                <div id="divRegister" style="display: <c:if test="${action eq 'login'}">none;</c:if>">
                                    <h4>CREATE AN ACCOUNT WITH LIXI GLOBAL</h4>
                                    <p><sup>*</sup>All form fields are mandatory</p>
                                    <%-- place holder message --%>
                                    <spring:message code="message.first_name" var="firstNameMessage"/>
                                    <spring:message code="message.middle_ini" var="middleMessage"/>
                                    <spring:message code="message.last_name" var="lastNameMessage"/>
                                    <spring:message code="message.email_place_holder" var="emailMessage"/>
                                    <spring:message code="signup.retype_email" var="retypeEmailMessage"/>
                                    <spring:message code="message.password_format" var="passwordMessage"/>
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
                                            <form:input type="password" class="form-control" path="confPassword" placeholder="Retype your password"/>
                                            <div class="has-error"><form:errors path="confPassword" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="text" class="form-control" path="phone" placeholder="Phone"/>
                                            <div class="has-error"><form:errors path="phone" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="checkbox">
                                            <label><form:checkbox path="agree" checked="" value="yes"/> <spring:message code="regis.agree" text="By Creating an Account, you agree to the Terms of Use and Privacy Policy."/></label>
                                            <div class="has-error"><form:errors path="agree" cssClass="help-block" element="div"/></div>
                                        </div>
                                        <div class="button-control">
                                            <button type="submit" class="btn btn-primary">CREATE ACCOUNT</button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div></section>
        </jsp:body>
    </template:Client>            
