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
                <div class="text-center">
                    <h2 class="title"><spring:message code="mess.c-thank-you-for-regis"/></h2>
                    <p><spring:message code="signup.an_email_was_sent" arguments="${email}"/></p>
                    <p><spring:message code="mess.activation-code-be-expired"/>.</p>
                    <p>
                        <c:url value="/support/post" var="supportUrl"/>
                        <spring:message code="mess.be-sure-to-check-your-spam-filter"/>. <spring:message code="mess.contact-customer-service-href" arguments="${supportUrl}"/>.
                    </p>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>