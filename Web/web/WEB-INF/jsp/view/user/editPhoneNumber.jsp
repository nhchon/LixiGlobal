<template:Client htmlTitle="LiXi Global - Edit Your Phone Number">

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
                        <c:if test="${validationErrors != null}"><div class="msg msg-error">
                                <ul>
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div></c:if>
                        <%-- place holder message --%>
                        <%-- // End place holder message --%>
                        <form class="form-horizontal" method="post" action="${pageContext.request.contextPath}/user/editPhoneNumber">
                            <fieldset>
                                <legend><spring:message code="message.change_mobile_number"/></legend>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label class="control-label"><spring:message code="message.mobile_number"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <input type="text" class="form-control" name="phone" id="phone" value="${phone}"/>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-4 col-md-4"></div>
                                    <div class="col-lg-8">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button id="btnSubmit" type="submit" class="btn btn-primary"><spring:message code="message.save_changes"/></button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>