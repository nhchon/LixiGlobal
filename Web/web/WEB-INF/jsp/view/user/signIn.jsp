<template:Client htmlTitle="LiXi Global - User Sign In">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/sign-in.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            var EMAIL_MESSAGE = '<spring:message code="validate.email_required"/>';
            var PASSWORD_MESSAGE = '<spring:message code="validate.password_required"/>';
            var SIGN_UP_ACTION = '<c:url value="/user/signUp"/>';
            var SIGN_IN_ACTION = '<c:url value="/user/signIn"/>';
            $(document).ready(function () {

                // set focus on load
                $('#email').focus();
                $("#has-account").prop('checked', true);

                // disable password filed if is new user
                $('#new-customer').change(function () {

                    if ($(this).is(':checked')) {
                        
                        // change action form to signUp
                        //$('#SignInForm').attr('action', SIGN_UP_ACTION);
                        //$("#SignInForm").attr("method", "get");
                        // disable password filed
                        $('#password').prop('disabled', true);
                    }

                });

                $("#has-account").change(function () {

                    if ($(this).is(':checked')) {
                        
                        // change action form to sign In
                        //$('#SignInForm').attr('action', SIGN_IN_ACTION);
                        //$("#SignInForm").attr("method", "post");
                        // disable password filed
                        $('#password').prop('disabled', false);
                    }

                });
            });

            function validateOnSubmit() {

                // if is new-customer
                if ($('#new-customer').is(':checked')) {
                    
                    //jump to signUp page
                    document.location.href = SIGN_UP_ACTION;
                    return false;

                }
                else {

                    if (!isValidEmailAddress($('#email').val())) {

                        alert(EMAIL_MESSAGE);
                        //
                        $('#email').focus();
                        //
                        return false;
                    }
                    else {
                        
                        if(!isValidPassword($('#password').val())){
                            
                            alert(PASSWORD_MESSAGE);
                            //
                            $('#password').focus();
                            //
                            return false;
                        }
                        else{
                            
                            return true;
                        }
                    }
                }
            }
        </script>
    </jsp:attribute>    

    <jsp:body>
        <!-- Page Content -->
        <section id="sign-in">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-8 col-md-8 col-sm-10 col-xs-12">
                        <form:form method="post" class="form-horizontal" id="SignInForm" modelAttribute="userSignInForm" autocomplete="off" onsubmit="return validateOnSubmit();">
                            <fieldset>
                                <legend><spring:message code="message.sign_in"/></legend>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="email" class="control-label"><spring:message code="signin.your_email_address"/></label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <input type="text" class="form-control" name="email" id="email" placeholder="<spring:message code="message.email_place_holder"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5 hidden-sm hidden-xs">
                                        <label class="control-label"><spring:message code="signin.do_you_have_password"/></label>
                                        <div class="radio">
                                            <label>
                                                <input class="lixi-radio" type="radio" name="has-account" id="new-customer" value="0">
                                                <span class="lixi-radio"><span></span></span>
                                                <span class="txt"><spring:message code="signin.no_new_customer"/></span>
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input class="lixi-radio" type="radio" name="has-account" id="has-account" value="1" checked>
                                                <span class="lixi-radio"><span></span></span>
                                                <span class="txt"><spring:message code="signin.yes_password"/></span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <input type="password" class="form-control" name="password" id="password" placeholder="<spring:message code="signin.at_least_password"/>">
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a class="forgot-password" href="password-assistance.html"><spring:message code="message.forgot_password"/></a>
                                        <br />
                                        <button type="submit" class="btn btn-primary"><spring:message code="message.sign_in"/></button>
                                    </div>
                                </div>
                                <!-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> -->
                            </fieldset>
                        </form:form>
                        <br />
                        <div id="help">
                            <span class="title"><spring:message code="message.sign_in_help"/></span>
                            <br />
                            <span class="txt"><spring:message code="message.forgot_your_password"/>?</span>
                            <br class="hidden-lg hidden-md hidden-sm"/>
                            <a href="password-assistance.html"><spring:message code="message.password_help"/></a>
                            <br />
                            <span class="txt"><spring:message code="message.email_change"/></span>
                            <br class="hidden-lg hidden-md hidden-sm"/>
                            <a href="change-login-email.html"><spring:message code="message.update_it_here"/></a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>

</template:Client>