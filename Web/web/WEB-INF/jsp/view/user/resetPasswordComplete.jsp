<template:Client htmlTitle="LiXi Global - Blank Sample Page">

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
        <section id="password-assistance">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <form class="form-horizontal">
                            <fieldset>
                                <legend>Congratulation</legend>
                                <div class="desc">
                                    Your password has been reset. Please <a href="<c:url value="/user/signIn"/>">Login</a> to start LiXi.Global
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>