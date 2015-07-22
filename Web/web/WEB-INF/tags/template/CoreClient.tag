<%@tag description="Front-end Template for LiXi's Projects" body-content="scriptless" dynamic-attributes="dynamicAttributes" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>
<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true" required="true"%>
<%@attribute name="headContent" fragment="true" required="false" %>
<%@attribute name="topbarContent" fragment="true" required="false" %>
<%@attribute name="bottombarContent" fragment="true" required="false" %>
<%@attribute name="javascriptContent" fragment="true" required="false" %>
<%@ include file="/WEB-INF/jsp/base.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title><c:out value="${fn:trim(htmlTitle)}" /></title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <link rel="shortcut icon" href="<c:url value="/resource/theme/assets/lixiglobal/favicon.ico"/>" />
        <!--[if lt IE 9]>
        <script src="<c:url value="/resource/theme/assets/lixiglobal/js/html5.js"/>"></script>
        <![endif]-->
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/bootstrap.min.css"/>" type="text/css" media="all" />
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/font-awesome.min.css"/>" type="text/css" media="all" />
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/style.css"/>" type="text/css" />

        <!-- Specific style for each page -->
        <jsp:invoke fragment="headContent" />
    </head>
    <body>
        <div id="wrapper">
            <jsp:invoke fragment="topbarContent"/>
            <!-- Page Content -->
            <jsp:doBody />
            <!-- // End of Page Content -->
            <jsp:invoke fragment="bottombarContent"/>
        </div>
        <!-- Common scripts -->
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/jquery-2.1.4.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/bootstrap.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resource/theme/assets/lixiglobal/js/lixi.js"/>"></script>
        <jsp:invoke fragment="javascriptContent" />
    </body>
</html>