<template:Client htmlTitle="Lixi Global - Check your email">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h1><spring:message code="mess.thank-you"/></h1>
                    <p><spring:message code="mess.thank-your-info"/>.</p>
                    <p>
                        <spring:message code="mess.we-contact-asap"/>.
                        <c:url value="/support/post?method=Email" var="supportUrl"/>
                        <spring:message code="mess.contact-customer-service-href" arguments="${supportUrl}"/>.
                    </p>
                </div>
            </div>
        </section>   

    </jsp:body>
</template:Client>