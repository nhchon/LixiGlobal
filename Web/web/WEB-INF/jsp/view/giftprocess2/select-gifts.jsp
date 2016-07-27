<template:Client htmlTitle="Lixi Global - Select Gifts">
    <jsp:attribute name="extraHeadContent">
        <script language="javascript" src="https://d1cr9zxt7u0sgu.cloudfront.net/crfp.js?SITE_ID=2b57448f3013fc513dcc7a4ab933e6928ab74672&SESSION_ID=${pageContext.session.id}&TYPE=JS" type="text/javascript" charset="UTF-8"></script>
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var AJAX_LOAD_PRODUCTS_PATH = '<c:url value="/gifts/ajax/products"/>';
            $(document).ready(function () {
            });
        </script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/gifts.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="section-gift section-wrapper">
            <div class="container">
                <c:set var="localStep" value="4"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="section-gift-top" style="padding-top:0px;">
                    <div class="change-curency-box">
                        <div class="btn-group">
                            <button class="btn change-curency-box-des" type="button">
                                <span class="des-box"><spring:message code="locked-exchange-rate"/></span>
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
                        <c:set value="150" var="maximumValue"/>
                        <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * maximumValue}" pattern="###,###.##" var="maximumValueVnd"/>
                        <h5 class="maximum-purchase">
                            <spring:message code="maximum-purchase" arguments="${maximumValueVnd};${maximumValue}" argumentSeparator=";"/>
                            <br/>
                            <spring:message code="index-4-1"/>
                            <%--Maximum purchase is VND ${maximumValueVnd}  or USD ${maximumValue}--%>
                        </h5>
                    </div>
                </div>
                <div class="gift-filter gift-filter-wrapper">
                    <div class="gift-border-title">
                        <h2 class="title text-center"><span style="color:#2E5A99"><spring:message code="select-price-range" text="Select Price Range"/></span></h2>
                    </div>
                    <div class="row">
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <div class="gift-filter-control">
                                <div class="gift-filter-control-slide">
                                    <c:set value="10" var="startPrice"/>
                                    <c:if test="${not empty SELECTED_AMOUNT_IN_USD}">
                                        <c:set value="${SELECTED_AMOUNT_IN_USD}" var="startPrice"/>
                                    </c:if>
                                    <input type="text" class="gift-filter-slider-input" value="" data-slider-min="10" data-slider-max="150" data-slider-step="5" data-slider-value="${SLIDE_START_PRICE}"/>
                                    <input type="hidden" id="catId" value="${SELECTED_LIXI_CATEGORY_ID}"/>
                                </div>
                                <div class="gift-filter-label">
                                    <span class="gift-filter-label-min">
                                        <span class="gift-filter-label-usd">USD 10</span>
                                        <span class="gift-filter-label-vn">VND <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * 10}" pattern="###,###.##"/></span>
                                    </span>
                                    <span class="gift-filter-label-max text-right">
                                        <span class="gift-filter-label-usd">USD 150</span>
                                        <span class="gift-filter-label-vn">VND <fmt:formatNumber value="${LIXI_EXCHANGE_RATE.buy * 150}" pattern="###,###.##"/></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="gift-filter-items" id="divProducts">
                        <h2 class="title">${SELECTED_LIXI_CATEGORY_NAME}</h2>
                        <div class="list_cate_product">
                            <ul class="list-pd">
                                <c:forEach items="${PRODUCTS}" var="p" varStatus="theCount">
                                    <li>
                                        <div class="img">
                                            <a href="<c:url value="/gifts/detail/${p.id}"/>">
                                                <img src="${p.imageUrl}" alt="${p.name}">
                                            </a>
                                        </div>
                                        <div class="copy js-height" style="height: 109px;">
                                            <p class="product_name">${p.name}</p>
                                            <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                                            <h4 class="title price" style="font-size: 0.8em;">USD <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${p.price}" pattern="###,###.##"/></h4>
                                        </div>
                                        <a href="<c:url value="/gifts/detail/${p.id}"/>"><span></span></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="break-line-default"></div>
                        <div class="pagination-wrapper">
                            <%@include file="/WEB-INF/jsp/view/giftprocess2/paging-gift.jsp" %>
                        </div>
                    </div>
                </div>
        </section>
    </jsp:body>
</template:Client>