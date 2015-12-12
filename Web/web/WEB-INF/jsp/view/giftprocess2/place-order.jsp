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
        <section class="section-gift bg-default main-section">
            <div class="container">
                <c:set var="localStep" value="7"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <form method="post" class="receiver-form">
                    <div class="section-receiver">
                        <h2 class="title">review your order</h2>
                        <p class="text-uppercase">Thank you for being a customer!  </p>
                        <div class="clean-paragraph"></div>
                        <div class="receiver-info-wrapper">
                            <div class="receiver-info-items">
                                <div class="receiver-info-item">
                                    <div class="receiver-sent-to">
                                        <h4 class="text-color-link">Send To: ABC <a href="#" class="edit-info-event"></a></h4>
                                        <div>
                                            <strong>Email Address:</strong><span>ABC@gmail.com</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                        <div>
                                            <strong>Mobile Phone:</strong><span>280-521-9190</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                    </div>
                                    <div class="receiver-order-summary">
                                        <h4>Order summary</h4>
                                        <div>
                                            <strong>Madewell skirt</strong>
                                            <span>USD $ 39.00 ~ VND 800,000</span>
                                            <a href="#" class="edit-info-event"></a>
                                            <span>( gift / more recipient )</span>
                                        </div>
                                        <div>
                                            <strong>Madewell skirt</strong>
                                            <span>USD $ 39.00 ~ VND 800,000</span>
                                            <a href="#" class="edit-info-event"></a>
                                            <span>( gift / more recipient )</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="receiver-info-item">
                                    <div class="receiver-sent-to">
                                        <h4 class="text-color-link">Send To: ABC <a href="#" class="edit-info-event"></a></h4>
                                        <div>
                                            <strong>Email Address:</strong><span>ABC@gmail.com</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                        <div>
                                            <strong>Mobile Phone:</strong><span>280-521-9190</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                    </div>
                                    <div class="receiver-order-summary">
                                        <h4>Order summary</h4>
                                        <div>
                                            <strong>Madewell skirt</strong>
                                            <span>USD $ 39.00 ~ VND 800,000</span>
                                            <a href="#" class="edit-info-event"></a>
                                            <span>( gift / more recipient )</span>
                                        </div>
                                        <div>
                                            <strong>Madewell skirt</strong>
                                            <span>USD $ 39.00 ~ VND 800,000</span>
                                            <a href="#" class="edit-info-event"></a>
                                            <span>( gift / more recipient )</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="receiver-info-item">

                                    <div class="receiver-order-item">
                                        <div class="receiver-order-gift-price">
                                            <div>
                                                <strong class="receiver-order-gift-price-left text-bold">Gift Price</strong><span class="receiver-order-gift-price-right">USD $ 78.00 ~ VND 1,600,000</span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left">Card Processing fee</strong><span class="receiver-order-gift-price-right">USD $ 03.46</span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left">Lixi handing fee</strong><span class="receiver-order-gift-price-right">USD $ 02.00 ( per / person )</span>
                                            </div>
                                            <div>
                                                <strong class="receiver-order-gift-price-left text-bold">Total</strong><strong class="receiver-order-gift-price-right text-bold">USD $ 99.62</strong>
                                            </div>
                                        </div>
                                        <h4 class="text-color-link">Payment method</h4>
                                        <div>
                                            <strong>Visa:</strong><span>ending with 4242</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                        <div>
                                            <strong>Order #:</strong><span>21591</span> <a href="#" class="edit-info-event"></a>
                                        </div>
                                        <div>
                                            <strong>Billing address:</strong><span>abc</span>
                                        </div>
                                    </div>
                                    <div class="receiver-order-item">
                                        <div class="row">
                                            <div class="col-md-4">

                                                <span class="receiver-order-item-left">
                                                    <input type="checkbox" checked="checked"  class="custom-checkbox-input"/>
                                                    Gift only
                                                </span>
                                                <span class="receiver-order-item-left">
                                                    ( Do not allow refund to receiver )
                                                </span>
                                            </div>
                                            <div class="col-md-4">
                                                <span class="receiver-order-item-left">
                                                    <input type="checkbox" checked="checked" class="custom-checkbox-input"/>
                                                    Allow refund to receiver if so choise
                                                </span>
                                            </div>
                                        </div>
                                        <p>( Receiver will be notified right away! Delivery varies: settlement will be 24 to 72 hours. )</p>
                                        <p>By placing your order, you agree to LIXI.GLOBAL <a href="#">private</a> notice and <a target="_blank" href="term-of-user.html">term of use</a>.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="button-control gift-total-wrapper text-center text-uppercase" style="padding-bottom: 20px;">
                        <div class="button-control-page">
                            <button class="btn btn-default btn-has-link-event" type="button" data-link="order-summary.html">Cancel</button>
                            <button class="btn btn-primary btn-has-link-event"data-link="send-gift.html">Place Order</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>

    </jsp:body>
</template:Client>