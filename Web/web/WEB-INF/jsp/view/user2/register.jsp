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
                                <h3 class="title">Login</h3>
                                <form:form method="post" cssClass="form-horizontal" modelAttribute="userSignInForm" autocomplete="off">
                                    <p>If you have already registered with LIXI GLOBAL, please sign in here</p>
                                    <div class="form-group">
                                        <form:input path="email" cssClass="form-control" required="true" placeholder="User Name"/>
                                    </div>
                                    <div class="form-group">
                                        <form:input path="password" cssClass="form-control" required="true" placeholder="Password"/>
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
                                    <form:form class="form-horizontal" modelAttribute="userSignUpForm" cssClass="register-form">
                                        <div class="form-group">
                                            <form:input class="form-control" path="firstName" placeholder="${firstNameMessage}"/>
                                            <form:errors path="firstName" cssClass="jquery-validate-error help-block" element="div"/>
                                        </div>
                                        <div class="form-group">
                                            <form:input path="lastName" class="form-control" placeholder="${lastNameMessage}"/>
                                            <form:errors path="lastName" cssClass="jquery-validate-error help-block" element="div"/>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="email" class="form-control" path="email" placeholder="${emailMessage}"/>
                                            <form:errors path="email" cssClass="jquery-validate-error help-block" element="div"/>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="password" class="form-control" path="password" placeholder="${passwordMessage}"/>
                                            <form:errors path="password" cssClass="jquery-validate-error help-block" element="div"/>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="password" class="form-control" path="confPassword" placeholder="${passwordMessage}"/>
                                            <form:errors path="confPassword" cssClass="jquery-validate-error help-block" element="div"/>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="text" class="form-control" path="phone" placeholder="Phone"/>
                                            <form:errors path="phone" cssClass="jquery-validate-error help-block" element="div"/>
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
