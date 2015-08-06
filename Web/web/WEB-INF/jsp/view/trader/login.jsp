<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/sign-in.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section id="sign-in">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-8 col-md-8 col-sm-10 col-xs-12">
                        <c:if test="${validationErrors != null}"><div class="msg msg-error">
                                <ul style="margin-bottom: 0px;">
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div></c:if>
                        <c:if test="${not empty LOGIN_FAILED}">
                            <div class="msg msg-error">
                                <ul>
                                    <li><spring:message code="validate.login.cannot" /></li>
                                </ul>
                            </div>
                        </c:if>
                        <form:form method="post" role="form" modelAttribute="traderLoginForm" autocomplete="off">
                            <fieldset>
                                <legend>Welcome ! Traders</legend>
                                <div class="form-group">
                                    <label for="username"><spring:message code="message.username"/>:</label>
                                    <form:input path="username" class="form-control"/>
                                    <span class="help-block with-errors errors"><form:errors path="username" /></span>
                                </div>
                                <div class="form-group">
                                    <label for="password"><spring:message code="message.password"/>:</label>
                                    <form:password path="password" class="form-control"/>
                                    <span class="help-block with-errors errors"><form:errors path="password" /></span>
                                </div>
                                
                                <div class="form-group" style="padding-bottom: 15px;">
                                    <div class="col-lg-6" style="padding-left: 0px;">
                                        <a href="<c:url value="/trader/create"/>">Don't have an account ?</a>
                                    </div>
                                    <div class="col-lg-6" style="text-align: right; padding-right: 0px;">
                                        <a class="forgot-password" href="<c:url value="/user/passwordAssistance"/>"><spring:message code="message.forgot_password"/></a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-12" style="text-align: right; padding-right: 0px;">
                                        <button type="submit" class="btn btn-primary"><spring:message code="message.sign_in"/></button>
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