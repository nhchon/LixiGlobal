<%@tag pageEncoding="UTF-8" description="Front-end Template for LiXi's Projects" body-content="scriptless" dynamic-attributes="dynamicAttributes" trimDirectiveWhitespaces="true" %>
<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true" required="true"%>
<%@attribute name="headContent" fragment="true" required="false" %>
<%@attribute name="topbarContent" fragment="true" required="false" %>
<%@attribute name="bottombarContent" fragment="true" required="false" %>
<%@attribute name="javascriptContent" fragment="true" required="false" %>
<%@include file="/WEB-INF/jsp/base.jspf" %>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><c:out value="${fn:trim(htmlTitle)}" /></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="apple-touch-icon" href="apple-touch-icon.png">

        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/bootstrap.min.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/lixi-global-ext.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/fonts/font-awesome/css/font-awesome.min.css"/>">
        <link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:100,300,300italic,400,700|Julius+Sans+One|Roboto+Condensed:300,400">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/hover-min.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/main.css"/>">
        <link id="originalTheme" rel="stylesheet" type="text/css" href="<c:url value="/resource/theme/assets/lixi-global/themes/default/css/style.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/addon.css"/>">

        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"/>"></script>
        <script type="text/javascript">
            var CONTEXT_PATH = "${pageContext.request.contextPath}";
            if (CONTEXT_PATH === null || CONTEXT_PATH === 'null' || CONTEXT_PATH === '/') {
                CONTEXT_PATH = '';
            }
        </script>
    </head>
    <body>
        <!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <div class="main_wrapper">
            <jsp:invoke fragment="topbarContent"/>
            <!-- Page Content -->
            <jsp:doBody />
            <!-- // End of Page Content -->
            <jsp:invoke fragment="bottombarContent"/>
        </div>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.js"><\/script>');</script>

        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-dialog.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.validate.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-slider.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-select.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/lixi.global-extend-js.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/lixi.global.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/overlay.js"/>"></script>
        <jsp:invoke fragment="javascriptContent" />
    </body>
</html>