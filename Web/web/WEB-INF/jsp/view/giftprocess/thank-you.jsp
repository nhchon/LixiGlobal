<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="email-already-in-use" class="normal-page">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <h1>Thank you!</h1>
                        <br />
                        <p>Your order confirmation number is XYZ123456789. An email has been sent to you and the receiver of your gift in Vietnam.</p>
                        <br />
                        <p>The recipient will be notified within the hour of the gift waiting for them at www.baokim.vn. He or she will need to log in to claim the gift. Once the gift is reveived by the receiver, you will be notified.</p>
                        <br />
                        <p>Email us with any questions at <a href="mailto:support@lixi.global">support@lixi.global</a>. Please paste the order confirmation number to the subject line.</p>
                        <br /><br /><br />
                        <div class="btns">
                            <a href="<c:url value="/gifts/recipient"/>" class="btn btn-primary">Continue Giving</a>
                            <a href="<c:url value="/user/signOut"/>" class="btn btn-primary">Log Out</a>
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>