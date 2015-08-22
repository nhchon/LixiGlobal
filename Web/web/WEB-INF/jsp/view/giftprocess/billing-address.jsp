<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/billing-address.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="billing-address">
            <div class="container">
                <div class="row">
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                        <c:if test="${validationErrors != null}"><div class="msg msg-error">
                                <ul style="margin-bottom: 0px;">
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div></c:if>
                        <c:if test="${card_failed eq 1 || param.card_failed eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.checkout.card_failed"/>
                            </div>
                        </c:if>                        
                        <form:form class="form-horizontal" modelAttribute="billingAddressForm">
                            <fieldset>
                                <legend><spring:message code="ba.title"/></legend>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="fullname" class="control-label"><spring:message code="ba.full_name"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="fullName" class="form-control"/>
                                        <span class="help-block errors "><form:errors path="fullName" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="address-1" class="control-label"><spring:message code="ba.add1"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="add1" class="form-control" placeholder="" />
                                        <span class="help-block errors "><form:errors path="add1" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="address-2" class="control-label"><spring:message code="ba.add2"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="add2" class="form-control" placeholder="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="city" class="control-label"><spring:message code="ba.city"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="city" class="form-control" placeholder="" />
                                        <span class="help-block errors "><form:errors path="city" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="state" class="control-label"><spring:message code="ba.state"/></label>
                                    </div>
                                    <div class="col-lg-3 col-md-3">
                                        <form:input path="state" class="form-control" placeholder="" />
                                        <span class="help-block errors "><form:errors path="state" /></span>
                                    </div>
                                    <div class="col-lg-2 col-md-2">
                                        <label for="zip" class="control-label"><spring:message code="ba.zip"/></label>
                                    </div>
                                    <div class="col-lg-3 col-md-3">
                                        <form:input path="zipCode" class="form-control" placeholder="" />
                                        <span class="help-block errors "><form:errors path="zipCode" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="phone" class="control-label"><spring:message code="ba.phone"/></label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="phone" class="form-control" placeholder="" />
                                        <span class="help-block errors "><form:errors path="phone" /></span>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a href="choose-the-gift.html" class="btn btn-primary"><spring:message code="message.back"/></a>
                                        <button type="submit" class="btn btn-primary"><spring:message code="message.next"/></button>
                                    </div>
                                </div>
                            </fieldset>
                        </form:form>
                    </div>
                    <div class="col-lg-1 col-md-1 col-sm-1 hidden-xs"></div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>