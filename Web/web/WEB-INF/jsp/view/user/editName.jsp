<template:Client htmlTitle="LiXi Global - Edit Your Name">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            /** Page Script **/
            var FIRST_NAME_MESSAGE = '<spring:message code="validate.user.firstName"/>';
            var LAST_NAME_MESSAGE = '<spring:message code="validate.user.lastName"/>';
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var PASS_MESSAGE = '<spring:message code="validate.password_required"/>';

            $(document).ready(function () {
                $('#btnSubmit').click(function () {

                    // check first name
                    if ($.trim($('#firstName').val()) === '') {

                        alert(FIRST_NAME_MESSAGE);
                        $('#firstName').focus();
                        return false;

                    }
                    // lastname
                    if ($.trim($('#lastName').val()) === '') {

                        alert(LAST_NAME_MESSAGE);
                        $('#lastName').focus();
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
                        <%-- place holder message --%>
                        <%-- // End place holder message --%>
                        <form:form class="form-horizontal" modelAttribute="userEditNameForm">
                            <fieldset>
                                <legend><spring:message code="signup.change_your_name"/></legend>
                                <div class="form-group">
                                    <div class="col-lg-12 col-md-12">
                                        <label class="control-label"><spring:message code="signup.my_new_name"/></label>
                                    </div>
                                </div>
                                <div class="form-group">
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
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="message.save_changes"/></button>
                                    </div>
                                </div>
                            </fieldset>
                        </form:form>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>