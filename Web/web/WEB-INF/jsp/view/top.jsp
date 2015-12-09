<header>
    <nav class="navbar navbar-default navbar-top">
        <div class="container">
            <div class="navbar-collapse" id="navbar-collapse-top">
                <ul class="nav navbar-nav navbar-right">
                    <c:if test="${not empty LOGINED_USER.email}">
                        <li>
                            <a class="hvr-underline-from-center" href="javascript:void(0);">Hello ${LOGINED_USER.email}</a>
                        </li>
                        <li>
                            <a class="hvr-underline-from-center" href="<c:url value="/user/signOut"/>">Log Out</a>
                        </li>
                    </c:if>
                    <c:if test="${empty LOGINED_USER.email}">
                        <li class="nav-login">
                            <a class="hvr-underline-from-center nav-login-event" href="<c:url value="/user/signIn"/>"><i class="fa fa-user"></i> LOGIN</a>
                        </li>
                        <li>
                            <a class="hvr-underline-from-center nav-register-event" href="<c:url value="/user/signUp"/>">REGISTER</a>
                        </li>
                    </c:if>
                    <li class="has-dropdown dropdown pull-right nav-language">
                        <a class="hvr-underline-from-center" data-toggle="dropdown" href="#change-language"><span class="language-text">EN</span> <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#">VN</a>
                            </li>	
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
    </nav>
    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-main">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">

                <button type="button" class="navbar-toggle navbar-toggle-event" data-toggle="collapse" data-target="#navbar-collapse-main">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!--                            <button type="button" class="navbar-toggle navbar-cart navbar-cart-event" data-toggle="collapse" data-target="#navbar-collapse-main">
                                                <i class="fa fa-cart-plus"></i>
                                            </button>-->
                <a class="navbar-brand page-scroll" href="<c:url value="/"/>">
                    <img src="<c:url value="/resource/theme/assets/lixi-global/images/logo.png"/>"/>
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbar-collapse-main">
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a class="hvr-underline-from-center nav-link" href="index.html">Home</a>
                    </li>
                    <li>
                        <a class="hvr-underline-from-center nav-link" href="<c:url value="/gifts/recipient"/>">Send gift</a>
                    </li>
                    <li class="has-dropdown dropdown">
                        <a class="hvr-underline-from-center nav-link" data-toggle="dropdown" href="account.html">Account <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu nav-level-1">
                            <li>
                                <a class="nav-sub-link no-boder-top" href="order-history.html">Orders</a>
                                <ul class="nav-level-2">
                                    <li><a href="order-history.html">View, Track<br/> or cancel an orders</a></li>
                                </ul>
                            </li>
                            <li>
                                <a class="nav-sub-link" href="#payment-link">Payment Method</a>
                                <ul class="nav-level-2">
                                    <li><a href="payment.html">Manage payment options</a></li>
                                    <li><a href="add-a-payment.html">Add a Credit/ Debit cards</a></li>
                                </ul>
                            </li>
                            <li>
                                <a class="nav-sub-link" href="#">Account setting</a>
                                <ul class="nav-level-2">
                                    <li><a href="account.html">Change email, password,<br/> name and mobile phone</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li class="has-dropdown dropdown">
                        <a class="hvr-underline-from-center nav-link" data-toggle="dropdown" href="support.html">Support <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu nav-level-1">
                            <li>
                                <a class="nav-sub-link no-boder-top" href="privacy-policy.html">Refund Policy</a>
                            </li>
                            <li>
                                <a class="nav-sub-link" href="#">Customer Service</a>
                                <ul class="nav-level-2">
                                    <li><a href="support-email.html">Email</a></li>
                                    <li><a href="support-phone.html">Phone</a></li>
                                    <li><a href="support-chat.html">Chat</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>


                </ul>
                <ul class="nav navbar-nav navbar-right">

                    <li class="nav-search">
                        <form class="search-form" method="post">
                            <input class="form-control" name="keyword" placeholder="Keyword..."/>
                            <button type="submit"><i class="fa fa-search"></i></button>
                        </form>
                    </li>
                    <li class="nav-cart-wrapper">
                        <a class="nav-cart-event" href="#view-cart">
                            <div class="nav-cart">
                                <div class="nav-cart-en">USD $150</div>
                                <div class="nav-cart-vn">VND 3,000,000</div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
</header>