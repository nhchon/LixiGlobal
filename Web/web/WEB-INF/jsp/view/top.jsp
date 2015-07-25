<section id="header">
    <div class="container">
        <div class="row">
            <a id="logo" href="<c:url value="/"/>"><img alt="Logo" src="<c:url value="/resource/theme/assets/lixiglobal/img/logo.png"/>" /></a>
            <a id="menu-toggle"><i class="fa fa-bars"></i></a>
            <ul id="menu-items">
                <c:if test="${not empty LOGIN_EMAIL}">
                    <li class="hidden-sm"><a class="welcome">Welcome ${LOGIN_EMAIL}</a></li>
                    <li class="separator hidden-sm"><span>|</span></li>
                    <li><a href="recipient.html">Send a Gift</a></li>
                    <li class="separator"><span>|</span></li>
                    <li><a href="my-account.html">Your Account</a></li>
                    <li class="separator hidden-sm"><span>|</span></li>
                    <li class="hidden-sm"><a href="help.html">Help</a></li>
                    <li class="separator hidden-sm"><span>|</span></li>
                    <li class="hidden-sm"><a href="<c:url value="/user/signOut"/>">Sign Out</a></li>
                </c:if>
                <c:if test="${empty LOGIN_EMAIL}">
                <li><a href="<c:url value="/user/signIn"/>"><spring:message code="message.sign_in"/></a></li>
                </c:if>
                <li class="languages">
                    <a><spring:message code="message.tieng_viet"/></a>
                    <a class="active"><spring:message code="message.english"/></a>
                </li>
            </ul>
        </div>
    </div>
</section>