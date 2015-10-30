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
                        <p>An email was sent to ${inUseEmail}. In order to complete the e-mail
                        verification process, you must click on the link in the e-mail we sent you</p>
                        
                        <p>
                            Be sure to check your spam filters if you can't find the e-mail in your in-box. You may also 
                            <a href="#">contact customer service</a> for help.
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>