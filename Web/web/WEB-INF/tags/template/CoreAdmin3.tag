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
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Basic Dashboard for Lixi.Global's Projects</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resource/theme/assets/css/bootstrap.min.css"/>" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<c:url value="/resource/theme/assets/css/navbar-static-top.css"/>" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
        <script type="text/javascript" lang="javascript">
            var postInvisibleForm = function (url, fields) {
                var form = $('<form id="mapForm" method="post"></form>')
                        .attr({action: url, style: 'display: none;'});
                for (var key in fields) {
                    if (fields.hasOwnProperty(key))
                        form.append($('<input type="hidden">').attr({
                            name: key, value: fields[key]
                        }));
                }
                form.append($('<input type="hidden">').attr({
                    name: '${_csrf.parameterName}', value: '${_csrf.token}'
                }));
                $('body').append(form);
                form.submit();
            };        
        </script>
        <jsp:invoke fragment="headContent" />
    </head>

    <body>
        <!-- Top Bar -->
        <jsp:invoke fragment="topbarContent" />
        <div class="container">
            <jsp:doBody />
        </div>
        <div id="overlay" style="display:none;background-color: gray">
            <div style="padding: 20px 10px;width:100%;display: inline-block;position: relative">
                <div class="progress progress-striped active">
                    <div class="progress-bar"  role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script type="text/javascript">
            var CONTEXT_PATH = "${pageContext.request.contextPath}";
            if (CONTEXT_PATH === null || CONTEXT_PATH === 'null' || CONTEXT_PATH === '/') {
                CONTEXT_PATH = '';
            }
        </script>
        <script src="<c:url value="/resource/theme/assets/js/jquery/jquery-2.1.0.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/js/bootstrap/bootstrap.min.js"/>"></script>
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="<c:url value="/resource/theme/assets/js/ie10-viewport-bug-workaround.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.maskedinput.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/utils.js"/>"></script>        
        <!-- javascript at end of page-->
        <jsp:invoke fragment="javascriptContent" />
        <!-- // -->
    </body>
</html>
