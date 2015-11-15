<template:Client htmlTitle="LiXi Global - Check your email">

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
                        <h1>Thank you</h1>
                        <p><spring:message code="signup.an_email_was_sent" arguments="${email}"/></p>
                        <p>Thank you for your information.</p>
                        <p>
                            We will contact you as soon as possible.
                            <a href="help.html">Customer Service</a> for help.
                        </p>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>