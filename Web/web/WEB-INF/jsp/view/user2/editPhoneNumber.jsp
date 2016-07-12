<template:Client htmlTitle="Lixi Global - Edit Your Phone Number">

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
                    <c:if test="${validationErrors != null}"><div class="msg msg-error">
                            <ul>
                                <c:forEach items="${validationErrors}" var="error">
                                    <li><c:out value="${error.message}" /></li>
                                    </c:forEach>
                            </ul>
                        </div></c:if>
                    <%-- place holder message --%>
                    <%-- // End place holder message --%>
                    <c:url value="/user/editPhoneNumber" var="formEditPhoneNumberUrl"/>
                    <h2 class="title"><spring:message code="message.change_mobile_number"/></h2>
                    <form role="form" method="post" action="${formEditPhoneNumberUrl}">
                        <div class="form-group">
                            <div class="col-md-8" style="margin-bottom: 10px;">
                                <label class="control-label"><spring:message code="message.mobile_number"/></label>
                                <input type="text" class="form-control" name="phone" id="phone" value="<c:out value="${phone}"/>"/>
                            </div>
                        </div>
                        <div class="form-group right">
                            <div class="col-md-8">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="message.save_changes"/></button>
                                <button type="button" class="btn btn-warning btn-has-link-event" data-link="<c:url value="/user/yourAccount"/>"><spring:message code="message.cancel"/></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>