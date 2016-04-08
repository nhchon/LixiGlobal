<template:Client htmlTitle="Lixi Global - An email was sent">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="row">
                    <div class="col-md-12">
                        <p>An email was sent to ${inUseEmail}. In order to complete the e-mail
                        verification process, you must click on the link in the e-mail we sent you</p>
                        
                        <p>
                            Be sure to check your spam filters if you can't find the e-mail in your in-box. You may also 
                            <a href="<c:url value="/support/post?method=Email"/>">contact customer service</a> for help.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>