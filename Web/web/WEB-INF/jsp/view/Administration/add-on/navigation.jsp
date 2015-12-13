<c:set var="m01" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/Dashboard')}"/>
<c:set var="m02" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/Orders/newOrders')}"/>
<c:set var="m03" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemConfig/categories')}"/>
<c:set var="m04" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemConfig/lixiExchangeRate')}"/>
<c:set var="m05" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemUser/list')}"/>
<c:set var="m06" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemUser/add')}"/>
<c:set var="m07" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemSupport/list')}"/>
<!-- main-nav -->
<ul class="nav nav-sidebar">
    <li id="m01" <c:if test="${m01 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/Dashboard"/>">Dashboard <span class="sr-only">(current)</span></a></li>
</ul>
<ul class="nav nav-sidebar">
    <li id="m02" <c:if test="${m02 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/Orders/newOrders"/>">List of New Order</a></li>
</ul>
<ul class="nav nav-sidebar">
    <li id="m03" <c:if test="${m03 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/SystemConfig/categories"/>">Categories</a></li>
    <li id="m04" <c:if test="${m04 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/SystemConfig/lixiExchangeRate"/>">LiXi Exchange Rate</a></li>
    <li id="m08" <c:if test="${m04 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/SystemFee/list"/>">LiXi Global Fee</a></li>
</ul>
<ul class="nav nav-sidebar">
    <li id="m05" <c:if test="${m05 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/SystemUser/list"/>"><span class="text">User List</span></a></li>
    <li id="m06" <c:if test="${m06 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/SystemUser/add"/>"><span class="text">Add New</span></a></li>
</ul>
<ul class="nav nav-sidebar">
    <li id="m07" <c:if test="${m07 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/SystemSupport/list"/>"><span class="text">Issue List</span></a></li>
</ul>
