<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/intlTelInput.css"/>" type="text/css" />
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/registration.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="registration">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <%-- place holder message --%>
                        <spring:message code="message.first_name" var="firstNameMessage"/>
                        <spring:message code="message.middle_ini" var="middleMessage"/>
                        <spring:message code="message.last_name" var="lastNameMessage"/>
                        <spring:message code="message.email_place_holder" var="emailMessage"/>
                        <spring:message code="signup.retype_email" var="retypeEmailMessage"/>
                        <spring:message code="signin.at_least_password" var="passwordMessage"/>
                        <%-- // End place holder message --%>
                        <form:form class="form-horizontal" modelAttribute="userSignUpForm">
                            <fieldset>
                                <legend><spring:message code="message.registration"/></legend>
                                <div class="desc">
                                    <spring:message code="signup.new_to_lixi"/>
                                </div>
                                <div class="form-group name">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.my_name_is"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <div class="row">
                                            <div class="col-lg-4">
                                                <form:input class="form-control" path="firstName" placeholder="${firstNameMessage}"/>
                                                <span class="help-block errors "><form:errors path="firstName" /></span>
                                            </div>
                                            <div class="col-lg-4">
                                                <form:input class="form-control" path="middleName" placeholder="${middleMessage}"/>
                                                <span class="help-block errors"><form:errors path="middleName" /></span>
                                            </div>
                                            <div class="col-lg-4">
                                                <form:input path="lastName" class="form-control" placeholder="${lastNameMessage}"/>
                                                <span class="help-block errors"><form:errors path="lastName" /></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.my_email"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="email" class="form-control" path="email" placeholder="${emailMessage}"/>
                                        <span class="help-block errors"><form:errors path="email" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.type_again"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="email" class="form-control" path="confEmail" placeholder="${retypeEmailMessage}"/>
                                        <span class="help-block errors"><form:errors path="confEmail" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.my_mobile"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="text" class="form-control" path="phone" placeholder="Phone"/>
                                    </div>
                                </div>
                                <div class="desc">
                                    <spring:message code="signup.protect_your_info"/>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.enter_password"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="password" class="form-control" path="password" placeholder="${passwordMessage}"/>
                                        <span class="help-block errors"><form:errors path="password" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.type_again"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="password" class="form-control" path="confPassword" placeholder="${passwordMessage}"/>
                                        <span class="help-block errors"><form:errors path="confPassword" /></span>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <button type="submit" class="btn btn-primary"><spring:message code="signup.register"/></button>
                                    </div>
                                </div>
                            </fieldset>
                        </form:form>
                        <br />
                        <div id="desc">
                            Be creating account, you agree to <a href="javascript:void(0)">lixi.global's Conditions of Use and Privacy Notice</a>.
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>