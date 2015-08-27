<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <style>
            .progress{
                margin-bottom: 0px;
            }
        </style>
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/plugins/pwstrength/pwstrength.js"/>"></script>
        <script type="text/javascript">
            var NAME_MESSAGE = '<spring:message code="validate.trader.name"/>';
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var PHONE_MESSAGE = '<spring:message code="validate.phone_required"/>';
            var USERNAME_MESSAGE = '<spring:message code="validate.username_required"/>';
            var PASS_MESSAGE = '<spring:message code="validate.password_required"/>';
            /** Page Script **/
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
                    
                    if($.trim($('#name').val()) === ''){
                        
                        alert(NAME_MESSAGE);
                        $('#name').focus();
                        return false;
                        
                    }
                    // email
                    if(!$('#email').isValidEmailAddress()){
                        
                        alert(EMAIL_MESSAGE);
                        $('#email').focus();
                        return false;
                    }
                    // phone
                    if($.trim($('#phone').val()) === ''){
                        
                        alert(PHONE_MESSAGE);
                        $('#phone').focus();
                        return false;
                        
                    }
                    // username
                    if($.trim($('#username').val()).length < 6){
                        
                        alert(USERNAME_MESSAGE);
                        $('#username').focus();
                        return false;
                        
                    }
                    // password
                    // password
                    if(!$('#password').isValidPassword()){
                        
                        alert(PASS_MESSAGE);
                        $('#password').focus();
                        return false;
                    }
                    
                    return true;
                });
            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-85-0">
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
                        <form:form method="post" role="form" modelAttribute="traderCreateForm">
                            <fieldset>
                                <legend>Trader Registration</legend>
                                <div class="desc">
                                    <spring:message code="signup.new_to_lixi"/>
                                </div>
                                <div class="form-group">
                                    <label for="name"><spring:message code="trader.your_name"/>:</label>
                                    <form:input path="name" class="form-control"/>
                                    <span class="help-block with-errors errors"><form:errors path="name" /></span>
                                </div>
                                <div class="form-group">
                                    <label for="email"><spring:message code="message.email"/>:</label>
                                    <form:input path="email" class="form-control"/>
                                    <span class="help-block with-errors errors"><form:errors path="email" /></span>
                                </div>
                                <div class="form-group">
                                    <label for="phone"><spring:message code="message.phone"/>:</label>
                                    <form:input path="phone" class="form-control"/>
                                    <span class="help-block with-errors errors"><form:errors path="phone" /></span>
                                </div>

                                <div><p><spring:message code="trader.your_account_information"/></p></div>

                                <div class="form-group">
                                    <label for="username"><spring:message code="message.username"/>:</label>
                                    <form:input path="username" class="form-control"/>
                                    <span class="help-block with-errors errors"><form:errors path="username" /></span>
                                </div>
                                <div class="form-group">
                                    <label for="password"><spring:message code="message.password"/>:</label>
                                    <form:password path="password" class="form-control"/>
                                    <span class="help-block with-errors errors"><form:errors path="password" /></span>
                                    <div class="pwstrength_viewport_progress"></div>
                                </div>

                                <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="message.create_account"/></button>
                            </fieldset>
                        </form:form>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>