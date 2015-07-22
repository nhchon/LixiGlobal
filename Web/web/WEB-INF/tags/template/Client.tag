<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true" required="true" %>
<%@ attribute name="extraHeadContent" fragment="true" required="false" %>
<%@attribute name="extraJavascriptContent" fragment="true" required="false" %>
<%@ include file="/WEB-INF/jsp/base.jspf" %>
<template:CoreClient htmlTitle="${htmlTitle}">
    <jsp:attribute name="headContent">
        <jsp:invoke fragment="extraHeadContent" />
    </jsp:attribute>

    <jsp:attribute name="topbarContent">
        <c:import url="/top"/>
    </jsp:attribute>

    <jsp:attribute name="bottombarContent">
        <c:import url="/bottom"/>
    </jsp:attribute>

    <jsp:attribute name="javascriptContent">
        <jsp:invoke fragment="extraJavascriptContent"/>
    </jsp:attribute>

    <jsp:body>
        <jsp:doBody />
    </jsp:body>
</template:CoreClient>
