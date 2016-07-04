<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-select/css/bootstrap-select.min.css"/>">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            var AJAX_CHECK_EXCEED_PATH = '<c:url value="/gifts/ajax/checkExceed"/>';
        </script>
        <script src = "<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-select/js/bootstrap-select.min.js"/>"></script>
        <script src="<c:url value="/resource/theme/assets/lixi-global/js/gifts.js"/>"></script>
    </jsp:attribute>

    <jsp:body>
        <c:import url="/categories"/>
        <section class="section-gift section-wrapper">
            <div class="container">
                <c:set var="localStep" value="4"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="section-gift-top">
                    <div class="row">
                        <div class="col-md-5" style="min-height: 384px;">
                            <div class="wrap_img_detail" style="min-height: 384px;">
                                <div class="img" style="min-height: 384px;vertical-align: baseline;text-align: center;">
                                    <img src="${p.imageUrl}" height="" style="vertical-align: middle;width: 100%;border: 0;">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="row">
                                <div class="col-md-12">
                                    <h2>${p.name}</h2>
                                </div>
                            </div>
                            <div class="row" style="margin-bottom: 20px;">
                                <div class="col-md-12">
                                    <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                                    <h4 class="title price">USD <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${p.price}" pattern="###,###.##"/></h4>
                                </div>
                            </div>
                            <div class="row" style="margin-bottom: 30px;">
                                <div class="col-md-2" style="padding-right: 0px;"><h4>Số lượng</h4></div>
                                <div class="col-md-10" style="padding-left: 0px;">
                                    <div class="gift-number-box" style="margin: inherit">
                                        <div class="input-group">
                                            <span class="input-group-btn">
                                                <button onclick="LixiGlobal.Gift.initSubBtn(this);" class="btn btn-default gift-sub-event" type="button"><i class="fa fa-chevron-down"></i></button>
                                            </span>
                                            <c:set var="quantity" value="1"/>
                                            <c:if test="${not empty p.quantity}"><c:set var="quantity" value="${p.quantity}"/></c:if>
                                            <input style="z-index: 0;" type="text" min="1" name="quantity" value="${quantity}" class="form-control bfh-number gift-number" buttons="false" max="10" placeholder="Number"/>
                                            <span class="input-group-btn">
                                                <button onclick="LixiGlobal.Gift.initAddBtn(this);"  class="btn btn-default gift-add-event" type="button"><i class="fa fa-chevron-up"></i></button>
                                            </span>
                                        </div><!-- /input-group -->
                                    </div>

                                </div>
                            </div>
                            <div class="reciper-box">
                                <div class="row">
                                    <div class="col-md-3"><h4>Người nhận</h4></div>
                                    <div class="col-md-5">
                                        <select class="selectpicker show-tick" data-live-search="true" data-style="btn-danger" data-width="100%">
                                            <option value="0"><spring:message code="select-a-rec"/></option>
                                            <c:forEach items="${RECIPIENTS}" var="rec">
                                                <option data-icon="glyphicon-user" value="${rec.id}">${rec.fullName}&nbsp;-&nbsp;${rec.phone}&nbsp;-&nbsp;${rec.email} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <button class="btn btn-default">Create New Receiver</button>
                                    </div>
                                </div>
                                <div class="reciper-break-line"></div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <button onclick="checkExceed(30, ${p.id}, 1)" class="btn btn-primary text-uppercase reciper-buy-gift">Buy Gift</button>
                                    </div>
                                    <div class="col-md-6" style="margin-top: 15px;color: #0090d0;font-weight: 400;">

                                        <span style="color: #696969;">Your order total</span><br/>
                                        <span class="gift-total-box-right">
                                            <span>USD</span>
                                            <span id="currentPaymentUSD">193.11</span>
                                            <span>~</span>
                                            <span>VND</span>
                                            <span id="currentPaymentVND">4,209,000</span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="break-line-default"></div>
                    <div class="product-detail-box">
                        <h2 class="product-detail-title">Thông Tin Sản Phẩm</h2>
                        <div class="product-detail-content">
                            ${p.description}
                        </div>
                    </div>
                    <div class="break-line-default"></div>
                    <div class="best-selling-product">
                        <h2 class="product-detail-title text-uppercase">Best selling products</h2>
                        <div class="best-selling-product-content">

                            <ul class="list-pd">
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/1412">
                                            <img alt="Bộ 5 gói kẹo hắc sâm Daedong Korea Ginseng Korean Black Ginseng Candy 250g" src="http://vn-live-02.slatic.net/p/bo-5-goi-keo-hac-sam-daedong-korea-ginseng-korean-black-ginseng-candy-250g-8224-5197031-1-product.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Bộ 5 gói kẹo hắc sâm Daedong Korea Ginseng Korean Black Ginseng Candy 250g</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 25.21 ~ VND 549,400</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/1412"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/1438">
                                            <img alt="Bộ 3 Gói Kẹo Hồng Sâm Daedong BulRoGeon 500g." src="http://vn-live-02.slatic.net/p/bo-3-goi-keo-hong-sam-daedong-bulrogeon-500g-3383-4170881-1-product.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Bộ 3 Gói Kẹo Hồng Sâm Daedong BulRoGeon 500g.</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 25.33 ~ VND 552,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/1438"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/1457">
                                            <img alt="Kẹo dẻo bổ sung chất xơ &amp; canxi cho bà bầu Vitafusion Fiber + Calcium 90 viên/ hộp" src="http://vn-live-03.slatic.net/p/keo-deo-bo-sung-chat-xo-and-canxi-cho-ba-bau-vitafusion-fiber-calcium-90-vien-hop-2371-617021-1-product.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Kẹo dẻo bổ sung chất xơ &amp; canxi cho bà bầu Vitafusion Fiber + Calcium 90 viên/ hộp</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 25.83 ~ VND 563,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/1457"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/1466">
                                            <img alt="Kẹo dẻo bổ sung chất xơ &amp; canxi cho bà bầu Vitafusion Fiber + Calcium 90 viên/ hộp" src="http://vn-live-03.slatic.net/p/keo-deo-bo-sung-chat-xo-and-canxi-cho-ba-bau-vitafusion-fiber-calcium-90-vien-hop-2371-617021-1-product.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Kẹo dẻo bổ sung chất xơ &amp; canxi cho bà bầu Vitafusion Fiber + Calcium 90 viên/ hộp</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 25.83 ~ VND 563,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/1466"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/1409">
                                            <img alt="Kẹo gum vị dâu và cam Trident Layers" src="http://vn-live-03.slatic.net/p/keo-gum-vi-dau-va-cam-trident-layers-5696-4851931-1-product.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Kẹo gum vị dâu và cam Trident Layers</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 26.29 ~ VND 573,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/1409"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/2736">
                                            <img alt="Combo Sô cô la đen 58% Chocolate Graphics túi 500g và Sô cô la nghệ thuật 1 viên Chocolate Graphics hộp 120g" src="https://cdn02.static-adayroi.com/resize/502_502/100/0/2016/01/22/1453453199849_7287309.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Combo Sô cô la đen 58% Chocolate Graphics túi 500g và Sô cô la nghệ thuật 1 viên Chocolate Graphics hộp 120g</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 26.47 ~ VND 577,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/2736"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/2760">
                                            <img alt="Combo Sô cô la đen 58% Chocolate Graphics túi 500g và Sô cô la nghệ thuật 1 viên Chocolate Graphics hộp 120g" src="https://cdn02.static-adayroi.com/resize/502_502/100/0/2016/01/22/1453453199849_7287309.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Combo Sô cô la đen 58% Chocolate Graphics túi 500g và Sô cô la nghệ thuật 1 viên Chocolate Graphics hộp 120g</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 26.47 ~ VND 577,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/2760"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/1437">
                                            <img alt="Bộ 4 bịch kẹo hắc sâm Daedong Korea Ginseng Korean Black Ginseng Candy 250g" src="http://vn-live-02.slatic.net/p/bo-4-bich-keo-hac-sam-daedong-korea-ginseng-korean-black-ginseng-candy-250g-8224-1487031-1-product.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Bộ 4 bịch kẹo hắc sâm Daedong Korea Ginseng Korean Black Ginseng Candy 250g</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 26.66 ~ VND 581,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/1437"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/1403">
                                            <img alt="Bộ 5 bịch Kẹo hồng sâm Hàn Quốc không đường 500g" src="http://vn-live-03.slatic.net/p/bo-5-bich-keo-hong-sam-han-quoc-khong-duong-500g-6241-4402421-1-product.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Bộ 5 bịch Kẹo hồng sâm Hàn Quốc không đường 500g</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 26.95 ~ VND 587,500</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/1403"><span></span></a>
                                </li>
                                <li>
                                    <div class="img">
                                        <a href="/Web/gifts/detail/2748">
                                            <img alt="Combo Sô cô la Galler (18 mini tablets) túi 144g và Sô cô la 3 viên Chocolate Graphics hộp 60g" src="https://cdn02.static-adayroi.com/resize/502_502/100/0/2016/01/22/1453455050943_4281972.jpg">
                                        </a>
                                    </div>
                                    <div style="height: 109px;" class="copy js-height">
                                        <p class="product_name">Combo Sô cô la Galler (18 mini tablets) túi 144g và Sô cô la 3 viên Chocolate Graphics hộp 60g</p>
                                        <h4 style="font-size: 0.8em;" class="title price">USD 27.12 ~ VND 591,000</h4>
                                    </div>
                                    <input type="hidden" id="product_stt" value="2">
                                    <a href="/Web/gifts/detail/2748"><span></span></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
        </section>
    </jsp:body>
</template:Client>