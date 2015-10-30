<template:Client htmlTitle="LiXi Global - Email address already in use">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-85-0">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <c:if test="${wrongSecretCode eq 1}">
                            <div class="msg msg-error">
                                There is something wrong with your verification code. Please try again !
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>