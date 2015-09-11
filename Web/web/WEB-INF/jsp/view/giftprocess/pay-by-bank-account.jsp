<template:Client htmlTitle="LiXi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/pay-by-bank-account.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="pay-by-bank-account">
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
                        <form:form class="form-horizontal" modelAttribute="bankAccountAddForm">
                            <fieldset>
                                <legend>Add Bank Account</legend>
                                <img alt="guide" src="<c:url value="/resource/theme/assets/lixiglobal/img/us.bank.guide.jpg"/>" />
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="name" class="control-label">Name on account</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="name" class="form-control" placeholder="Type to enter text" />
                                        <span class="help-block errors"><form:errors path="name" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="bankRounting" class="control-label">Bank rounting number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="bankRounting" class="form-control" placeholder="9 digits" />
                                        <span class="help-block errors"><form:errors path="bankRounting" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="checkingAccount" class="control-label">Checking account number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="checkingAccount" class="form-control" placeholder="17 digits" />
                                        <span class="help-block errors"><form:errors path="checkingAccount" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="confCheckingAccount" class="control-label">Re-enter checking account number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="confCheckingAccount" class="form-control" placeholder="Type to enter text" />
                                        <span class="help-block errors"><form:errors path="confCheckingAccount" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="driverLicense" class="control-label">Driver's license number</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="driverLicense" class="form-control" placeholder="Type to enter text" />
                                        <span class="help-block errors"><form:errors path="driverLicense" /></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4 col-md-4">
                                        <label for="state" class="control-label">State</label>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <form:input path="state" class="form-control" placeholder="Type to enter text" />
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <div class="col-lg-12">
                                        <a href="<c:url value="/checkout/payment-method/change"/>" class="btn btn-primary"><spring:message code="message.back"/></a>
                                        <button type="submit" id="btnSubmit" class="btn btn-primary">Continue</button>
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