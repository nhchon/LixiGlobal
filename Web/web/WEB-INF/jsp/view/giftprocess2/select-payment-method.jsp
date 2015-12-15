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
        <section class="bg-default main-section">
            <div class="container">
                <c:set var="localStep" value="6"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <c:if test="${wrong eq 1 || param.wrong eq 1}">
                <div class="alert alert-warning alert-dismissible bg-white" role="alert">
                    <div class="alert-message">
                        <spring:message code="validate.there_is_something_wrong"/>
                    </div>
                </div>
                </c:if>
                <form action="" method="post" class="receiver-form">
                    <div class="section-receiver">
                        <h2 class="title">Select a payment method</h2>

                        <div class="table-responsive table-select-payment table-responsive-mobi">
                            <table>
                                <thead>
                                    <tr>
                                        <th style="width: 60%; text-align: left;">your credit and debit cards</th>
                                        <th style="width: 20%">name of card </th>
                                        <th style="width: 20%">expires on</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td data-title="Card">
                                            <div>
                                                <input type="checkbox" class="custom-checkbox-input"/>
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-size-2-discover.png"/>"/>
                                                <span class="text-uppercase">Ending in 1408</span>
                                            </div>
                                        </td>
                                        <td data-title="Name" class="text-center">ABC</td>
                                        <td data-title="Expires on" class="text-center">
                                            11/10/2015
                                        </td>
                                    </tr>
                                    <tr>
                                        <td data-title="Card">
                                            <div>
                                                <input type="checkbox" class="custom-checkbox-input"/>
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-size-2-master-card.png"/>"/>
                                                <span class="text-uppercase">Ending in 1408</span>
                                            </div>
                                        </td>
                                        <td data-title="Name" class="text-center">ABC</td>
                                        <td  data-title="Expires on" class="text-center">
                                            11/10/2015
                                        </td>
                                    </tr>
                                    <tr>
                                        <td data-title="Card"> 
                                            <div>
                                                <input type="checkbox" class="custom-checkbox-input"/>
                                                <img src="<c:url value="/resource/theme/assets/lixi-global/images/icon-card-size-2-visa.png"/>"/>
                                                <span class="text-uppercase">Ending in 1408</span>
                                            </div>
                                        </td>
                                        <td data-title="Name" class="text-center">ABC</td>
                                        <td data-title="Expires on" class="text-center">
                                            11/10/2015
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p style="margin-top: 10px;">
                            <input type="checkbox" class="custom-checkbox-input"/> <span>Agree to our Term of Us*</span>
                        </p>
                    </div>
                    <div class="button-control text-uppercase">
                        <div class="row">
                            <div class="col-md-6 text-left">
                                <button class="btn btn-default btn-has-link-event text-uppercase" type="button" data-link="send-gift-receiver.html">Keep shopping</button>
                                <button class="btn btn-primary btn-has-link-event text-uppercase"  type="button" data-link="place-order.html">use this payment method</button>
                            </div>
                            <div class="col-md-6 text-right">
                                <button class="btn btn-primary btn-has-link-event text-uppercase" type="button" data-link="<c:url value="/checkout/addCard"/>">add new card</button>
                                <button class="btn btn-primary text-uppercase btn-has-link-event"  type="button" data-link="place-order.html">add new bank account</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>

    </jsp:body>
</template:Client>