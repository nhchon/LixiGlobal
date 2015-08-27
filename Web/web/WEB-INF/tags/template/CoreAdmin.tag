<%@tag description="Basic Dashboard Template for ChonSoft's Projects" body-content="scriptless" dynamic-attributes="dynamicAttributes" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>
<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true" required="true"%>
<%@attribute name="headContent" fragment="true" required="false" %>
<%@attribute name="topbarContent" fragment="true" required="false" %>
<%@attribute name="sidebarContent" fragment="true" required="false" %>
<%@attribute name="navigationContent" fragment="true" required="false" %>
<%@attribute name="javascriptContent" fragment="true" required="false" %>
<%@ include file="/WEB-INF/jsp/base.jspf" %>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie ie9" lang="en" class="no-js"> <![endif]-->
<!--[if !(IE)]><!-->
<html lang="en" class="no-js">
    <!--<![endif]-->
    <head>
        <title>Dashboard | KingAdmin - Admin Dashboard</title>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="description" content="KingAdmin - Bootstrap Admin Dashboard Theme">
        <meta name="author" content="The Develovers">
        <!-- CSS -->
        <link href="<c:url value="/resource/theme/assets/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resource/theme/assets/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resource/theme/assets/css/main.css"/>" rel="stylesheet" type="text/css">
        <!--[if lte IE 9]>
            <link href="<c:url value="/resource/theme/assets/css/main-ie.css"/>" rel="stylesheet" type="text/css"/>
            <link href="<c:url value="/resource/theme/assets/css/main-ie-part2.css"/>" rel="stylesheet" type="text/css"/>
        <![endif]-->
        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon144x144.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon114x114.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon72x72.png"/>">
        <link rel="apple-touch-icon-precomposed" sizes="57x57" href="<c:url value="/resource/theme/assets/ico/kingadmin-favicon57x57.png"/>">
        <link rel="shortcut icon" href="<c:url value="/resource/theme/assets/ico/favicon.png"/>">
        <script type="text/javascript">
            var CONTEXT_PATH = "${pageContext.request.contextPath}";
            if (CONTEXT_PATH === null || CONTEXT_PATH === 'null' || CONTEXT_PATH === '/') {
                CONTEXT_PATH = '';
            }
        </script>
        <jsp:invoke fragment="headContent" />
    </head>
    <body class="dashboard2">
        <!-- WRAPPER -->
        <div class="wrapper">
            <!-- TOP BAR -->
            <div class="top-bar">
                <jsp:invoke fragment="topbarContent" />
            </div>
            <!-- /top -->
            <!-- BOTTOM: LEFT NAV AND RIGHT MAIN CONTENT -->
            <div class="bottom">
                <div class="container">
                    <div class="row">
                        <!-- left sidebar -->
                        <div class="col-md-2 left-sidebar">

                            <!-- main-nav -->
                            <jsp:invoke fragment="navigationContent" />
                            <!-- /main-nav -->
                            
                            <!-- sidebar content -->
                            <jsp:invoke fragment="sidebarContent" />
                            <!-- end sidebar content -->
                        </div>
                        <!-- end left sidebar -->
                        <jsp:doBody />
                        <!-- /content-wrapper -->
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- END BOTTOM: LEFT NAV AND RIGHT MAIN CONTENT -->
        </div>
        <!-- FOOTER -->
        <%@ include file="/WEB-INF/jsp/view/Administration/add-on/footer.jsp" %>
        <!-- END FOOTER -->

        <!-- STYLE SWITCHER -->
        <!-- END STYLE SWITCHER -->
        <!-- Javascript -->
        <script src="<c:url value="/resource/theme/assets/js/jquery/jquery-2.1.0.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/bootstrap/bootstrap.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/king-common.js"/>"></script>
        <!-- javascript at end of page-->
        <jsp:invoke fragment="javascriptContent" />
        <!-- // -->
    </body>
</html>        