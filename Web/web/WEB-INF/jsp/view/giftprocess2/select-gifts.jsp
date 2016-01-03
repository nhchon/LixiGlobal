<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select Gifts">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/vendor/jquery.twbsPagination.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/gifts.js"/>"></script>
        <script type="text/javascript">
            /** Page Script **/
            var AJAX_LOAD_PRODUCTS_PATH = '<c:url value="/gifts/ajax/products"/>';
            var AJAX_CHECK_EXCEED_PATH = '<c:url value="/gifts/ajax/checkExceed"/>';
            var TOTAL_PAGES = ${PAGES.totalPages};
            // maximum is 2 pages
            if(TOTAL_PAGES > 2) TOTAL_PAGES = 2;
        </script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="section-gift bg-default section-wrapper">
            <div class="container">
                <c:set var="localStep" value="4"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="section-gift-top">
                    <h2 class="title">Gift value for ${SELECTED_RECIPIENT_NAME}</h2>
                    <p>( We will select only gift at your price range )</p>
                    <h5 class="maximum-purchase">Maximum purchase is VND <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * 250}" pattern="###,###.##"/> or USD 250</h5>
                    <div class="change-curency-box">
                        <div class="btn-group">
                            <button class="btn change-curency-box-des" type="button">
                                <span class="des-box">Your locked-in exchange rate</span>
                                <span class="amount-box">USD 1 = <strong><fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy}" pattern="###,###.##"/></strong> VND</span>
                            </button>
                            <button data-toggle="dropdown" class="btn dropdown-toggle" type="button">
                                <span class="flag flag-vn"></span>
                                <i class="fa fa-chevron-down"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li><a class="flag-link" href="#change-rate" rel="tooltip" title="English"><span class="flag flag-en"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="gift-filter gift-filter-wrapper">
                    <div class="gift-filter-control">
                        <div class="gift-filter-control-slide">
                            <c:set value="10" var="startPrice"/>
                            <c:if test="${not empty SELECTED_AMOUNT_IN_USD}">
                                <c:set value="${SELECTED_AMOUNT_IN_USD}" var="startPrice"/>
                            </c:if>
                            <input type="text" class="gift-filter-slider-input" value="" data-slider-min="10" data-slider-max="250" data-slider-step="5" data-slider-value="10"/>
                        </div>
                        <div class="gift-filter-label">
                            <span class="gift-filter-label-min">
                                <span class="gift-filter-label-usd">USD 10</span>
                                <span class="gift-filter-label-vn">VND <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * 10}" pattern="###,###.##"/></span>
                            </span>
                            <span class="gift-filter-label-max text-right">
                                <span class="gift-filter-label-usd">USD 250</span>
                                <span class="gift-filter-label-vn">VND <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * 250}" pattern="###,###.##"/></span>
                            </span>
                        </div>
                    </div>
                    <div class="gift-filter-items">
                        <h2 class="title">${SELECTED_LIXI_CATEGORY_NAME}</h2>
                        <div class="row" id="divProducts">
                            <%@include file="/WEB-INF/jsp/view/giftprocess2/ajax-products.jsp" %>
                        </div>
                        <div class="pagination-wrapper">
                            <ul id="pagination-data" class="pagination-sm"></ul>
                        </div>
                        <div class="clean-paragraph"></div>
                        <div class="button-control gift-total-wrapper text-center text-uppercase">
                            <div class="gift-total-box">
                                <span class="gift-total-box-left">order Total</span>
                                <span class="gift-total-box-right">
                                    <span>usd</span>
                                    <span id="currentPaymentUSD"><fmt:formatNumber value="${CURRENT_PAYMENT_USD}" pattern="###,###.##"/></span>
                                    <span>~</span>
                                    <span>VND</span>
                                    <span id="currentPaymentVND"><fmt:formatNumber value="${CURRENT_PAYMENT}" pattern="###,###.##"/></span>
                                </span>
                            </div>
                            <div class="button-control-page">
                                <button class="btn btn-default">BACK</button>
                                <button class="btn btn-primary btn-has-link-event"  type="button" data-link="<c:url value="/gifts/order-summary"/>">NEXT</button>
                                <input type="hidden" id="recId" value="${SELECTED_RECIPIENT_ID}"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>