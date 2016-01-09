<template:Client htmlTitle="Lixi Global - Change Your Password">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class="main-section bg-default">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <c:if test="${validationErrors != null}">
                        <div class="msg msg-error">
                            <ul>
                                <c:forEach items="${validationErrors}" var="error">
                                    <li><c:out value="${error.message}" /></li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${editSuccess eq 0 || param.editSuccess eq 0}">
                        <div class="alert alert-danger">
                            <spring:message code="message.wrong_password"/>
                        </div>
                    </c:if>
                    <spring:message code="message.password_format" var="passwordMessage"/>
                    <form:form role="form" modelAttribute="userEditPasswordForm">
                        <h2 class="title"><spring:message code="message.change_password"/></h2>
                        <div class="desc">
                            <spring:message code="message.change_password_desc"/>
                        </div>
                        <br/>
                        <div class="form-group">
                            <div class="col-md-8">
                                <label for="currentPassword" class="control-label">Current password</label>
                                <form:password  path="currentPassword" class="form-control"/>
                                <div class="has-error"><form:errors path="currentPassword" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-8">
                                <label for="password" class="control-label">New password</label>
                                <form:password path="password" class="form-control" placeholder="${placeholder}"/>
                                <div class="has-error"><form:errors path="password" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label for="confPassword" class="control-label">Reenter new password:</label>
                                <form:password path="confPassword" class="form-control"/>
                                <div class="has-error"><form:errors path="confPassword" cssClass="help-block" element="div"/></div>
                            </div>
                        </div>
                        <div class="form-group right">
                            <div class="col-md-8">
                                <button id="btnSubmit" class="btn btn-primary">Save Changes</button>
                                <button type="button" class="btn btn-warning btn-has-link-event" data-link="<c:url value="/user/yourAccount"/>">Cancel</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>