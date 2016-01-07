<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <h1>Error Page</h1>
        <p>Application has encountered an error. Please contact support on ...</p>

        <!--
        Failed URL: ${url}
        Exception:  ${exception.message}
        <c:forEach items="${exception.stackTrace}" var="ste">    ${ste} 
        </c:forEach>
        -->
    </body>
</html>
