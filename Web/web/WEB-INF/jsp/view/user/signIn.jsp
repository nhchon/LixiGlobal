<%--@elvariable id="validationErrors" type="java.util.Set<javax.validation.ConstraintViolation>"--%><!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Arsha Bootstrap Template</title>

        <!-- Bootstrap -->
        <link href="<c:url value="/resource/theme/assets/arsha/css/bootstrap.min.css"/>" rel="stylesheet">
        <link href="<c:url value="/resource/theme/assets/arsha/css/responsive-slider.css"/>" rel="stylesheet">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/arsha/css/animate.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/arsha/css/font-awesome.min.css"/>">
        <link href="<c:url value="/resource/theme/assets/arsha/css/style.css"/>" rel="stylesheet">	
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/arsha/css/magnific-popup.css"/>"> 
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style type="text/css">
            .errors {
                color:#CC0000;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="container">
                <div class="row">
                    <nav class="navbar navbar-default" role="navigation">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <div class="navbar-brand">
                                    <a href="<c:url value="/"/>"><h1>Lixi Global</h1></a>
                                </div>
                            </div>
                            <div class="menu">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li role="presentation"><a href="<c:url value="/"/>">Home</a></li>
                                    <li role="presentation"><a href="javascript:alert('blog.html');">blog</a></li>
                                    <li role="presentation"><a href="javascript:alert('portfolio.html');">Portfolio</a></li>
                                    <li role="presentation"><a href="javascript:alert('contacts.html');">Contact</a></li>						
                                    <c:if test="${not empty LOGIN_EMAIL}">
                                        <li role="presentation"><a href="javascript:void(0)">Hello ${LOGIN_EMAIL}</a></li>
                                        <li role="presentation"><a href="<c:url value="/user/signOut"/>">Sign Out</a></li>
                                    </c:if>
                                    <c:if test="${empty LOGIN_EMAIL}">
                                        <li role="presentation"><a href="<c:url value="/user/signUp"/>">Sign Up</a></li>						
                                        <li role="presentation" class="active"><a href="<c:url value="/user/signIn"/>">Sign In</a></li>						
                                    </c:if>
                                </ul>
                            </div>
                        </div>			
                    </nav>
                </div>
            </div>
        </header>

        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="recent">
                        <button class="btn-primarys"><h3>Sign In</h3></button>
                    </div>
                    <div><p>Please enter your account information</p></div>
                    <c:if test="${validationErrors != null}"><div class="errors">
                        <ul>
                            <c:forEach items="${validationErrors}" var="error">
                                <li><c:out value="${error.message}" /></li>
                            </c:forEach>
                        </ul>
                    </div></c:if>
                    <form:form method="post" role="form" modelAttribute="userSignInForm" autocomplete="off">
                        <div class="form-group">
                            <form:input type="email" class="form-control" path="email" placeholder="Email"/>
                            <span class="help-block with-errors errors"><form:errors path="email" /></span>
                        </div>
                        <div class="form-group">
                            <form:input type="password" class="form-control" path="password" placeholder="Password"/>
                            <span class="help-block with-errors errors"><form:errors path="password" /></span>
                        </div>

                        <button type="submit" class="btn btn-default">Sign In</button>
                    </form:form>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <hr>
            </div>
        </div>

        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="widget">
                            <h5 class="widgetheading">Get in touch with us</h5>
                            <address>
                                <strong>Arsha company Inc</strong><br>
                                Modernbuilding suite V124, AB 01<br>
                                Someplace 16425 Earth
                            </address>
                            <p>
                                <i class="icon-phone"></i> (123) 456-7890 - (123) 555-7891 <br>
                                <i class="icon-envelope-alt"></i> email@domainname.com
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="widget">
                            <h5 class="widgetheading">Pages</h5>
                            <ul class="link-list">
                                <li><a href="#">Press release</a></li>
                                <li><a href="#">Terms and conditions</a></li>
                                <li><a href="#">Privacy policy</a></li>
                                <li><a href="#">Career center</a></li>
                                <li><a href="#">Contact us</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="widget">
                            <h5 class="widgetheading">Latest posts</h5>
                            <ul class="link-list">
                                <li><a href="#">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</a></li>
                                <li><a href="#">Pellentesque et pulvinar enim. Quisque at tempor ligula</a></li>
                                <li><a href="#">Natus error sit voluptatem accusantium doloremque</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="widget">
                            <h5 class="widgetheading">Flickr photostream</h5>
                            <div class="flickr_badge">
                                <script type="text/javascript" src="http://www.flickr.com/badge_code_v2.gne?count=8&amp;display=random&amp;size=s&amp;layout=x&amp;source=user&amp;user=34178660@N03"></script>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="row">
                    <hr>
                </div>
            </div>

            <div id="sub-footer">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="copyright">
                                <p>
                                    <span>&copy; Arsha 2014 All right reserved. By </span><a href="http://bootstraptaste.com" target="_blank">Bootstraptaste</a>
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <ul class="social-network">
                                <li><a href="#" data-placement="top" title="Facebook"><i class="fa fa-facebook fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Twitter"><i class="fa fa-twitter fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Linkedin"><i class="fa fa-linkedin fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Pinterest"><i class="fa fa-pinterest fa-1x"></i></a></li>
                                <li><a href="#" data-placement="top" title="Google plus"><i class="fa fa-google-plus fa-1x"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </footer>



        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="<c:url value="/resource/theme/assets/arsha/js/jquery.js"/>"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="<c:url value="/resource/theme/assets/arsha/js/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/arsha/js/responsive-slider.js"/>"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="<c:url value="/resource/theme/assets/arsha/js/jquery.magnific-popup.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/arsha/js/functions.js"/>"></script>
    </body>
</html>