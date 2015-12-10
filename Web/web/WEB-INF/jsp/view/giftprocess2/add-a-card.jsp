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
                <form method="post" class="form-add-a-payment">
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
                                    <select class="selectpicker">
                                        <option value="">Select a Card Type</option>
                                        <option value="1">Visa</option>
                                        <option value="2">Master Card</option>
                                        <option value="3">Discover</option>
                                        <option value="4">Amex</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="cardNumber">Card Number:</label>
                                    <input class="form-control" id="cardNumber" name="cardNumber" placeholder="Card Number"/>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="nameOnCard">Name on Card:</label>
                                    <input class="form-control" id="nameOnCard" name="nameOnCard" placeholder="Your name, as it appears on card"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="expirationDate">Expiration Month</label>
                                    <select name="expiry_month" id="creditCcMonthField" class="form-control">
                                        <option value="" selected="selected">Exp. Month</option>
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
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="expirationDate">Expiration Year</label>
                                    <select name="expiry_year" id="creditCcYearField" class="form-control">
                                        <option value="" selected="selected">Exp. Year</option>
                                        <jsp:useBean id="now" class="java.util.Date" />
                                        <fmt:formatDate var="currYear" value="${now}" pattern="yyyy" />
                                        <c:forEach begin="${currYear}" end="${currYear + 10}" var="year">
                                            <option value="${year}">${year}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="cvv">CVV:</label>
                                    <input class="form-control" id="cvv" required="true" name="cvv" placeholder="CCV number"/>
                                </div>
                            </div>

                        </div>
                        <h4 class="text-color-link text-uppercase">Billing address</h4>
                        <div class="row">
                            <div class="col-md-8 col-sm-8">
                                <div class="form-group">
                                    <label for="streetAddress">Street Address:</label>
                                    <input class="form-control" id="streetAddress" required="true" name="streetAddress" placeholder="Street address"/>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="city">City:</label>
                                    <input class="form-control" id="city" required="true" name="city" placeholder="City"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="state">State/Province/Region:</label>
                                    <input class="form-control" id="state" required="true" name="state" placeholder="State/Province/Region"/>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group">
                                    <label for="zipCode">Zip:</label>
                                    <input class="form-control" id="zipCode" required="true" name="zipCode" placeholder="Zip code"/>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group form-group-selectpicker-full">
                                    <label for="county">County:</label><div class="clearfix"></div>
                                    <select class="selectpicker" name="country">
                                        <option value="">Choose country</option>
                                        <option value="USA">USA</option>
                                        <option value="Vietnam">Vietnam</option>
                                    </select>
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
                </form>
            </div>
        </section>

    </jsp:body>
</template:Client>