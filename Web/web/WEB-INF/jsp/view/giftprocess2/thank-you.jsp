<template:Client htmlTitle="Lixi Global - Thank you for you shipping">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <c:import url="/categories"/>
        <section class="section-gift bg-default main-section">
            <div class="container">
                <c:set var="localStep" value="7"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="section-receiver">
                    <h1>Thank you!</h1>
                    <br />
                    <p>Your order confirmation number is <strong>${LIXI_ORDER_ID}</strong>. An email has been sent to you and the receiver of your gift in Vietnam.</p>
                    <br />
                    <p>The recipient will be notified within the hour of the gift waiting for them at www.baokim.vn. He or she will need to log in to claim the gift. Once the gift is reveived by the receiver, you will be notified.</p>
                    <br />
                    <p>Email us with any questions at <a href="mailto:support@lixi.global">support@lixi.global</a>. Please paste the order confirmation number to the subject line.</p>
                    <br /><br /><br />
                    <div class="btns">
                        <a href="<c:url value="/gifts/choose"/>" class="btn btn-primary">Continue Giving</a>
                        <a href="<c:url value="/user/signOut"/>" class="btn btn-primary">Log Out</a>
                    </div>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>