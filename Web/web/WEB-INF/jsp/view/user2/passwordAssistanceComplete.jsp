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
                                <h2 class="title">Password Assistance</h2>
                                <div class="desc">
                                    An email was sent to <a>${email}</a>. Please follow the instructions to change your password.
                                </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>