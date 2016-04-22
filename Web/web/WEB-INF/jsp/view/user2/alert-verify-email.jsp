<template:Client htmlTitle="Lixi Global - An email was sent">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="row">
                    <div class="col-md-12">
                        <p><spring:message code="mess.email-was-sent-to" arguments="${inUseEmail}"/>. <spring:message code="mess.in-order-to-complete"/></p>
                        
                        <p>
                            <spring:message code="mess.be-sure-to-check-your-spam-filter"/>. 
                            <c:url value="/support/post?method=Email" var="supportUrl"/>
                            <spring:message code="mess.contact-customer-service-href" arguments="${supportUrl}"/>.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>