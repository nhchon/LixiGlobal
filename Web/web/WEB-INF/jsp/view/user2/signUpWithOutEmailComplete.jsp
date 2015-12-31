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
                        <h2 class="title">Thank you</h2>
                        <p>Thank you for registering account at Lixi.Global</p>
                        <p>
                            Please <a href="<c:url value="/user/signIn"/>">click here to login</a>. You may aslo contact
                            <a href="help.html">Customer Service</a> for help.
                        </p>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>