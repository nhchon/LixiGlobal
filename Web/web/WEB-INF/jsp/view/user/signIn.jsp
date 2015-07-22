<template:Client htmlTitle="LiXi Global - User Sign In">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/sign-in.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">

    </jsp:attribute>    

    <jsp:body>
        <!-- Page Content -->
        <section id="sign-in">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-8 col-md-8 col-sm-10 col-xs-12">
                        <form id="SignInForm" class="form-horizontal">
                            <fieldset>
                                <legend>Sign In</legend>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5">
                                        <label for="email" class="control-label">Your email address</label>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <input type="text" class="form-control" id="email" placeholder="myemail@domainname.com">
                                    </div>
                                </div>
                                <div class="form-group hidden-md hidden-lg">
                                    <div class="col-lg-5 col-md-5">
                                        <label class="control-label">Do you have lixi.global password?</label>
                                    </div>
                                    <div class="">
                                        <div class="radio">
                                            <label>
                                                <input class="lixi-radio" type="radio" name="has-account" checked>
                                                <span class="lixi-radio"><span></span></span>
                                                <span class="txt">No, I'm a new customer</span>
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input class="lixi-radio" type="radio" name="has-account">
                                                <span class="lixi-radio"><span></span></span>
                                                <span class="txt">Yes, I have a password</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-5 col-md-5 hidden-sm hidden-xs">
                                        <label class="control-label">Do you have lixi.global password?</label>
                                        <div class="radio">
                                            <label>
                                                <input class="lixi-radio" type="radio" name="has-account-alt" checked>
                                                <span class="lixi-radio"><span></span></span>
                                                <span class="txt">No, I'm a new customer</span>
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input class="lixi-radio" type="radio" name="has-account-alt">
                                                <span class="lixi-radio"><span></span></span>
                                                <span class="txt">Yes, I have a password</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-lg-7 col-md-7">
                                        <input type="password" class="form-control" id="password" placeholder="At least 8 characters">
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a class="forgot-password" href="password-assistance.html">Forgot Password</a>
                                        <br />
                                        <a href="sign-in-fail.html" class="btn btn-primary">Sign In</a>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                        <br />
                        <div id="help">
                            <span class="title">Sign In Help</span>
                            <br />
                            <span class="txt">Forgot your password?</span>
                            <br class="hidden-lg hidden-md hidden-sm"/>
                            <a href="password-assistance.html">Get password help</a>
                            <br />
                            <span class="txt">Has your email address changed?</span>
                            <br class="hidden-lg hidden-md hidden-sm"/>
                            <a href="change-login-email.html">Update it here</a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>

</template:Client>