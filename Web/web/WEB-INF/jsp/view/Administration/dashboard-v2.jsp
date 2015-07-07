<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->

    <head>
        <title>Dashboard | KingAdmin - Admin Dashboard</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="description" content="KingAdmin - Bootstrap Admin Dashboard Theme">
        <meta name="author" content="The Develovers">

        <!-- CSS -->
        <link href="<c:url value="/resource/theme/assets/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resource/theme/assets/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resource/theme/assets/css/main.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resource/theme/assets/css/my-custom-styles.css"/>" rel="stylesheet" type="text/css">

        <!--[if lte IE 9]>
                <link href="<c:url value="/resource/theme/assets/css/main-ie.css"/>" rel="stylesheet" type="text/css"/>
                <link href="<c:url value="/resource/theme/assets/css/main-ie-part2.css"/>" rel="stylesheet" type="text/css"/>
        <![endif]-->

        <!-- CSS for demo style switcher. you can remove this -->
        <link href="<c:url value="/resource/theme/demo-style-switcher/assets/css/style-switcher.css"/>" rel="stylesheet" type="text/css">

        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon144x144.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon114x114.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon72x72.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="57x57" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon57x57.png"/>">
        <link rel="shortcut icon" href="<c:url value="/resource/theme/assets/ico/favicon.png"/>">
    </head>

    <body class="dashboard2">
        <!-- WRAPPER -->
        <div class="wrapper">
            <!-- TOP BAR -->
            <div class="top-bar">
                <div class="container">
                    <div class="row">
                        <!-- logo -->
                        <div class="col-md-2 logo">
                            <a href="index.html"><img src="<c:url value="/resource/theme/assets/img/kingadmin-logo-white.png"/>" alt="KingAdmin - Admin Dashboard" /></a>
                            <h1 class="sr-only">KingAdmin Admin Dashboard</h1>
                        </div>
                        <!-- end logo -->
                        <div class="col-md-10">
                            <div class="row">
                                <div class="col-md-3">
                                    <!-- search box -->
                                    <div id="tour-searchbox" class="input-group searchbox">
                                        <input type="search" class="form-control" placeholder="enter keyword here...">
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
                                        </span>
                                    </div>
                                    <!-- end search box -->
                                </div>
                                <div class="col-md-9">
                                    <div class="top-bar-right">
                                        <!-- responsive menu bar icon -->
                                        <a href="#" class="hidden-md hidden-lg main-nav-toggle"><i class="fa fa-bars"></i></a>
                                        <!-- end responsive menu bar icon -->
                                        <button type="button" id="start-tour" class="btn btn-link"><i class="fa fa-refresh"></i> Start Tour</button>
                                        <button type="button" id="global-volume" class="btn btn-link btn-global-volume"><i class="fa"></i></button>
                                        <div class="notifications">
                                            <ul>
                                                <!-- notification: inbox -->
                                                <li class="notification-item inbox">
                                                    <div class="btn-group">
                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                                            <i class="fa fa-envelope"></i><span class="count">2</span>
                                                            <span class="circle"></span>
                                                        </a>
                                                        <ul class="dropdown-menu" role="menu">
                                                            <li class="notification-header">
                                                                <em>You have 2 unread messages</em>
                                                            </li>
                                                            <li class="inbox-item clearfix">
                                                                <a href="#">
                                                                    <div class="media">
                                                                        <div class="media-left">
                                                                            <img class="media-object" src="<c:url value="/resource/theme/assets/img/user1.png"/>" alt="Antonio">
                                                                        </div>
                                                                        <div class="media-body">
                                                                            <h5 class="media-heading name">Antonius</h5>
                                                                            <p class="text">The problem just happened this morning. I can't see ...</p>
                                                                            <span class="timestamp">4 minutes ago</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </li>
                                                            <li class="inbox-item unread clearfix">
                                                                <a href="#">
                                                                    <div class="media">
                                                                        <div class="media-left">
                                                                            <img class="media-object" src="<c:url value="/resource/theme/assets/img/user2.png"/>" alt="Antonio">
                                                                        </div>
                                                                        <div class="media-body">
                                                                            <h5 class="media-heading name">Michael</h5>
                                                                            <p class="text">Hey dude, cool theme!</p>
                                                                            <span class="timestamp">2 hours ago</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </li>
                                                            <li class="inbox-item unread clearfix">
                                                                <a href="#">
                                                                    <div class="media">
                                                                        <div class="media-left">
                                                                            <img class="media-object" src="<c:url value="/resource/theme/assets/img/user3.png"/>" alt="Antonio">
                                                                        </div>
                                                                        <div class="media-body">
                                                                            <h5 class="media-heading name">Stella</h5>
                                                                            <p class="text">Ok now I can see the status for each item. Thanks! :D</p>
                                                                            <span class="timestamp">Oct 6</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </li>
                                                            <li class="inbox-item clearfix">
                                                                <a href="#">
                                                                    <div class="media">
                                                                        <div class="media-left">
                                                                            <img class="media-object" src="<c:url value="/resource/theme/assets/img/user4.png"/>" alt="Antonio">
                                                                        </div>
                                                                        <div class="media-body">
                                                                            <h5 class="media-heading name">Jane Doe</h5>
                                                                            <p class="text"><i class="fa fa-reply"></i> Please check the status of your ...</p>
                                                                            <span class="timestamp">Oct 2</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </li>
                                                            <li class="inbox-item clearfix">
                                                                <a href="#">
                                                                    <div class="media">
                                                                        <div class="media-left">
                                                                            <img class="media-object" src="<c:url value="/resource/theme/assets/img/user5.png"/>" alt="Antonio">
                                                                        </div>
                                                                        <div class="media-body">
                                                                            <h5 class="media-heading name">John Simmons</h5>
                                                                            <p class="text"><i class="fa fa-reply"></i> I've fixed the problem :)</p>
                                                                            <span class="timestamp">Sep 12</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </li>
                                                            <li class="notification-footer">
                                                                <a href="#">View All Messages</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <!-- end notification: inbox -->

                                                <!-- notification: general -->
                                                <li class="notification-item general">
                                                    <div class="btn-group">
                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                                            <i class="fa fa-bell"></i><span class="count">8</span>
                                                            <span class="circle"></span>
                                                        </a>
                                                        <ul class="dropdown-menu" role="menu">
                                                            <li class="notification-header">
                                                                <em>You have 8 notifications</em>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-comment green-font"></i>
                                                                    <span class="text">New comment on the blog post</span>
                                                                    <span class="timestamp">1 minute ago</span>
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-user green-font"></i>
                                                                    <span class="text">New registered user</span>
                                                                    <span class="timestamp">12 minutes ago</span>
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-comment green-font"></i>
                                                                    <span class="text">New comment on the blog post</span>
                                                                    <span class="timestamp">18 minutes ago</span>
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-shopping-cart red-font"></i>
                                                                    <span class="text">4 new sales order</span>
                                                                    <span class="timestamp">4 hours ago</span>
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-edit yellow-font"></i>
                                                                    <span class="text">3 product reviews awaiting moderation</span>
                                                                    <span class="timestamp">1 day ago</span>
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-comment green-font"></i>
                                                                    <span class="text">New comment on the blog post</span>
                                                                    <span class="timestamp">3 days ago</span>
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-comment green-font"></i>
                                                                    <span class="text">New comment on the blog post</span>
                                                                    <span class="timestamp">Oct 15</span>
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a href="#">
                                                                    <i class="fa fa-warning red-font"></i>
                                                                    <span class="text red-font">Low disk space!</span>
                                                                    <span class="timestamp">Oct 11</span>
                                                                </a>
                                                            </li>
                                                            <li class="notification-footer">
                                                                <a href="#">View All Notifications</a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                                <!-- end notification: general -->
                                            </ul>
                                        </div>
                                        <!-- logged user and the menu -->
                                        <div class="logged-user">
                                            <div class="btn-group">
                                                <a href="#" class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                                                    <img src="<c:url value="/resource/theme/assets/img/user-avatar.png"/>" alt="User Avatar" />
                                                    <span class="name">Stacy Rose</span> <span class="caret"></span>
                                                </a>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li>
                                                        <a href="#">
                                                            <i class="fa fa-user"></i>
                                                            <span class="text">Profile</span>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="#">
                                                            <i class="fa fa-cog"></i>
                                                            <span class="text">Settings</span>
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="<c:url value="/Administration/logout"/>">
                                                            <i class="fa fa-power-off"></i>
                                                            <span class="text">Logout</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- end logged user and the menu -->
                                    </div>
                                    <!-- /top-bar-right -->
                                </div>
                            </div>
                            <!-- /row -->
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /top -->
            <!-- BOTTOM: LEFT NAV AND RIGHT MAIN CONTENT -->
            <div class="bottom">
                <div class="container">
                    <div class="row">
                        <!-- left sidebar -->
                        <div class="col-md-2 left-sidebar">
                            <!-- main-nav -->
                            <nav class="main-nav">
                                <ul class="main-menu">
                                    <li class="active">
                                        <a href="#" class="js-sub-menu-toggle">
                                            <i class="fa fa-dashboard fa-fw"></i><span class="text">Dashboard</span>
                                            <i class="toggle-icon fa fa-angle-down"></i>
                                        </a>
                                        <ul class="sub-menu open">
                                            <li><a href="index.html"><span class="text">Dashboard v1</span></a></li>
                                            <li class="active"><a href="index-dashboard-v2.html"><span class="text">Dashboard v2 <span class="badge element-bg-color-blue">New</span></span></a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="#" class="js-sub-menu-toggle">
                                            <i class="fa fa-clipboard fa-fw"></i><span class="text">Pages</span>
                                            <i class="toggle-icon fa fa-angle-left"></i>
                                        </a>
                                        <ul class="sub-menu ">
                                            <li><a href="page-profile.html"><span class="text">Profile</span></a></li>
                                            <li><a href="page-invoice.html"><span class="text">Invoice</span></a></li>
                                            <li><a href="page-knowledgebase.html"><span class="text">Knowledge Base</span></a></li>
                                            <li><a href="page-inbox.html"><span class="text">Inbox</span></a></li>
                                            <li><a href="page-new-message.html"><span class="text">New Message</span></a></li>
                                            <li><a href="page-view-message.html"><span class="text">View Message</span></a></li>
                                            <li><a href="page-search-result.html"><span class="text">Search Result</span></a></li>
                                            <li><a href="page-submit-ticket.html"><span class="text">Submit Ticket</span></a></li>
                                            <li><a href="page-file-manager.html"><span class="text">File Manager <span class="badge element-bg-color-blue">New</span></span></a></li>
                                            <li><a href="page-projects.html"><span class="text">Projects <span class="badge element-bg-color-blue">New</span></span></a></li>
                                            <li><a href="page-project-detail.html"><span class="text">Project Detail <span class="badge element-bg-color-blue">New</span></span></a></li>
                                            <li><a href="page-faq.html"><span class="text">FAQ <span class="badge element-bg-color-blue">New</span></span></a></li>
                                            <li><a href="page-register.html"><span class="text">Register</span></a></li>
                                            <li><a href="page-login.html"><span class="text">Login</span></a></li>
                                            <li><a href="page-404.html"><span class="text">404</span></a></li>
                                            <li><a href="page-blank.html"><span class="text">Blank Page</span></a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="#" class="js-sub-menu-toggle">
                                            <i class="fa fa-bar-chart-o fw"></i><span class="text">Charts &amp; Statistics</span>
                                            <i class="toggle-icon fa fa-angle-left"></i>
                                        </a>
                                        <ul class="sub-menu ">
                                            <li><a href="charts-statistics.html"><span class="text">Charts</span></a></li>
                                            <li><a href="charts-statistics-interactive.html"><span class="text">Interactive Charts</span></a></li>
                                            <li><a href="charts-statistics-real-time.html"><span class="text">Realtime Charts</span></a></li>
                                            <li><a href="charts-d3charts.html"><span class="text">D3 Charts</span></a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="#" class="js-sub-menu-toggle">
                                            <i class="fa fa-edit fw"></i><span class="text">Forms</span>
                                            <i class="toggle-icon fa fa-angle-left"></i>
                                        </a>
                                        <ul class="sub-menu ">
                                            <li><a href="form-inplace-editing.html"><span class="text">In-place Editing</span></a></li>
                                            <li><a href="form-elements.html"><span class="text">Form Elements</span></a></li>
                                            <li><a href="form-layouts.html"><span class="text">Form Layouts</span></a></li>
                                            <li><a href="form-bootstrap-elements.html"><span class="text">Bootstrap Elements</span></a></li>
                                            <li><a href="form-validations.html"><span class="text">Validation</span></a></li>
                                            <li><a href="form-file-upload.html"><span class="text">File Upload</span></a></li>
                                            <li><a href="form-text-editor.html"><span class="text">Text Editor</span></a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="#" class="js-sub-menu-toggle">
                                            <i class="fa fa-list-alt fw"></i><span class="text">UI Elements</span>
                                            <i class="toggle-icon fa fa-angle-left"></i>
                                        </a>
                                        <ul class="sub-menu ">
                                            <li><a href="ui-elements-general.html"><span class="text">General Elements</span></a></li>
                                            <li><a href="ui-elements-tabs.html"><span class="text">Tabs</span></a></li>
                                            <li><a href="ui-elements-buttons.html"><span class="text">Buttons</span></a></li>
                                            <li><a href="ui-elements-icons.html"><span class="text">Icons <span class="badge element-bg-color-blue">Updated</span></span></a></li>
                                            <li><a href="ui-elements-flash-message.html"><span class="text">Flash Message</span></a></li>
                                        </ul>
                                    </li>
                                    <li><a href="widgets.html"><i class="fa fa-puzzle-piece fa-fw"></i><span class="text">Widgets <span class="badge element-bg-color-blue">Updated</span></span></a></li>
                                    <li>
                                        <a href="#" class="js-sub-menu-toggle">
                                            <i class="fa fa-gears fw"></i><span class="text">Components</span>
                                            <i class="toggle-icon fa fa-angle-left"></i>
                                        </a>
                                        <ul class="sub-menu ">
                                            <li><a href="components-wizard.html"><span class="text">Wizard (with validation)</span></a></li>
                                            <li><a href="components-calendar.html"><span class="text">Calendar</span></a></li>
                                            <li><a href="components-maps.html"><span class="text">Maps</span></a></li>
                                            <li><a href="components-gallery.html"><span class="text">Gallery</span></a></li>
                                            <li><a href="components-tree-view.html"><span class="text">Tree View <span class="badge element-bg-color-blue">New</span></span></a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="#" class="js-sub-menu-toggle">
                                            <i class="fa fa-table fw"></i><span class="text">Tables</span>
                                            <i class="toggle-icon fa fa-angle-left"></i>
                                        </a>
                                        <ul class="sub-menu ">
                                            <li><a href="tables-static-table.html"><span class="text">Static Table</span></a></li>
                                            <li><a href="tables-dynamic-table.html"><span class="text">Dynamic Table</span></a></li>
                                        </ul>
                                    </li>
                                    <li><a href="typography.html"><i class="fa fa-font fa-fw"></i><span class="text">Typography</span></a></li>
                                    <li>
                                        <a href="#" class="js-sub-menu-toggle"><i class="fa fa-bars"></i>
                                            <span class="text">Menu Lvl 1 <span class="badge element-bg-color-blue">New</span></span>
                                            <i class="toggle-icon fa fa-angle-left"></i>
                                        </a>
                                        <ul class="sub-menu">
                                            <li class="">
                                                <a href="#" class="js-sub-menu-toggle">
                                                    <span class="text">Menu Lvl 2</span>
                                                    <i class="toggle-icon fa fa-angle-left"></i>
                                                </a>
                                                <ul class="sub-menu">
                                                    <li><a href="#">Menu Lvl 3</a></li>
                                                    <li><a href="#">Menu Lvl 3</a></li>
                                                    <li><a href="#">Menu Lvl 3</a></li>
                                                </ul>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="text">Menu Lvl 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                            <!-- /main-nav -->
                            <div class="sidebar-minified js-toggle-minified">
                                <i class="fa fa-angle-left"></i>
                            </div>
                            <!-- sidebar content -->
                            <div class="sidebar-content">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h5><i class="fa fa-lightbulb-o"></i> Tips</h5>
                                    </div>
                                    <div class="panel-body">
                                        <p>You can do live search to the widget at search box located at top bar. It's very useful if your dashboard is full of widget.</p>
                                    </div>
                                </div>
                                <h5 class="label label-default"><i class="fa fa-info-circle"></i> Server Info</h5>
                                <ul class="list-unstyled list-info-sidebar bottom-30px">
                                    <li class="data-row">
                                        <div class="data-name">Disk Space Usage</div>
                                        <div class="data-value">
                                            274.43 / 2 GB
                                            <div class="progress progress-xs">
                                                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%">
                                                    <span class="sr-only">10%</span>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="data-row">
                                        <div class="data-name">Monthly Bandwidth Transfer</div>
                                        <div class="data-value">
                                            230 / 500 GB
                                            <div class="progress progress-xs">
                                                <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="46" aria-valuemin="0" aria-valuemax="100" style="width: 46%">
                                                    <span class="sr-only">46%</span>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="data-row">
                                        <span class="data-name">Database Disk Space</span>
                                        <span class="data-value">219.45 MB</span>
                                    </li>
                                    <li class="data-row">
                                        <span class="data-name">Operating System</span>
                                        <span class="data-value">Linux</span>
                                    </li>
                                    <li class="data-row">
                                        <span class="data-name">Apache Version</span>
                                        <span class="data-value">2.4.6</span>
                                    </li>
                                    <li class="data-row">
                                        <span class="data-name">PHP Version</span>
                                        <span class="data-value">5.3.27</span>
                                    </li>
                                    <li class="data-row">
                                        <span class="data-name">MySQL Version</span>
                                        <span class="data-value">5.5.34-cll</span>
                                    </li>
                                    <li class="data-row">
                                        <span class="data-name">Architecture</span>
                                        <span class="data-value">x86_64</span>
                                    </li>
                                </ul>
                            </div>
                            <!-- end sidebar content -->
                        </div>
                        <!-- end left sidebar -->

                        <!-- top general alert -->
                        <div class="alert alert-danger top-general-alert">
                            <span>If you <strong>can't see the logo</strong> on the top left, please reset the style on right style switcher (for upgraded theme only).</span>
                            <button type="button" class="close">&times;</button>
                        </div>
                        <!-- end top general alert -->

                        <!-- content-wrapper -->
                        <div class="col-md-10 content-wrapper">
                            <div class="row">
                                <div class="col-lg-4 ">
                                    <ul class="breadcrumb">
                                        <li><i class="fa fa-home"></i><a href="#">Home</a></li>
                                        <li class="active">Dashboard</li>
                                    </ul>
                                </div>
                                <div class="col-lg-8 ">
                                    <div class="top-content">
                                        <ul class="list-inline quick-access">
                                            <li>
                                                <a href="charts-statistics-interactive.html">
                                                    <div class="quick-access-item bg-color-green">
                                                        <i class="fa fa-bar-chart-o"></i>
                                                        <h5>CHARTS</h5><em>basic, interactive, real-time</em>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="page-inbox.html">
                                                    <div class="quick-access-item bg-color-blue">
                                                        <i class="fa fa-envelope"></i>
                                                        <h5>INBOX</h5><em>inbox with gmail style</em>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="tables-dynamic-table.html">
                                                    <div class="quick-access-item bg-color-orange">
                                                        <i class="fa fa-table"></i>
                                                        <h5>DYNAMIC TABLE</h5><em>tons of features and interactivity</em>
                                                    </div>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- main -->
                            <div class="content">
                                <div class="main-header">
                                    <h2>DASHBOARD v2</h2>
                                    <em>dashboard alternative</em>
                                </div>
                                <div class="main-content">
                                    <div class="widget widget-hide-header">
                                        <div class="widget-header hide">
                                            <h3>Main Dashboard Info</h3>
                                        </div>
                                        <div class="widget-content">
                                            <!-- NUMBER-CHART STAT -->
                                            <div class="row">
                                                <div class="col-md-3 col-sm-6">
                                                    <div class="number-chart">
                                                        <div class="number pull-left"><span>$22,500</span> <span>EARNINGS</span></div>
                                                        <div class="mini-stat">
                                                            <div id="number-chart1" class="inlinesparkline">Loading...</div>
                                                            <p class="text-muted"><i class="fa fa-caret-up green-font"></i> 19% higher than last week</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3 col-sm-6">
                                                    <div class="number-chart">
                                                        <div class="number pull-left"><span>245</span> <span>SALES</span></div>
                                                        <div class="mini-stat">
                                                            <div id="number-chart2" class="inlinesparkline">Loading...</div>
                                                            <p class="text-muted"><i class="fa fa-caret-up green-font"></i> 24% higher than last week</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3 col-sm-6">
                                                    <div class="number-chart">
                                                        <div class="number pull-left"><span>561,724</span> <span>VISITS</span></div>
                                                        <div class="mini-stat">
                                                            <div id="number-chart3" class="inlinesparkline">Loading...</div>
                                                            <p class="text-muted"><i class="fa fa-caret-up green-font"></i> 44% higher than last week</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3 col-sm-6">
                                                    <div class="number-chart">
                                                        <div class="number pull-left"><span>372,500</span> <span>LIKES</span></div>
                                                        <div class="mini-stat">
                                                            <div id="number-chart4" class="inlinesparkline">Loading...</div>
                                                            <p class="text-muted"><i class="fa fa-caret-down red-font"></i> 6% lower than last week</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- END NUMBER-CHART STAT -->
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <!-- WIDGET VISIT AND SALES CHART -->
                                            <div class="widget">
                                                <div class="widget-header">
                                                    <h3><i class="fa fa-bar-chart-o"></i> Weekly Sales Stat</h3> <em>- Visits and Sales</em>
                                                    <button type="button" class="btn btn-link btn-help"><i class="fa fa-question-circle"></i></button>
                                                    <div class="btn-group widget-header-toolbar">
                                                        <a href="#" title="Focus" class="btn-borderless btn-focus"><i class="fa fa-eye"></i></a>
                                                        <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                                                        <a href="#" title="Remove" class="btn-borderless btn-remove"><i class="fa fa-times"></i></a>
                                                    </div>
                                                </div>
                                                <div class="widget-content">
                                                    <div class="demo-flot-chart sales-chart"></div>
                                                </div>
                                            </div>
                                            <!-- END WIDGET VISIT AND SALES CHART -->
                                        </div>
                                        <div class="col-md-6">
                                            <!-- SALES INFO SUMMARY -->
                                            <div class="widget">
                                                <div class="widget-header">
                                                    <h3><i class="fa fa-bar-chart-o"></i> Sales Stat Summary</h3>
                                                    <div class="btn-group widget-header-toolbar">
                                                        <a href="#" title="Focus" class="btn-borderless btn-focus"><i class="fa fa-eye"></i></a>
                                                        <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                                                        <a href="#" title="Remove" class="btn-borderless btn-remove"><i class="fa fa-times"></i></a>
                                                    </div>
                                                </div>
                                                <div class="widget-content">
                                                    <div class="table-responsive">
                                                        <table class="table table-bordered bottom-30px">
                                                            <thead>
                                                                <tr>
                                                                    <th>&nbsp;</th>
                                                                    <th>Today</th>
                                                                    <th>Current Week</th>
                                                                    <th>Current Month</th>
                                                                    <th>Lifetime</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td>Earnings</td>
                                                                    <td>$270</td>
                                                                    <td>$653</td>
                                                                    <td>$2,845</td>
                                                                    <td>$30,281</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Sales</td>
                                                                    <td>35</td>
                                                                    <td>126</td>
                                                                    <td>226</td>
                                                                    <td>4531</td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <h4>Recent Purchases</h4>
                                                    <div class="table-responsive">
                                                        <table class="table table-condensed">
                                                            <thead>
                                                                <tr>
                                                                    <th>Order No.</th>
                                                                    <th>Name</th>
                                                                    <th>Amount</th>
                                                                    <th>Date &amp; time</th>
                                                                    <th>Status</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td><a href="#">ORD201502004</a></td>
                                                                    <td>Steve</td>
                                                                    <td>$122</td>
                                                                    <td>04/03/2015 17:23</td>
                                                                    <td><span class="label label-success">COMPLETED</span></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><a href="#">ORD201501098</a></td>
                                                                    <td>Mandy</td>
                                                                    <td>$73</td>
                                                                    <td>04/03/2015 16:14</td>
                                                                    <td><span class="label label-success">COMPLETED</span></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><a href="#">ORD201501095</a></td>
                                                                    <td>Bruce</td>
                                                                    <td>$43</td>
                                                                    <td>04/03/2015 16:08</td>
                                                                    <td><span class="label label-warning">PENDING</span></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><a href="#">ORD201502095</a></td>
                                                                    <td>Albert</td>
                                                                    <td>$100</td>
                                                                    <td>04/03/2015 15:58</td>
                                                                    <td><span class="label label-danger">FAILED</span></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <a href="#" class="btn btn-default btn-sm"><i class="fa fa-shopping-cart"></i> View all purchases</a>
                                                </div>
                                            </div>
                                            <!-- END SALES INFO SUMMARY -->
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <!-- DRAG AND DROP TODO LIST -->
                                            <div class="widget">
                                                <div class="widget-header">
                                                    <h3><i class="fa fa-bar-chart-o"></i> Ajax Drag &amp; Drop To-Do List</h3> <em>- Try to click the checkbox then drag &nbsp;<i class="fa fa-bars"></i> icon</em>
                                                    <div class="btn-group widget-header-toolbar">
                                                        <a href="#" title="Focus" class="btn-borderless btn-focus"><i class="fa fa-eye"></i></a>
                                                        <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                                                        <a href="#" title="Remove" class="btn-borderless btn-remove"><i class="fa fa-times"></i></a>
                                                    </div>
                                                    <div class="widget-header-toolbar process-status">
                                                        <span class="loading"><i class="fa fa-spinner fa-spin"></i> Loading ...</span>
                                                        <span class="saved green-font"><i class="fa fa-check"></i> Saved</span>
                                                        <span class="failed red-font"><i class="fa fa-remove"></i> Failed</span>
                                                    </div>
                                                </div>
                                                <div class="widget-content">
                                                    <ul id="dragdrop-todo" class="list-unstyled todo-list">
                                                        <li>
                                                            <span class="list-control">
                                                                <span class="handle"><i class="fa fa-bars"></i></span>
                                                                <label class="control-inline fancy-checkbox">
                                                                    <input type="checkbox"><span></span>
                                                                </label>
                                                            </span>
                                                            <p>
                                                                <strong>Restart Server</strong><span class="label label-danger">High</span>
                                                                <span class="short-description">Dynamically integrate client-centric technologies without cooperative resources.</span>
                                                                <span class="date text-muted">Jun 9, 2014</span>
                                                            </p>
                                                        </li>
                                                        <li>
                                                            <span class="list-control">
                                                                <span class="handle"><i class="fa fa-bars"></i></span>
                                                                <label class="control-inline fancy-checkbox">
                                                                    <input type="checkbox"><span></span>
                                                                </label>
                                                            </span>
                                                            <p>
                                                                <strong>Retest Upload Scenario</strong><span class="label label-warning">Medium</span>
                                                                <span class="short-description">Compellingly implement clicks-and-mortar relationships without highly efficient metrics.</span>
                                                                <span class="date text-muted">Jun 23, 2014</span>
                                                            </p>
                                                        </li>
                                                        <li>
                                                            <span class="list-control">
                                                                <span class="handle"><i class="fa fa-bars"></i></span>
                                                                <label class="control-inline fancy-checkbox">
                                                                    <input type="checkbox"><span></span>
                                                                </label>
                                                            </span>
                                                            <p>
                                                                <strong>Functional Spec Meeting</strong><span class="label label-info">Low</span>
                                                                <span class="short-description">Monotonectally formulate client-focused core competencies after parallel web-readiness.</span>
                                                                <span class="date text-muted">Jun 11, 2014</span>
                                                            </p>
                                                        </li>
                                                        <li>
                                                            <span class="list-control">
                                                                <span class="handle"><i class="fa fa-bars"></i></span>
                                                                <label class="control-inline fancy-checkbox">
                                                                    <input type="checkbox"><span></span>
                                                                </label>
                                                            </span>
                                                            <p>
                                                                <strong>Export User Database</strong><span class="label label-warning">Medium</span>
                                                                <span class="short-description">Enthusiastically restore granular paradigms before timely leadership skills. Compellingly reconceptualize 2.0 e-business for compelling resources. Progressively create team driven technologies after intermandated web-readiness.</span>
                                                                <span class="date text-muted">Jun 21, 2014</span>
                                                            </p>
                                                        </li>
                                                        <li>
                                                            <span class="list-control">
                                                                <span class="handle"><i class="fa fa-bars"></i></span>
                                                                <label class="control-inline fancy-checkbox">
                                                                    <input type="checkbox"><span></span>
                                                                </label>
                                                            </span>
                                                            <p>
                                                                <strong>Conduct A/B Testing</strong><span class="label label-danger">High</span>
                                                                <span class="short-description">Dramatically unleash cross-platform internal or "organic" sources with integrated convergence. Quickly aggregate backward-compatible e-commerce and B2B.</span>
                                                                <span class="date text-muted">Jun 30, 2014</span>
                                                            </p>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- END DRAG AND DROP TODO LIST -->
                                        </div>
                                        <div class="col-md-6">
                                            <!-- ADD NEW NOTE -->
                                            <div class="widget widget-quick-note quick-note-create">
                                                <div class="widget-content">
                                                    <form class="form-horizontal" role="form">
                                                        <input type="text" class="form-control title" name="title" placeholder="Title">
                                                        <textarea class="form-control" rows="1" cols="30" name="note-content" placeholder="Add quick note"></textarea>
                                                    </form>
                                                </div>
                                                <div class="widget-footer">
                                                    <div class="btn-group">
                                                        <button type="button" class="btn btn-clean" data-toggle="tooltip" data-placement="bottom" data-original-title="Add Image"><i class="fa fa-image"></i> <span class="sr-only">Add Image</span></button>
                                                        <button type="button" class="btn btn-clean" data-toggle="tooltip" data-placement="bottom" data-original-title="Remind Me"><i class="fa fa-bell"></i> <span class="sr-only">Remind Me</span></button>
                                                        <button type="button" class="btn btn-clean" data-toggle="tooltip" data-placement="bottom" data-original-title="Share"><i class="fa fa-share-alt"></i> <span class="sr-only">Share</span></button>
                                                    </div>
                                                    <button type="button" class="btn btn-primary pull-right"><i class="fa fa-save"></i> Save</button>
                                                </div>
                                            </div>
                                            <!-- END ADD NEW NOTE -->

                                            <!-- SAVED NOTES -->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="widget quick-note-saved">
                                                        <div class="widget-header">
                                                            <h3>Saved Note Example</h3>
                                                        </div>
                                                        <div class="widget-content">
                                                            <p>Completely leverage existing customer directed ideas rather than multifunctional customer service. Uniquely formulate economically sound portals whereas professional web services. Proactively productize team building materials without state of the art benefits. Collaboratively re-engineer progressive vortals.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="widget quick-note-saved">
                                                        <div class="widget-header">
                                                            <h3>Saved Note Example</h3>
                                                        </div>
                                                        <div class="widget-content">
                                                            <p>Completely leverage existing customer directed ideas rather than multifunctional customer service. Uniquely formulate economically sound portals whereas professional web services. Proactively productize team building materials without state of the art benefits. Collaboratively re-engineer progressive vortals.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="widget quick-note-saved">
                                                        <div class="widget-header">
                                                            <h3>Saved Note Example</h3>
                                                        </div>
                                                        <div class="widget-content">
                                                            <p>Completely leverage existing customer directed ideas rather than multifunctional customer service. Uniquely formulate economically sound portals whereas professional web services. Proactively productize team building materials without state of the art benefits. Collaboratively re-engineer progressive vortals.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="widget quick-note-saved">
                                                        <div class="widget-header">
                                                            <h3>Saved Note Example</h3>
                                                        </div>
                                                        <div class="widget-content">
                                                            <p>Completely leverage existing customer directed ideas rather than multifunctional customer service. Uniquely formulate economically sound portals whereas professional web services. Proactively productize team building materials without state of the art benefits. Collaboratively re-engineer progressive vortals.</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- END SAVED NOTES -->

                                            <!-- QUICK NOTE MODAL -->
                                            <div class="modal fade" id="quick-note-modal" tabindex="-1" role="dialog" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-body">
                                                            <div class="widget widget-quick-note quick-note-edit">
                                                                <div class="widget-content">
                                                                    <form class="form-horizontal" role="form">
                                                                        <input type="text" class="form-control title" name="title" value="Saved Note Example" placeholder="Title">
                                                                        <textarea class="form-control" rows="7" cols="30" name="note-content" placeholder="Add quick note">Completely leverage existing customer directed ideas rather than multifunctional customer service. Uniquely formulate economically sound portals whereas professional web services. Proactively productize team building materials without state of the art benefits. Collaboratively re-engineer progressive vortals.</textarea>
                                                                    </form>
                                                                </div>
                                                                <div class="widget-footer">
                                                                    <div class="btn-group">
                                                                        <button type="button" class="btn btn-clean" data-toggle="tooltip" data-placement="bottom" data-original-title="Add Image"><i class="fa fa-image"></i> <span class="sr-only">Add Image</span></button>
                                                                        <button type="button" class="btn btn-clean" data-toggle="tooltip" data-placement="bottom" data-original-title="Remind Me"><i class="fa fa-bell"></i> <span class="sr-only">Remind Me</span></button>
                                                                        <button type="button" class="btn btn-clean" data-toggle="tooltip" data-placement="bottom" data-original-title="Share"><i class="fa fa-share-alt"></i> <span class="sr-only">Share</span></button>
                                                                    </div>
                                                                    <button type="button" class="btn btn-primary btn-save pull-right"><i class="fa fa-save"></i> Save</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- END QUICK NOTE MODAL -->
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <!-- WIDGET ACTIVITY FEED -->
                                            <div class="widget widget-scrolling">
                                                <div class="widget-header">
                                                    <h3><i class="fa fa-fire"></i> Activity Feed</h3>
                                                    <div class="btn-group widget-header-toolbar">
                                                        <a href="#" title="Focus" class="btn-borderless btn-focus"><i class="fa fa-eye"></i></a>
                                                        <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                                                        <a href="#" title="Remove" class="btn-borderless btn-remove"><i class="fa fa-times"></i></a>
                                                    </div>
                                                </div>
                                                <div class="widget-content">
                                                    <ul class="list-unstyled activity-list">
                                                        <li>
                                                            <i class="fa fa-check activity-icon pull-left icon-success"></i>
                                                            <p>All project tasks are on schedule <span class="timestamp">2 minutes ago</span></p>
                                                        </li>
                                                        <li>
                                                            <i class="fa fa-check-circle activity-icon pull-left icon-success"></i>
                                                            <p>The system is running well, no error found. <span class="timestamp">4 minutes ago</span></p>
                                                        </li>
                                                        <li>
                                                            <i class="fa fa-unlock activity-icon pull-left icon-danger"></i>
                                                            <p>You have unsecure file permission on this project. Go to <a href="">File Manager</a> to fix it <span class="timestamp">15 minutes ago</span></p>
                                                        </li>
                                                        <li>
                                                            <i class="fa fa-bug activity-icon pull-left icon-info"></i>
                                                            <p>New <a href="#">bug report</a> has been submitted <span class="timestamp">1 hour ago</span></p>
                                                        </li>
                                                        <li>
                                                            <i class="fa fa-close activity-icon pull-left icon-danger"></i>
                                                            <p>Background job <a href="#">#783458</a> has failed. See the <a href="#">logs</a> <span class="timestamp">3 hour ago</span></p>
                                                        </li>
                                                        <li>
                                                            <i class="fa fa-flag activity-icon pull-left icon-success"></i>
                                                            <p>Project <a href="#">Social Boost</a> has been flagged as finished <span class="timestamp">Yesterday</span></p>
                                                        </li>
                                                        <li>
                                                            <i class="fa fa-print activity-icon pull-left icon-warning"></i>
                                                            <p>You have <a href="#">pending documents</a> on the printer server <span class="timestamp">Yesterday</span></p>
                                                        </li>
                                                    </ul>
                                                    <button type="button" class="btn btn-clean center-block"><i class="fa fa-refresh"></i> Load more</button>
                                                </div>
                                            </div>
                                            <!-- END WIDGET ACTIVITY FEED -->
                                        </div>
                                        <div class="col-md-4">
                                            <!-- WIDGET TASKS -->
                                            <div class="widget">
                                                <div class="widget-header">
                                                    <h3><i class="fa fa-tasks"></i> My Tasks</h3> <em>- Summary of Tasks</em>
                                                    <div class="btn-group widget-header-toolbar">
                                                        <a href="#" title="Focus" class="btn-borderless btn-focus"><i class="fa fa-eye"></i></a>
                                                        <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                                                        <a href="#" title="Remove" class="btn-borderless btn-remove"><i class="fa fa-times"></i></a>
                                                    </div>
                                                </div>
                                                <div class="widget-content">
                                                    <ul class="task-list">
                                                        <li>
                                                            <p>Updating Users Settings <span class="label label-danger">23%</span></p>
                                                            <div class="progress progress-xs">
                                                                <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="23" aria-valuemin="0" aria-valuemax="100" style="width:23%">
                                                                    <span class="sr-only">23% Complete</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p>Load &amp; Stress Test <span class="label label-success">80%</span></p>
                                                            <div class="progress progress-xs">
                                                                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                                                    <span class="sr-only">80% Complete</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p>Data Duplication Check <span class="label label-success">100%</span></p>
                                                            <div class="progress progress-xs">
                                                                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                                                    <span class="sr-only">Success</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p>Server Check <span class="label label-warning">45%</span></p>
                                                            <div class="progress progress-xs">
                                                                <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
                                                                    <span class="sr-only">45% Complete</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p>Mobile App Development <span class="label label-danger">10%</span></p>
                                                            <div class="progress progress-xs">
                                                                <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%">
                                                                    <span class="sr-only">10% Complete</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p>Documentation<span class="label label-danger">14%</span></p>
                                                            <div class="progress progress-xs">
                                                                <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%">
                                                                    <span class="sr-only">14% Complete</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <p>A/B Testing<span class="label label-danger">57%</span></p>
                                                            <div class="progress progress-xs">
                                                                <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%">
                                                                    <span class="sr-only">10% Complete</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- END WIDGET TASKS -->
                                        </div>
                                        <div class="col-md-4">
                                            <!-- WIDGET EMPLOYEE -->
                                            <div class="widget">
                                                <div class="widget-header">
                                                    <h3><i class="fa fa-user"></i> Employee of The Month</h3>
                                                    <div class="btn-group widget-header-toolbar">
                                                        <a href="#" title="Focus" class="btn-borderless btn-focus"><i class="fa fa-eye"></i></a>
                                                        <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                                                        <a href="#" title="Remove" class="btn-borderless btn-remove"><i class="fa fa-times"></i></a>
                                                    </div>
                                                </div>
                                                <div class="widget-content text-center">
                                                    <img src="assets/img/profile-avatar.png" class="img-circle" alt="Avatar" />
                                                    <h4>Jack Bay</h4>
                                                    <hr class="dashed" />
                                                    <ul class="list-unstyled text-muted">
                                                        <li>Most on-time</li>
                                                        <li>Most attitude, talkative and independent</li>
                                                        <li>Most fit and healthy</li>
                                                        <li>Most hard worker</li>
                                                    </ul>
                                                    <hr class="dashed" />
                                                    <button type="button" class="btn btn-large btn-primary"><i class="fa fa-thumbs-up"></i> Appreciate!</button>
                                                </div>
                                            </div>
                                            <!-- END WIDGET EMPLOYEE -->
                                        </div>
                                    </div>
                                </div>
                                <!-- /main-content -->
                            </div>
                            <!-- /main -->
                        </div>
                        <!-- /content-wrapper -->
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- END BOTTOM: LEFT NAV AND RIGHT MAIN CONTENT -->
        </div>
        <!-- /wrapper -->

        <!-- FOOTER -->
        <footer class="footer">
            &copy; 2014-2015 The Develovers
        </footer>
        <!-- END FOOTER -->

        <!-- STYLE SWITCHER -->
        <div class="del-style-switcher">
            <div class="del-switcher-toggle toggle-hide"></div>
            <form>
                <section class="del-section del-section-skin">
                    <h5 class="del-switcher-header">Choose Skins:</h5>
                    <ul>
                        <li><a href="#" title="Slate Gray" class="switch-skin slategray" data-skin="<c:url value="/resource/theme/assets/css/skins/slategray.css"/>">Slate Gray</a></li>
                        <li><a href="#" title="Dark Blue" class="switch-skin darkblue" data-skin="<c:url value="/resource/theme/assets/css/skins/darkblue.css"/>">Dark Blue</a></li>
                        <li><a href="#" title="Dark Brown" class="switch-skin darkbrown" data-skin="<c:url value="/resource/theme/assets/css/skins/darkbrown.css"/>">Dark Brown</a></li>
                        <li><a href="#" title="Light Green" class="switch-skin lightgreen" data-skin="<c:url value="/resource/theme/assets/css/skins/lightgreen.css"/>">Light Green</a></li>
                        <li><a href="#" title="Orange" class="switch-skin orange" data-skin="<c:url value="/resource/theme/assets/css/skins/orange.css"/>">Orange</a></li>
                        <li><a href="#" title="Red" class="switch-skin red" data-skin="<c:url value="/resource/theme/assets/css/skins/red.css"/>">Red</a></li>
                        <li><a href="#" title="Teal" class="switch-skin teal" data-skin="<c:url value="/resource/theme/assets/css/skins/teal.css"/>">Teal</a></li>
                        <li><a href="#" title="Yellow" class="switch-skin yellow" data-skin="<c:url value="/resource/theme/assets/css/skins/yellow.css"/>">Yellow</a></li>
                    </ul>
                        <button type="button" class="switch-skin-full fulldark" data-skin="<c:url value="/resource/theme/assets/css/skins/fulldark.css"/>">Full Dark</button>
                        <button type="button" class="switch-skin-full fullbright" data-skin="<c:url value="/resource/theme/assets/css/skins/fullbright.css"/>">Full Bright</button>
                </section>
                <label class="fancy-checkbox">
                    <input type="checkbox" id="fixed-top-nav"><span>Fixed Top Navigation</span></label>
                <p><a href="#" title="Reset Style" class="del-reset-style">Reset Style</a></p>
            </form>
        </div>
        <!-- END STYLE SWITCHER -->

        <!-- Javascript -->
        <script src="<c:url value="/resource/theme/assets/js/jquery/jquery-2.1.0.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/bootstrap/bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/modernizr/modernizr.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/bootstrap-tour/bootstrap-tour.custom.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/king-common.js"/>"></script>
        <script src="<c:url value="/resource/theme/demo-style-switcher/assets/js/deliswitch.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/jquery-ui/jquery-ui-1.10.4.custom.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/jquery-slimscroll/jquery.slimscroll.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/stat/flot/jquery.flot.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/stat/flot/jquery.flot.resize.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/stat/flot/jquery.flot.time.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/stat/flot/jquery.flot.tooltip.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/plugins/jquery-sparkline/jquery.sparkline.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/king-chart-stat.js"/>"></script>
    </body>

</html>
