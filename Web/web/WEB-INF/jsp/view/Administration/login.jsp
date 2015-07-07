<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->

    <head>
        <title>Login | KingAdmin - Admin Dashboard</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta name="description" content="KingAdmin Dashboard">
        <meta name="author" content="The Develovers">

        <!-- CSS -->
        <link href="<c:url value="/resource/theme/assets/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resource/theme/assets/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resource/theme/assets/css/main.css"/>" rel="stylesheet" type="text/css">

        <!--[if lte IE 9]>
                <link href="<c:url value="/resource/theme/assets/css/main-ie.css"/>" rel="stylesheet" type="text/css" />
                <link href="<c:url value="/resource/theme/assets/css/main-ie-part2.css"/>" rel="stylesheet" type="text/css" />
        <![endif]-->

        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon144x144.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon114x114.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon72x72.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="57x57" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon57x57.png"/>">
        <link rel="shortcut icon" href="<c:url value="/resource/theme/assets/ico/favicon.png"/>">

    </head>

    <body>
        <div class="wrapper full-page-wrapper page-auth page-login text-center">
            <div class="inner-page">
                <div class="logo">
                    <a href="index.html"><img src="<c:url value="/resource/theme/assets/img/kingadmin-logo.png"/>" alt="" /></a>
                </div>
                <button type="button" class="btn btn-auth-facebook"><span>Login via Facebook</span></button>

                <div class="separator"><span>OR</span></div>

                <div class="login-box center-block">
                    <form:form class="form-horizontal" role="form" autocomplete="off" method="post" modelAttribute="adminUserLoginForm">
                        <p class="title">Use your username</p>
                        <div class="form-group">
                            <label for="username" class="control-label sr-only">Username</label>
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <form:input path="username" autocomplete="off" placeholder="username" class="form-control" value="yhannart@gmail.com"/>
                                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                </div>
                                <span class="help-block with-errors errors"><form:errors path="username" /></span>
                            </div>
                        </div>
                        <label for="password" class="control-label sr-only">Password</label>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <form:password path="password" autocomplete="off" placeholder="password" class="form-control" password="Qaz123wsx"/>
                                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                </div>
                                <span class="help-block with-errors errors"><form:errors path="password" /></span>    
                            </div>
                        </div>
                        <label class="fancy-checkbox">
                            <input type="checkbox" name="remember-me" value="1">
                            <span>Remember me next time</span>
                        </label>
                            <button type="submit" class="btn btn-custom-primary btn-lg btn-block btn-auth"><i class="fa fa-arrow-circle-o-right"></i> Login</button>
                    </form:form>

                    <div class="links">
                        <p><a href="#">Forgot Username or Password?</a></p>
                        <p><a href="#">Create New Account</a></p>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer">&copy; 2014-2015 The Develovers</footer>

        <!-- Javascript -->
        <script src="<c:url value="/resource/theme/assets/js/jquery/jquery-2.1.0.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/bootstrap/bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/modernizr/modernizr.js"/>"></script>
    </body>

</html>

