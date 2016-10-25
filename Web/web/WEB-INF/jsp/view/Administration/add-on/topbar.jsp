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
        <security:authorize access="hasAuthority('ACCESS_ADMINISTRATION')">
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li id="m01" <c:if test="${m01 eq true}">class="active"</c:if>><a href="<c:url value="/Administration/Dashboard"/>">Home</a></li>
                    <security:authorize access="hasAuthority('SYSTEM_SUPPORT_CONTROLLER')">
                    <li id="m07" class="dropdown<c:if test="${m07 eq true}"> active</c:if>">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Customer<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="<c:url value="/Administration/SystemSupport/list"/>">Issue List</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="<c:url value="/Administration/SystemSupport/management/self"/>">Management List</a></li>
                        </ul>
                    </li>
                    </security:authorize>
                    <security:authorize access="hasAuthority('SYSTEM_REPORT_CONTROLLER')">
                        <li id="m08" class="dropdown<c:if test="${m08 eq true}"> active</c:if>">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Reports <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                <security:authorize access="hasAuthority('TRANSACTION_MONITOR')">
                                    <li><a href="<c:url value="/Administration/TransactionMonitor/report"/>">Transaction Monitor</a></li>
                                    <li role="separator" class="divider"></li>
                                </security:authorize>
                                <security:authorize access="hasAuthority('TRANSACTION_REPORT')">
                                    <li><a href="<c:url value="/Administration/Orders/report"/>">Transaction Report</a></li>
                                    <li role="separator" class="divider"></li>
                                </security:authorize>
                                <security:authorize access="hasAuthority('BATCH_REPORT')">
                                    <li><a href="<c:url value="/Administration/SystemBatch/report"/>">Batch Report</a></li>
                                    <li role="separator" class="divider"></li>
                                </security:authorize>
                                <security:authorize access="hasAuthority('TOPUP_REPORT')">
                                    <li><a href="<c:url value="/Administration/SystemTopUp/report"/>">TopUp Report</a></li>
                                    <li role="separator" class="divider"></li>
                                </security:authorize>
                                <security:authorize access="hasAuthority('RECEIVER_REPORT')">
                                    <li><a href="<c:url value="/Administration/SystemRecipient/report"/>">Receiver Report</a></li>
                                    <li role="separator" class="divider"></li>
                                </security:authorize>
                                <security:authorize access="hasAuthority('SENDER_REPORT')">
                                    <li><a href="<c:url value="/Administration/SystemSender/report"/>">Sender Report</a></li>
                                </security:authorize>
                            </ul>
                        </li>
                    </security:authorize>
                    <security:authorize access="hasAuthority('SYSTEM_ORDERS_CONTROLLER')">
                    <li id="m02" class="dropdown<c:if test="${m02 eq true}"> active</c:if>">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Orders <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <security:authorize access="hasAuthority('NEW_ORDER_INFO/SEND_MONEY')">
                                <li><a href="<c:url value="/Administration/Orders/giftedOrders"/>">New Gifted Orders</a></li>
                                <li><a href="<c:url value="/Administration/Orders/newOrders?oStatus=UnSubmitted"/>">New Refund Orders</a></li>
                                <li><a href="<c:url value="/Administration/Orders/newOrders?oStatus=UnSubmitted"/>">New Order Info</a></li>
                                <li><a href="<c:url value="/Administration/Orders/sendMoneyInfo"/>">Order Send Money</a></li>
                                <li role="separator" class="divider"></li>
                                </security:authorize>
                                <security:authorize access="hasAuthority('LIST_UNSUBMITTED_TOPUP')">
                                <li><a href="<c:url value="/Administration/SystemTopUp/list"/>">List Un-Submitted TopUp</a></li>
                                </security:authorize>
                        </ul>
                    </li>
                    </security:authorize>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Products <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="<c:url value="/Administration/Products/redirect2List"/>">List of Products</a></li>
                            <li><a href="<c:url value="/Administration/Products/input/0"/>">Input Product</a></li>
                        </ul>
                    </li>
                    <security:authorize access="hasAuthority('ADMIN_CONTROL')">
                        <security:authorize access="hasAuthority('SYSTEM_CONFIG_CONTROLLER')">
                            <li id="m03" class="dropdown <c:if test="${m03 eq true}">active</c:if>">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Configs<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="<c:url value="/Administration/SystemConfig/categories"/>">Categories</a></li>
                                <li><a href="<c:url value="/Administration/SystemConfig/lixiExchangeRate"/>">Lixi Exchange Rate</a></li>
                                <li><a href="<c:url value="/Administration/SystemFee/list"/>">Lixi Global Fee</a></li>
                                <li><a href="<c:url value="/Administration/SystemConfig/configs"/>">Lixi Configuration Parameters</a></li>
                                <li><a href="<c:url value="/Administration/SystemConfig/shippingCharged"/>">Lixi Shipping Charged</a></li>
                                <li><a href="<c:url value="/Administration/SystemStatistic/product"/>">Product Statistic</a></li>
                            </ul>
                            </li>
                        </security:authorize>
                    <security:authorize access="hasAuthority('SYSTEM_USER_CONTROLLER')">
                    <li id="m05" class="dropdown <c:if test="${m05 eq true}">active</c:if> ">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">System User <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="<c:url value="/Administration/SystemUser/list"/>">User List</a></li>
                            <li><a href="<c:url value="/Administration/SystemUser/add"/>">Add New</a></li>
                        </ul>
                    </li>
                    </security:authorize>
                    </security:authorize>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="javascript:void(0);"><b>Hello <security:authentication property="principal.username"/></b></a></li>
                    <li><a href="javascript:void(0);">Help</a></li>
                    <li class="active"><a href="javascript:void(0);">Profile<span class="sr-only">(current)</span></a></li>
                    <li><a href="<c:url value="/Administration/logout"/>">Log Out</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </security:authorize>
    </div>
</nav>
