<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="text-center">
                    <h2 class="title">THANK YOU FOR REGISTERING WITH US</h2>
                    <p><spring:message code="signup.an_email_was_sent" arguments="${email}"/></p>
                    <p>Please remember that the activation code will be expired after one day.</p>
                    <p>
                        Be sure to check your spam filter if you can’t find the email in
                        your inbox. You may aslo contact
                        <a href="help.html">Customer Service</a> for help.
                    </p>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>