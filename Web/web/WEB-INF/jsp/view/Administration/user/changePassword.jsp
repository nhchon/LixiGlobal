<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->

    <head>
        <title>Change Password | KingAdmin - Admin Dashboard</title>
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
                <div class="login-box center-block" style="width:50%;">
                    <form:form class="form-horizontal" role="form" autocomplete="off" method="post" modelAttribute="adminUserChangePasswordForm">
                        <h4 style="margin-bottom: 25px;">Your are forced to change your password by The System Administrator.</h4>
                        <p class="title">Your current password</p>
                        <div class="form-group">
                            <label for="username" class="control-label sr-only">Username</label>
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <form:password path="currentPassword" placeholder="Current Password" class="form-control"/>
                                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                </div>
                                <span class="help-block with-errors errors"><form:errors path="currentPassword" /></span>
                            </div>
                        </div>
                            <p class="title"><b>Please enter your new password</b></p>
                        <div class="form-group">
                            <label for="username" class="control-label sr-only">Username</label>
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <form:password path="password" placeholder="New Password" class="form-control"/>
                                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                </div>
                                <span class="help-block with-errors errors"><form:errors path="password" /></span>
                            </div>
                        </div>
                        <label for="password" class="control-label sr-only">Password</label>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <form:password path="confPassword" placeholder="Retype New Password" class="form-control"/>
                                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                </div>
                                <span class="help-block with-errors errors"><form:errors path="confPassword" /></span>    
                            </div>
                        </div>
                                <button type="submit" class="btn btn-custom-primary btn-lg btn-block btn-auth"><i class="fa fa-arrow-circle-o-right"></i> <spring:message code="message.change_password"/></button>
                    </form:form>
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

