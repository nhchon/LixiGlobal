<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/password-assistance.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var CONTEXT_PATH = '${pageContext.request.contextPath}';
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="row">
                    <div class="col-md-12">
                        <form class="form-horizontal">
                            <h2 class="title"><spring:message code="mess.pass-ass"/></h2>
                                <div class="desc">
                                    <spring:message code="mess.email-was-sent-to" arguments="${email}"/>. 
                                    <spring:message code="mess.follow-instructions"/>.
                                </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>