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
                    <h1><spring:message code="mess.thank-you"/>!</h1>
                    <br />
                    <p><spring:message code="thank-1" arguments="${LIXI_ORDER_ID}"/>. <spring:message code="thank-2"/>.</p>
                    <br />
                    <p><spring:message code="thank-3"/>. <spring:message code="thank-4"/>. <spring:message code="thank-5"/>.</p>
                    <br />
                    <p><spring:message code="thank-6"/>. <spring:message code="thank-7"/>.</p>
                    <br /><br /><br />
                    <div class="btns" style="text-align:center;">
                        <a href="<c:url value="/gifts/choose"/>" class="btn btn-primary"><spring:message code="continue-giving"/></a>
                        <a href="<c:url value="/user/signOut"/>" class="btn btn-warning"><spring:message code="log-out"/></a>
                    </div>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>