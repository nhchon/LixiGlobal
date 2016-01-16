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
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <security:csrfMetaTags/>
        <title><c:out value="${fn:trim(htmlTitle)}" /></title>

        <link rel="apple-touch-icon" href="apple-touch-icon.png">
        <link rel="apple-touch-icon" sizes="57x57" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="60x60" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-60x60.png">
        <link rel="apple-touch-icon" sizes="72x72" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="76x76" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-76x76.png">
        <link rel="apple-touch-icon" sizes="114x114" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-114x114.png">
        <link rel="apple-touch-icon" sizes="120x120" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-120x120.png">
        <link rel="apple-touch-icon" sizes="144x144" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-144x144.png">
        <link rel="apple-touch-icon" sizes="152x152" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-152x152.png">
        <link rel="apple-touch-icon" sizes="180x180" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/apple-icon-180x180.png">
        <link rel="icon" type="image/png" sizes="192x192"  href="<c:url value="/resource/theme/assets/lixi-global/images"/>/android-icon-192x192.png">
        <link rel="icon" type="image/png" sizes="32x32" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="96x96" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/favicon-96x96.png">
        <link rel="icon" type="image/png" sizes="16x16" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/favicon-16x16.png">
        <link rel="manifest" href="<c:url value="/resource/theme/assets/lixi-global/images"/>/manifest.json">
        <meta name="msapplication-TileColor" content="#ffffff">
        <meta name="msapplication-TileImage" content="<c:url value="/resource/theme/assets/lixi-global/images"/>/ms-icon-144x144.png">
        <meta name="theme-color" content="#ffffff">

        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/bootstrap.min.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/lixi-global-ext.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/fonts/font-awesome/css/font-awesome.min.css"/>">
        <link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:100,300,300italic,400,700|Julius+Sans+One|Roboto+Condensed:300,400">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/hover-min.css"/>">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/main.css"/>">
        <%--
        <c:set var="currentDate" value="<%=new java.util.Date()%>"/>
        <fmt:parseDate parseLocale="en_US" var="tetDateMilestone" value="Wed Jan 20 00:00:00 GMT 2016" pattern="EEE MMM dd HH:mm:ss z yyyy" />
        <fmt:parseDate parseLocale="en_US" var="valentinceDateMilestone" value="Mon Feb 01 00:00:00 GMT 2016" pattern="EEE MMM dd HH:mm:ss z yyyy" />
        <fmt:parseDate parseLocale="en_US" var="endValentinceDateMilestone" value="Mon Feb 15 00:00:00 GMT 2016" pattern="EEE MMM dd HH:mm:ss z yyyy" />
        <c:choose>
            <c:when test="${(currentDate gt tetDateMilestone) && (currentDate lt valentinceDateMilestone)}">
                <link id="originalTheme" rel="stylesheet" type="text/css" href="<c:url value="/resource/theme/assets/lixi-global/themes/tet/css/style.css"/>">
            </c:when>
            <c:when test="${(currentDate gt valentinceDateMilestone) && (currentDate lt endValentinceDateMilestone)}">
                <link id="originalTheme" rel="stylesheet" type="text/css" href="<c:url value="/resource/theme/assets/lixi-global/themes/valentine/css/style.css"/>">
            </c:when>
            <c:otherwise>
                <link id="originalTheme" rel="stylesheet" type="text/css" href="<c:url value="/resource/theme/assets/lixi-global/themes/default/css/style.css"/>">
            </c:otherwise>
        </c:choose>
        --%>
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/css/addon.css"/>">
        <jsp:invoke fragment="headContent" />
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
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-formhelpers.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-dialog.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.validate.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-slider.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-select.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/lixi.global-extend-js.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/lixi.global.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/utils.js"/>"></script>
        <script>
            $(function () {
                var token = $("input[name='_csrf']").val();
                var header = "X-CSRF-TOKEN";
                $(document).ajaxSend(function (e, xhr, options) {
                    xhr.setRequestHeader(header, token);
                });
            });
        </script>
        <jsp:invoke fragment="javascriptContent" />
    </body>
</html>