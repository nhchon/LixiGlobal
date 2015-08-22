<template:Client htmlTitle="LiXi Global - Add a Card">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixiglobal/css/pay-by-card.css"/>" type="text/css" />
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <section id="pay-by-card">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <c:if test="${validationErrors != null}"><div class="msg msg-error">
                                <ul style="margin-bottom: 0px;">
                                    <c:forEach items="${validationErrors}" var="error">
                                        <li><c:out value="${error.message}" /></li>
                                        </c:forEach>
                                </ul>
                            </div></c:if>
                        <c:if test="${expiration_failed eq 1 || param.expiration_failed eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.checkout.exp_date"/>
                            </div>
                        </c:if>
                        <c:if test="${card_number_failed eq 1 || param.card_number_failed eq 1}">
                            <div class="msg msg-error">
                                <spring:message code="validate.checkout.card_in_use">
                                    <spring:argument value="${cardAddForm.cardNumber}"/>
                                </spring:message>
                            </div>
                        </c:if>
                        <form:form modelAttribute="cardAddForm">
                            <fieldset>
                                <legend><spring:message code="card.pay_by_card"/></legend>
                                <div class="form-group row">
                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                        <b><spring:message code="card.type"/></b>
                                    </div>
                                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                                        <ul id="types" class="list-unstyled">
                                            <li>
                                                <div class="radio">
                                                    <label>
                                                        <form:radiobutton path="cardType" class="lixi-radio" value="1"/>
                                                        <span class="lixi-radio"><span></span></span>
                                                        <span class="txt"><spring:message code="card.visa"/></span>
                                                    </label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="radio">
                                                    <label>
                                                        <form:radiobutton path="cardType" class="lixi-radio" value="2"/>
                                                        <span class="lixi-radio"><span></span></span>
                                                        <span class="txt"><spring:message code="card.master"/></span>
                                                    </label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="radio">
                                                    <label>
                                                        <form:radiobutton path="cardType" class="lixi-radio" value="3"/>
                                                        <span class="lixi-radio"><span></span></span>
                                                        <span class="txt"><spring:message code="card.discover"/></span>
                                                    </label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="radio">
                                                    <label>
                                                        <form:radiobutton path="cardType" class="lixi-radio" value="4"/>
                                                        <span class="lixi-radio"><span></span></span>
                                                        <span class="txt"><spring:message code="card.amex"/></span>
                                                    </label>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="desc">
                                    <b><spring:message code="card.cre_or_deb"/></b>
                                    <br />
                                    <spring:message code="card.accept_all_major"/>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                        <div class="form-group">
                                            <label class="control-label"><spring:message code="card.name_on_card"/></label>
                                            <form:input path="cardName" class="form-control" placeholder="" />
                                            <span class="help-block errors "><form:errors path="cardName" /></span>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-2 col-sm-6 col-xs-12">
                                        <div class="form-group">
                                            <label class="control-label"><spring:message code="card.number"/></label>
                                            <form:input path="cardNumber" class="form-control" placeholder="" />
                                            <span class="help-block errors "><form:errors path="cardNumber" /></span>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-1 col-sm-6 col-xs-12">
                                        <label class="control-label"><spring:message code="card.exp_date"/></label>
                                        <div class="form-group">
                                            <jsp:useBean id="now" class="java.util.Date" />
                                            <fmt:formatDate var="month" value="${now}" pattern="MM" />
                                            <fmt:formatDate var="year" value="${now}" pattern="yyyy" />
                                            <form:select path="expMonth" class="form-control">
                                                <c:forEach var="i" begin="1" end="12">
                                                    <option  value="${i}" <c:if test="${i == month}">selected</c:if>>${i}</option>
                                                </c:forEach>
                                            </form:select>
                                        </div>    
                                    </div>
                                    <div class="col-lg-2 col-md-1 col-sm-6 col-xs-12">
                                        <label class="control-label">&nbsp;</label>
                                        <form:select path="expYear" class="form-control">
                                            <c:forEach var="i" begin="0" end="10">
                                                <form:option value="${i + year}" label="${i + year}"/>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                    <div class="col-lg-1 col-md-2 col-sm-6 col-xs-12">
                                        <div class="form-group">
                                            <label class="control-label"><spring:message code="card.cvv"/></label>
                                            <form:input path="cvv" class="form-control"/>
                                            <span class="help-block errors "><form:errors path="cvv" /></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group right">
                                    <a href="review-cart.html" class="btn btn-primary"><spring:message code="message.back"/></a>
                                    <button type="submit" class="btn btn-primary"><spring:message code="card.add"/></button>
                                </div>
                            </fieldset>
                        </form:form>
                    </div>
                </div>
            </div>
        </section>

    </jsp:body>
</template:Client>