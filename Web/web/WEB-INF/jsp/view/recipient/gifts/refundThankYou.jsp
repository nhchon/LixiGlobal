<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle=" - Lixi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <div class="row">
                        <div class="col-md-12">
                            <p>Dear ${sessionScope['scopedTarget.loginedUser'].firstName}</p>
                            <p><spring:message code="tk-r-01"/>. <spring:message code="tk-r-02"/>. <spring:message code="tk-r-03"/></p>
                            <p><spring:message code="tk-r-04"/>. <spring:message code="tk-r-05"/>. <spring:message code="tk-r-06"/>.</p>
                            <p><spring:message code="tk-r-07"/>.</p>
                            <p><spring:message code="tk-r-08"/>.</p>
                            <p>Lixi.Global Customer Service Team</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>