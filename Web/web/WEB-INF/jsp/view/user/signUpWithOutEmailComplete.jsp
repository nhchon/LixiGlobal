<template:Client htmlTitle="LiXi Global - Sign Up Complete">

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
                        <p>Thank you for registering account at Lixi.Global</p>
                        <p>
                            Please <a href="<c:url value="/user/signIn"/>">click here to login</a>. You may aslo contact
                            <a href="help.html">Customer Service</a> for help.
                        </p>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>