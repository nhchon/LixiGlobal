<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <c:if test="${activeResult eq 1}">
                    <h2 class="title"><spring:message code="regis.thank_you"/></h1>
                    <p><spring:message code="regis.success"/></p>
                    <c:set var="signInUrl" value="${pageContext.request.contextPath}/user/signIn"/>
                    <p><spring:message code="regis.success_click" arguments="${signInUrl}"/></p>
                </c:if>

                <c:if test="${codeWrong eq 1 || codeExpired eq 1}">
                    <h2 class="title"><spring:message code="regis.sorry"/></h1>
                    <div class="msg msg-error"><spring:message code="regis.wrong"/></div>
                    <h5><spring:message code="regis.resend_code"/></h5>
                    <div class="row">
                        <form class="form-horizontal" action="${pageContext.request.contextPath}/user/sendActiveCode" autocomplete="off" method="post">
                            <div class="col-lg-5 col-md-5 col-sm-5">
                                <input type="email" name="email" placeholder="Enter your email" class="form-control"/>
                            </div>
                            <div class="col-lg-7 col-md-7 col-sm-7">
                                <button type="submit" class="btn btn-primary">Send</button>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                    </div>
                    <p style="margin-top: 10px;">
                        Be sure to check your spam filter if you can’t find the email in
                        your inbox. You may aslo contact
                        <a href="help.html">Customer Service</a> for help.
                    </p>
                </c:if>

            </div>
        </section>
    </jsp:body>
</template:Client>