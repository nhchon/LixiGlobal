<template:Client htmlTitle="Lixi Global - Email address already in use">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="alert alert-warning" role="alert">
                                <strong><spring:message code="mess.email-in-use"/></strong><br/>
                                <spring:message code="mess.new-customer-exists-email" arguments="${inUseEmail}"/>
                            </div>
                                <h4><spring:message code="mess.return-cus"/>?</h4>
                                <a href="<c:url value="/user/signIn"/>"><spring:message code="message.sign_in"/></a><br/>
                                <a href="<c:url value="/user/passwordAssistance2"/>"><spring:message code="message.forgot_your_password"/>?</a>

                                <h4><spring:message code="mess.new-to-lixi"/>?</h4>
                                <div><spring:message code="mess.new-account-with"/> &nbsp;<a href="<c:url value="/user/signUp"/>"><spring:message code="mess.a-diff-email"/></a></div>
                                <div><spring:message code="mess.new-account-with"/> &nbsp;<a href="javascript:postInvisibleForm('<c:url value="/user/verifyThisEmail"/>', {inUseEmail:'${inUseEmail}'});"><spring:message code="mess.this-email"/></a></div>

                                <h4><spring:message code="mess.still-need-help"/>?</h4>
                                <a href="<c:url value="/support/post?method=Email"/>"><spring:message code="mess.c-c-s"/></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>