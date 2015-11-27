<%@ tag body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ attribute name="htmlTitle" type="java.lang.String" rtexprvalue="true"
              required="true" %>
<%@ attribute name="extraHeadContent" fragment="true" required="false" %>
<%@ attribute name="extraNavigationContent" fragment="true" required="false" %>
<%-- --%>
<%@ attribute name="parentItem" type="java.lang.Integer" required="false" %>
<%@ attribute name="childItem" type="java.lang.Integer" required="false" %>
<%-- // --%>
<%@attribute name="extraJavascriptContent" fragment="true" required="false" %>
<%@ include file="/WEB-INF/jsp/base.jspf" %>
<template:CoreAdmin3 htmlTitle="${htmlTitle}">
    <jsp:attribute name="headContent">
        <jsp:invoke fragment="extraHeadContent" />
    </jsp:attribute>

    <jsp:attribute name="topbarContent">
        <c:import url="/Administration/AddOn/topbar"/>
    </jsp:attribute>

    <jsp:attribute name="navigationContent">
        <c:import url="/Administration/AddOn/navigation">
            <c:param name="parentItem" value="${parentItem}"/>
            <c:param name="childItem" value="${childItem}"/>
        </c:import>
        <jsp:invoke fragment="extraNavigationContent" />
    </jsp:attribute>

    <jsp:attribute name="sidebarContent">
        <c:import url="/Administration/AddOn/sidebar"/>
    </jsp:attribute>
    
    <jsp:attribute name="javascriptContent">
        <jsp:invoke fragment="extraJavascriptContent"/>
    </jsp:attribute>

    <jsp:body>
        <jsp:doBody />
    </jsp:body>
    
</template:CoreAdmin3>
