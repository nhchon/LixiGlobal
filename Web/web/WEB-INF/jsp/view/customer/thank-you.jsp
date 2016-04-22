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
        <section class="normal-page">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <h1><spring:message code="mess.thank-you"/></h1>
                        <p><spring:message code="mess.thank-your-info"/>.</p>
                        <p>
                            <spring:message code="mess.we-contact-asap"/>.
                            <c:url value="/support/post?method=Email" var="supportUrl"/>
                            <spring:message code="mess.contact-customer-service-href" arguments="${supportUrl}"/>.
                        </p>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>