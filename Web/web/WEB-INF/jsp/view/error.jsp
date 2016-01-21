<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lixi.Global - Error Page</title>
    </head>
    <body>
        <h1>Error Page</h1>
        <p>Application has encountered an error. Please contact support on support@lixi.global</p>

        <p>Failed URL: ${url}</p>
        <p>Exception:  ${exception.message}</p>
        <c:forEach items="${exception.stackTrace}" var="ste">
            <p>${ste}</p>
        </c:forEach>
    </body>
</html>
