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
                        <h1>Check your email</h1>
                        <p><spring:message code="signup.an_email_was_sent" arguments="${email}"/></p>
                        <p>Please remember that the activation code will be expired after one day.</p>
                        <p>
                            Be sure to check your spam filter if you can’t find the email in
                            your inbox. You may aslo contact
                            <a href="help.html">Customer Service</a> for help.
                        </p>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>