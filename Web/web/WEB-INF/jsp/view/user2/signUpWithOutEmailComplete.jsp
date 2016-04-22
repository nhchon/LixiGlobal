<template:Client htmlTitle="Lixi Global - Sign Up Complete">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="title"><spring:message code="mess.thank-you"/></h2>
                        <p><spring:message code="mess.c-thank-you-for-regis"/></p>
                        <p>
                            <c:url value="/user/signIn" var="signInUrl"/>
                            <c:url value="/support/post?method=Email" var="supportUrl"/>
                            <spring:message code="mess.login-to-start" arguments="${signInUrl}"/>. <spring:message code="mess.contact-customer-service-href" arguments="${supportUrl}"/>.
                        </p>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>