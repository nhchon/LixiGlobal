<template:Client htmlTitle="LiXi Global - Blank Sample Page">

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
                    'click': function(){
                        $('#captchaImg').attr('src',CONTEXT_PATH + '/captcha?time='+(new Date()).getTime());
                    }
                });
            });
            
            function validPassAssistanceForm(){
                
                if (!isValidEmailAddress($('#email').val())) {

                        alert(EMAIL_MESSAGE);
                        //
                        $('#email').focus();
                        //
                        return false;
                }
                else{
                    
                    if($.trim($('#captcha').val()) === ''){
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
        <section id="password-assistance">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <c:if test="${passwordAssistance eq 1}">
                            <div class="msg msg-error">
                                There is something wrong with your email/captcha code. Please try again !
                            </div>
                        </c:if>
                        <form onsubmit="return validPassAssistanceForm();" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/passwordAssistance">
                            <fieldset>
                                <legend>Password Assistance</legend>
                                <div class="desc">
                                    Enter the email address associated with your Lixi.global account,
                                    then click Next. We'll email you a link to a page where you can
                                    easily create a new password.
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="email" class="control-label">Your email address</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <input type="email" class="form-control" id="email" name="email" placeholder="myemail@domainname.com">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="captcha" class="control-label">Type the characters you see in this image</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <div id="captcha-img">
                                            <img style="cursor: pointer;" title="Click to Reload Image" id="captchaImg" alt="Captcha" src="<c:url value="/captcha"/>" />
                                        </div>
                                        <input type="text" class="form-control" id="captcha" name="captcha" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-primary">Next</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                        <br />
                        <div id="desc">
                            Has your email address changed? If you no longer use the email associated
                            with your Lixi.global account, you may contact <a href="help.html">Customer Service</a>
                            for help restoring access to your account.
                        </div>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>