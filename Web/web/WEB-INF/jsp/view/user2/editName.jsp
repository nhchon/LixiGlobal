<template:Client htmlTitle="Lixi Global - Edit Your Name">

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
        <section class="main-section bg-default">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
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
                        <h2 class="title"><spring:message code="signup.change_your_name"/>:</h2>
                        <div class="form-group">
                            <div class="col-lg-12 col-md-12">
                                <label class="control-label"><spring:message code="signup.my_new_name"/></label>
                            </div>
                        </div>
                        <div class="form-group">
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
                        <div class="form-group right">
                            <div class="col-lg-12">
                                <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="message.save_changes"/></button>
                                <button type="button" class="btn btn-warning btn-has-link-event" data-link="<c:url value="/user/yourAccount"/>">Cancel</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>