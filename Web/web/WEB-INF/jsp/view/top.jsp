<header>
    <nav class="navbar navbar-default navbar-top">
        <div class="container">
            <div class="navbar-collapse" id="navbar-collapse-top">
                <ul class="nav navbar-nav navbar-right">
                    <c:if test="${not empty sessionScope['scopedTarget.loginedUser'].email}">
                        <li><a href="javascript:void(0);">Hello ${sessionScope['scopedTarget.loginedUser'].email}</a></li>
                        <li>
                            <a class="hvr-underline-from-center" href="<c:url value="/user/signOut"/>">Log Out</a>
                        </li>
                    </c:if>
                    <c:if test="${empty sessionScope['scopedTarget.loginedUser'].email}">
                        <li class="nav-top-border-right">
                            <a class="hvr-underline-from-center nav-login-event" href="<c:url value="/user/signIn"/>"><i class="fa fa-user"></i> LOGIN</a>
                        </li>
                        <li class="nav-top-border-right">
                            <a class="hvr-underline-from-center nav-register-event" href="<c:url value="/user/signUp"/>">REGISTER</a>
                        </li>
                    </c:if>
                    <li class="nav-top-border-right">
                        <a class="hvr-underline-from-center nav-lang nav-lang-en" href="?locale=en_US">English</a>
                    </li>
                    <li>
                        <a class="hvr-underline-from-center nav-lang nav-lang-vn" href="?locale=vi_VN">Vietnam</a>
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
                <a class="navbar-brand page-scroll" href="<c:url value="/"/>">
                    <img src="<c:url value="/resource/theme/assets/lixi-global/images/logo.png"/>"/>
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbar-collapse-main">
                <ul class="nav navbar-nav navbar-left">
                    <li>
                        <a class="hvr-underline-from-center nav-link" href="<c:url value="/"/>">Home</a>
                    </li>
                    <li>
                        <a class="hvr-underline-from-center nav-link" href="<c:url value="/gifts/choose"/>">Send gift</a>
                    </li>
                    <li class="has-dropdown dropdown">
                        <a class="hvr-underline-from-center nav-link" data-toggle="dropdown" href="account.html">Account <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu nav-level-1">
                            <li>
                                <a class="nav-sub-link no-boder-top" href="<c:url value="/user/orderHistory"/>">Orders</a>
                                <ul class="nav-level-2">
                                    <li><a href="<c:url value="/user/orderHistory"/>">View, Track<br/> or cancel an orders</a></li>
                                </ul>
                            </li>
                            <li>
                                <a class="nav-sub-link" href="#payment-link">Payment Method</a>
                                <ul class="nav-level-2">
                                    <li><a href="<c:url value="/user/payments"/>">Manage payment options</a></li>
                                    <li><a href="<c:url value="/user/addCard"/>">Add a Credit/ Debit cards</a></li>
                                </ul>
                            </li>
                            <li>
                                <a class="nav-sub-link" href="#">Account setting</a>
                                <ul class="nav-level-2">
                                    <li><a href="<c:url value="/user/yourAccount"/>">Change email, password,<br/> name and mobile phone</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li class="has-dropdown dropdown">
                        <a class="hvr-underline-from-center nav-link" data-toggle="dropdown" href="javascript:void(0);">Support <i class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu nav-level-1">
                            <li>
                                <a class="nav-sub-link no-boder-top" href="<c:url value="/support/refundPolicy"/>">Returns and Refund Policy</a>
                            </li>
                            <li>
                                <a class="nav-sub-link" href="#">Customer Service</a>
                                <ul class="nav-level-2">
                                    <li><a href="<c:url value="/support/post?method=Email"/>">Email</a></li>
                                    <li><a href="<c:url value="/support/post?method=Phone"/>">Phone</a></li>
                                    <li><a href="<c:url value="/support/post?method=Chat"/>">Chat</a></li>
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
                        <a class="nav-cart-event" href="<c:url value="/checkout/jump2"/>">
                            <div class="nav-cart">
                                <div class="nav-cart-en" id="topTotalCurrentOrderUsd">&nbsp;</div>
                                <div class="nav-cart-vn" id="topTotalCurrentOrderVnd">&nbsp;</div>
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