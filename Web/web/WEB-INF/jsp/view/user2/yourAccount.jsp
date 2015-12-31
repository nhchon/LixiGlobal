<template:Client htmlTitle="Lixi Global - Your Account">
    
    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>
        
    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>
        
    <jsp:body>
        <section class="section-85-0">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <h1>Your Account</h1>
                        <c:if test="${editSuccess eq 1 || param.editSuccess eq 1}">
                            <div class="alert alert-success">
                                <spring:message code="message.user_edit_success"/>
                            </div>
                        </c:if>
                        <div class="row">
                            <div class="col-lg-4">
                                <h3 style="margin: 0px;padding: 0px;">Settings</h3>
                            </div>
                            <div class="col-lg-8">
                                <ul>
                                    <li><a href="<c:url value="/user/editName"/>">Edit your name</a></li>
                                    <li><a href="<c:url value="/user/editPassword"/>">Change password</a></li>
                                    <li><a href="<c:url value="/user/editEmail"/>">Change email</a></li>
                                    <li><a href="<c:url value="/user/editPhoneNumber"/>">Change mobile phone number</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>