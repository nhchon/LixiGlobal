<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="LiXi Global - Select A Payment Method">

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
                    <h2 class="title">add a bank account</h2>
                    <div class="form-content">
                        <div class="form-group">
                            <div class="cc-selector-2">
                                <span title="Bank Account" class="checkImage">
                                </span>
                            </div>
                        </div>
                        <h4 class="text-color-link text-uppercase">Bank details</h4>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <div class="form-group form-group-selectpicker-full">
                                    <label for="cardType">Select Card Type:</label>
                                    <div class="clearfix"></div>
                                    <select id="accountTypeField" class="form-control" name="account_type">
                                        <option value="">Select Account Type</option>
                                        <option value="checking">Checking Account</option>
                                        <option value="savings">Savings Account</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="cardNumber">Routing Number:</label>
                                    <input class="form-control" id="cardNumber" name="cardNumber" placeholder="Card Number"/>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <div class="form-group">
                                    <label for="nameOnCard">Account number:</label>
                                    <input class="form-control" id="nameOnCard" name="nameOnCard" placeholder="Your name, as it appears on card"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8 col-sm-8">
                                <div class="form-group">
                                    <label for="cvv">Name on Account:</label>
                                    <input class="form-control" id="cvv" name="cvv" placeholder="CCV number"/>
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
                    <h4 class="title">add debit/credit card</h4>
                    <p>
                        <strong class="text-color-link"><a href="<c:url value="/checkout/addCard"/>">Add a new card</a></strong>.(You can review your order before it’s final)
                    </p>
                </form>
            </div>
        </section>
        
    </jsp:body>
</template:Client>