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
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="row">
                    <div class="col-md-12">
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
                        <form:form class="form-horizontal" modelAttribute="userSignUpWithOutEmailForm">
                                <h2 class="title"><spring:message code="message.registration"/></h2>
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
                                                <div class="has-error"><form:errors path="firstName" cssClass="help-block" element="div"/></div>
                                            </div>
                                            <div class="col-lg-4">
                                                <form:input class="form-control" path="middleName" placeholder="${middleMessage}"/>
                                                <div class="has-error"><form:errors path="middleName" cssClass="help-block" element="div"/></div>
                                            </div>
                                            <div class="col-lg-4">
                                                <form:input path="lastName" class="form-control" placeholder="${lastNameMessage}"/>
                                                <div class="has-error"><form:errors path="lastName" cssClass="help-block" element="div"/></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.my_email"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="email" class="form-control" readonly="true"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.type_again"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="confEmail" class="form-control" readonly="true"/>
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
                                <div class="form-group" id="pwd-container">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.enter_password"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="password" class="form-control" path="password" placeholder="${passwordMessage}"/>
                                        <div class="has-error"><form:errors path="password" cssClass="help-block" element="div"/></div>
                                        <div class="pwstrength_viewport_progress"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="signup.type_again"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input type="password" class="form-control" path="confPassword" placeholder="${passwordMessage}"/>
                                        <div class="has-error"><form:errors path="confPassword" cssClass="help-block" element="div"/></div>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-4 col-md-4"></div>
                                    <div class="col-lg-8">
                                        <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="signup.register"/></button>
                                    </div>
                                </div>
                        </form:form>
                        <br />
                        <div id="desc">
                            <spring:message code="regis.agree" arguments="${termsUrl}, ${privacyUrl}"></spring:message>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>