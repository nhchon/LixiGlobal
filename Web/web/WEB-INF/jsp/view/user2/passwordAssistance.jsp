<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/password-assistance.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var CAPTCHA_MESSAGE = '<spring:message code="validate.captcha_required"/>'
            var CONTEXT_PATH = '${pageContext.request.contextPath}';
            $(document).ready(function () {
                $('#captchaImg').on({
                    'click': function () {
                        $('#captchaImg').attr('src', CONTEXT_PATH + '/captcha?time=' + (new Date()).getTime());
                    }
                });
            });

            function validPassAssistanceForm() {

                if (!isValidEmailAddress($('#email').val())) {

                    alert(EMAIL_MESSAGE);
                    //
                    $('#email').focus();
                    //
                    return false;
                }
                else {

                    if ($.trim($('#captcha').val()) === '') {
                        alert(CAPTCHA_MESSAGE);
                        //
                        $('#captcha').focus();
                        //
                        return false;
                    }

                }
                // Ok
                return true;
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section class=" main-section bg-default">
            <div class="container post-wrapper">
                <div class="row"><div class="col-md-12">
                        <c:if test="${passwordAssistance eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="mess.something-wrong-email-captcha"/>. <spring:message code="mess.try-again"/> !
                            </div>
                        </c:if>
                        <c:url value="/user/passwordAssistance2" var="passwordAssistanceUrl"/>
                        <form onsubmit="return validPassAssistanceForm();" class="form-horizontal" method="post" action="${passwordAssistanceUrl}">
                            <h2 class="title"><spring:message code="mess.pass-ass"/></h2>
                            <div class="desc">
                                <spring:message code="mess.address-associated"/>. <spring:message code="mess.we-will-email"/>.
                            </div>
                            <div class="form-group">
                                <div class="col-lg-5 col-md-5">
                                    <label for="email" class="control-label"><spring:message code="signin.your_email_address"/></label>
                                </div>
                                <div class="col-lg-7 col-md-7">
                                    <input type="email" class="form-control" id="email" name="email" placeholder="myemail@domainname.com">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-5 col-md-5">
                                    <label for="captcha" class="control-label"><spring:message code="mess.type-the-char"/></label>
                                </div>
                                <div class="col-lg-7 col-md-7">
                                    <div id="captcha-img">
                                        <img style="cursor: pointer;" title="Click to Reload Image" id="captchaImg" alt="Captcha" src="<c:url value="/captcha"/>" />
                                    </div>
                                    <input type="text" class="form-control" id="captcha" name="captcha" placeholder="">
                                </div>
                            </div>
                            <div class="form-group right">
                                <div class="col-lg-5 col-md-5"></div>
                                <div class="col-lg-7">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-primary"><spring:message code="message.next"/></button>
                                </div>
                            </div>
                        </form>
                        <br />
                        <div id="desc">
                            Has your email address changed? If you no longer use the email associated
                            with your Lixi.global account, you may contact <a href="<c:url value="/support/post?method=Email"/>">Customer Service</a>
                            for help restoring access to your account.
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>