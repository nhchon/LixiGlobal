<template:Client htmlTitle="Lixi Global - Sign Up Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/registration.css"/>" type="text/css" />
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
            var FIRST_NAME_MESSAGE = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_MESSAGE = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var PASS_MESSAGE = '<spring:message code="validate.password_required"/>';
            
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
            
                $('#btnSubmit').click(function(){
                   
                    // check first name
                    if($.trim($('#firstName').val()) === ''){
                        
                        alert(FIRST_NAME_MESSAGE);
                        $('#firstName').focus();
                        return false;
                        
                    }
                    // lastname
                    if($.trim($('#lastName').val()) === ''){
                        
                        alert(LAST_NAME_MESSAGE);
                        $('#lastName').focus();
                        return false;
                        
                    }
                    // email
                    if(!$('#email').isValidEmailAddress()){
                        
                        alert(EMAIL_MESSAGE);
                        $('#email').focus();
                        return false;
                    }
                    // confEmail
                    if(!$('#confEmail').isValidEmailAddress()){
                        
                        alert(EMAIL_MESSAGE);
                        $('#confEmail').focus();
                        return false;
                    }
                    // password
                    if(!$('#password').isValidPassword()){
                        
                        alert(PASS_MESSAGE);
                        $('#password').focus();
                        return false;
                    }
                    
                    // conf password
                    if(!$('#confPassword').isValidPassword()){
                        
                        alert(PASS_MESSAGE);
                        $('#confPassword').focus();
                        return false;
                    }
                    
                    //
                    return true;
                });
            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="registration">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                    <c:if test="${validationErrors != null}"><div class="msg msg-error">
                        <ul style="margin-bottom: 0px;">
                            <c:forEach items="${validationErrors}" var="error">
                                <li><c:out value="${error.message}" /></li>
                            </c:forEach>
                        </ul>
                    </div></c:if>
                        <%-- place holder message --%>
                        <spring:message code="message.first_name" var="firstNameMessage"/>
                        <spring:message code="message.middle_ini" var="middleMessage"/>
                        <spring:message code="message.last_name" var="lastNameMessage"/>
                        <spring:message code="message.email_place_holder" var="emailMessage"/>
                        <spring:message code="signup.retype_email" var="retypeEmailMessage"/>
                        <spring:message code="message.password_format" var="passwordMessage"/>
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
                                        <form:input  class="form-control bfh-phone" data-format="+1 (ddd) ddd-dddd" path="phone" placeholder="Phone"/>
                                    </div>
                                </div>
                                <div class="desc">
                                    <spring:message code="signup.protect_your_info"/>
                                </div>
                                <div class="form-group" id="pwd-container">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.enter_password"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="password" class="form-control" path="password" placeholder="${passwordMessage}"/>
                                        <span class="help-block errors"><form:errors path="password" /></span>
                                        <div class="pwstrength_viewport_progress"></div>
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
                                        <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="signup.register"/></button>
                                    </div>
                                </div>
                            </fieldset>
                        </form:form>
                        <br />
                        <div id="desc">
                            Be creating account, you agree to <a href="<c:url value="/support/terms"/>">lixi.global's Conditions of Use</a> and <a href="<c:url value="/support/privacy"/>">Privacy Notice</a>.
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>