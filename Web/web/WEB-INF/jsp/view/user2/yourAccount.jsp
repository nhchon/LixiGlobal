<template:Client htmlTitle="Lixi Global - Your Account">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="main-section bg-default">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title"><spring:message code="mess.change-your-acc-setting"/></h2>
                    <div class="list-group-wrapper list-group-wrapper-user">
                        <div class="list-group-item-content">
                            <div class="row">
                                <div class="col-md-9 col-sm-9">
                                    <label><spring:message code="message.name"/>:</label><div class="clearfix"></div>
                                    <div><c:out value="${user.fullName}"/></div>
                                </div>
                                <div class="col-md-3 col-sm-3 text-right">
                                    <button class="btn btn-primary text-uppercase btn-has-link-event" data-link="<c:url value="/user/editName"/>"><spring:message code="message.edit"/></button>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item-content">
                            <div class="row">
                                <div class="col-md-9 col-sm-9">
                                    <label><spring:message code="message.email"/>:</label><div class="clearfix"></div>
                                    <div><c:out value="${user.email}"/></div>
                                </div>
                                <div class="col-md-3 col-sm-3 text-right">
                                    <button class="btn btn-primary text-uppercase btn-has-link-event" data-link="<c:url value="/user/editEmail"/>"><spring:message code="message.edit"/></button>
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item-content">
                            <div class="row">
                                <div class="col-md-9 col-sm-9">
                                    <label><spring:message code="message.mobile_number"/>:</label><div class="clearfix"></div>
                                    <div><c:out value="${user.phone}"/></div>
                                    <!--<div>Why verify your phone mobile?</div>-->
                                </div>
                                <div class="col-md-3 col-sm-3 text-right">
                                    <button class="btn btn-primary text-uppercase btn-has-link-event" data-link="<c:url value="/user/editPhoneNumber"/>"><spring:message code="message.edit"/></button><br/>
                                    <!--<button class="btn btn-default text-uppercase">Verify</button>-->
                                </div>
                            </div>
                        </div>
                        <div class="list-group-item-content">
                            <div class="row">
                                <div class="col-md-9 col-sm-9">
                                    <label><spring:message code="message.password"/>:</label><div class="clearfix"></div>
                                    <div>******</div>
                                </div>
                                <div class="col-md-3 col-sm-3 text-right">
                                    <button class="btn btn-primary text-uppercase btn-has-link-event" data-link="<c:url value="/user/editPassword"/>"><spring:message code="message.edit"/></button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>