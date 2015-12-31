<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var CONTEXT_PATH = '${pageContext.request.contextPath}';
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                        <form class="form-horizontal">
                            <h2 class="title">Congratulation</h2>
                                <div class="desc">
                                    Your password has been reset. Please <a href="<c:url value="/user/signIn"/>">Login</a> to start Lixi.Global
                                </div>
                        </form>
                    </div>
                </div>
        </section>

    </jsp:body>
</template:Client>