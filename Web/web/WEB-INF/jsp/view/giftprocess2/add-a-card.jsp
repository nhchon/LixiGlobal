<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="LiXi Global - Add A Card">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="main-section bg-default">
            <div class="container">
                <c:set var="localStep" value="6"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                    <c:if test="${not empty validationErrors}">
                    <div class="alert alert-warning alert-dismissible bg-white" role="alert">
                        <div class="alert-message">
                            <h4 class="text-red">There was problem</h4>
                            <c:forEach items="${validationErrors}" var="error">
                                <div><c:out value="${error.message}" /></div>
                            </c:forEach>
                        </div>
                    </div>
                    </c:if>
                    <c:if test="${(not empty authorizeError) and (authorizeError ne 'OK')}">
                    <div class="alert alert-warning alert-dismissible bg-white" role="alert">
                        <div class="alert-message">
                            ${authorizeError}
                        </div>
                    </div>
                    </c:if>
                    <c:if test="${expiration_failed eq 1}">
                        <div class="msg msg-error">
                            <spring:message code="validate.checkout.exp_date"/>
                        </div>
                    </c:if>
                <form:form modelAttribute="addCardForm" cssClass="form-add-a-payment">
                    <h2 class="title">add a payment menthod</h2>
                    <div class="form-content">
                        <div class="form-group">
                            <div class="cc-selector-2">
                                <span title="Visa Card">
                                    <label class="drinkcard-cc visa" for="visa2"></label>
                                </span>
                                <span title="Disover Card">
                                    <label class="drinkcard-cc disover" for="disover"></label>
                                </span>
                                <span title="Master Card">
                                    <label class="drinkcard-cc mastercard"for="mastercard2"></label>
                                </span>
                                <span title="Card">
                                    <label class="drinkcard-cc card-type2"for="card-type2"></label>
                                </span>
                            </div>
                        </div>
                        <h4 class="text-color-link text-uppercase">Card details</h4>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group form-group-selectpicker-full">
                                    <label for="cardType">Select Card Type:</label>
                                    <div class="clearfix"></div>
                                    <form:select path="cardType" class="form-control" required="true">
                                        <option value="">Select a Card Type</option>
                                        <option value="1">Visa</option>
                                        <option value="2">Master Card</option>
                                        <option value="3">Discover</option>
                                        <option value="4">Amex</option>
                                    </form:select>
                                    <div class="has-error"><form:errors path="cardType" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="cardNumber">Card Number:</label>
                                    <form:input path="cardNumber" required="true" class="form-control" placeholder="Card Number"/>
                                    <div class="has-error"><form:errors path="cardNumber" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="nameOnCard">Name on Card:</label>
                                    <form:input path="cardName" required="true" class="form-control" placeholder="Your name, as it appears on card"/>
                                    <div class="has-error"><form:errors path="cardName" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="expirationDate">Expiration Month</label>
                                    <form:select path="expMonth" class="form-control" required="true">
                                        <option value="">Exp. Month</option>
                                        <option value="01">Jan</option>
                                        <option value="02">Feb</option>
                                        <option value="03">Mar</option>
                                        <option value="04">Apr</option>
                                        <option value="05">May</option>
                                        <option value="06">Jun</option>
                                        <option value="07">Jul</option>
                                        <option value="08">Aug</option>
                                        <option value="09">Sep</option>
                                        <option value="10">Oct</option>
                                        <option value="11">Nov</option>
                                        <option value="12">Dec</option>
                                    </form:select>
                                    <div class="has-error"><form:errors path="expMonth" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="expirationDate">Expiration Year</label>
                                    <form:select path="expYear" class="form-control" required="true">
                                        <option value="">Exp. Year</option>
                                        <jsp:useBean id="now" class="java.util.Date" />
                                        <fmt:formatDate var="currYear" value="${now}" pattern="yyyy" />
                                        <c:forEach begin="${currYear}" end="${currYear + 10}" var="year">
                                            <option value="${year}">${year}</option>
                                        </c:forEach>
                                    </form:select>
                                    <div class="has-error"><form:errors path="expYear" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="cvv">CVV:</label>
                                    <form:input path="cvv" class="form-control" required="true" placeholder="CCV number"/>
                                    <div class="has-error"><form:errors path="cvv" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>

                        </div>
                        <h4 class="text-color-link text-uppercase">Billing address</h4>
                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="streetAddress">First Name:</label>
                                    <form:input path="firstName" class="form-control" required="true" placeholder="Street address"/>
                                    <div class="has-error"><form:errors path="firstName" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="city">Last Name:</label>
                                    <form:input path="lastName"  class="form-control" required="true" placeholder="City"/>
                                    <div class="has-error"><form:errors path="lastName" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8 col-sm-8">
                                <div class="form-group">
                                    <label for="streetAddress">Street Address:</label>
                                    <form:input path="address" class="form-control" required="true" placeholder="Street address"/>
                                    <div class="has-error"><form:errors path="address" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="city">City:</label>
                                    <form:input path="city"  class="form-control" required="true" placeholder="City"/>
                                    <div class="has-error"><form:errors path="city" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="state">State/Province/Region:</label>
                                    <form:input path="state" class="form-control" required="true" placeholder="State/Province/Region"/>
                                    <div class="has-error"><form:errors path="state" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="zipCode">Zip:</label>
                                    <form:input path="zipCode" class="form-control" required="true" placeholder="Zip code"/>
                                    <div class="has-error"><form:errors path="zipCode" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group form-group-selectpicker-full">
                                    <label for="county">County:</label><div class="clearfix"></div>
                                    <form:select class="form-control" path="country" required="true">
                                        <option value="">Choose country</option>
                                        <option value="USA" selected="">USA</option>
                                        <option value="Vietnam">Vietnam</option>
                                    </form:select>
                                    <div class="has-error"><form:errors path="country" cssClass="help-block" element="div"/></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="button-control text-center text-uppercase">
                        <div class="button-control-page">
                            <button class="btn btn-default btn-has-link-event" type="button" data-link="<c:url value="${returnUrl}"/>">BACK</button>
                            <button class="btn btn-primary" type="submit">NEXT</button>
                        </div>
                    </div>
                    <div class="clearfix border-bottom"></div>
                    <h4 class="title">add a bank account</h4>
                    <p>
                        <strong class="text-color-link"><a href="<c:url value="/checkout/addBankAccount"/>">Add a checking account</a></strong>.(You can review your order before it’s final)
                    </p>
                </form:form>
            </div>
        </section>

    </jsp:body>
</template:Client>