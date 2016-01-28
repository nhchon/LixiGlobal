<!-- Static navbar -->
<c:set var="m01" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/Dashboard')}"/>
<c:set var="m02" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/Orders/newOrders')}"/>
<c:set var="m03" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemConfig/categories')}"/>
<c:set var="m03" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemConfig/lixiExchangeRate')}"/>
<c:set var="m05" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemUser/list')}"/>
<c:set var="m05" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemUser/add')}"/>
<c:set var="m07" value="${fn:contains(requestScope['javax.servlet.forward.servlet_path'],'/Administration/SystemSupport/list')}"/>
<nav class="navbar navbar-default navbar-static-top" style="z-index: auto;">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Lixi.Global</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li id="m01" <c:if test="${m01 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                <li><a href="javascript:void(0);">Financial</a></li>
                <li id="m07" class="dropdown<c:if test="${m07 eq true}"> active</c:if>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Customer<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="<c:url value="/Administration/SystemSupport/management/self"/>">Management List</a></li>
                    </ul>
                </li>
                <li id="m08" class="dropdown<c:if test="${m08 eq true}"> active</c:if>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Reports <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value="/Administration/SystemTopUp/report"/>">TopUp Report</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="<c:url value="/Administration/SystemRecipient/report"/>">Receiver Report</a></li>
                    </ul>
                </li>
                <li id="m02" class="dropdown<c:if test="${m02 eq true}"> active</c:if>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Orders <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value="/Administration/Orders/newOrders"/>">New Orders</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="<c:url value="/Administration/SystemTopUp/list"/>">List Un-Submitted TopUp</a></li>
                        <li><a href="<c:url value="/Administration/SystemTopUp/report"/>">TopUp Reports</a></li>
                    </ul>
                </li>
                <li id="m03" class="dropdown <c:if test="${m03 eq true}">active</c:if>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Configs<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value="/Administration/SystemConfig/categories"/>">Categories</a></li>
                        <li><a href="<c:url value="/Administration/SystemConfig/lixiExchangeRate"/>">Lixi Exchange Rate</a></li>
                        <li><a href="<c:url value="/Administration/SystemFee/list"/>">Lixi Global Fee</a></li>
                        <li><a href="<c:url value="/Administration/SystemConfig/configs"/>">Lixi Configuration Parameters</a></li>
                    </ul>
                </li>
                <li id="m05" class="dropdown <c:if test="${m05 eq true}">active</c:if> ">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">System User <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<c:url value="/Administration/SystemUser/list"/>">User List</a></li>
                        <li><a href="<c:url value="/Administration/SystemUser/add"/>">Add New</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="javascript:void(0);"><b>Hello <security:authentication property="principal.username"/></b></a></li>
                <li><a href="javascript:void(0);">Help</a></li>
                <li class="active"><a href="javascript:void(0);">Profile<span class="sr-only">(current)</span></a></li>
                <li><a href="<c:url value="/Administration/logout"/>">Log Out</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>
