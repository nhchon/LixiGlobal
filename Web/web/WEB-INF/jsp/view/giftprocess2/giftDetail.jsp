<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Select A Payment Method">

    <jsp:attribute name="extraHeadContent">
        <link rel="stylesheet" href="<c:url value="/resource/theme/assets/lixi-global/js/vendor/bootstrap-select/css/bootstrap-select.min.css"/>">
        <style>
            .wrap_img_detail {
                max-width: 460px;
                position: relative;
            }
            .wrap_img_detail .img {
                background: url(https://www.gotit.vn/layouts/v2/images/gradient_bg.jpg);
                background-size: 100% 100%;
                overflow: hidden;
                position: relative;
            }
            .bootstrap-select > .dropdown-toggle{
                background-color: #d9534f;
            }
            .tab-pd {
                padding-top: 40px;
                width: 100%;
                clear: both;
                overflow: hidden;
            }

            .tab-pd ul {
                width: 100%;
            }

            .tab-pd ul.list-tab {
                display: inline-block;
                float: left;
                position: relative;
                z-index: 10;
            }

            .tab-pd ul.list-tab li {
                display: inline-block;
                float: left;
                width: 270px;
                padding: 20px 0;
                background: #f7f7f7;
                font-size: 18px;
                color: #c1c1c1;
                border: 1px #f7f7f7 solid;
                border-radius: 10px 10px 0 0;
                border-bottom: none;
                text-align: center;
                font-family: 'RobotoMedium', 'Roboto';
                margin-right: 10px;
                cursor: pointer;
            }

            .tab-pd ul.list-tab li:hover,
            .tab-pd ul.list-tab li.active {
                border: 1px #e0e0e0 solid;
                border-bottom: 1px #fff solid;
                background: #fff;
                color: #413833;
            }

            .tab-pd .content-tab {
                width: 100%;
                clear: both;
                overflow: hidden;
                padding: 45px 40px;
                border: 1px #e0e0e0 solid;
                position: relative;
                z-index: 9;
                top: -1px;
            }

            .tab-pd .content-tab .tab {
                display: none;
            }

            .tab-pd .content-tab .tab:first-child {
                display: block;
            }

            .tab-pd .content-tab .tab p {
                font-size: 14px;
                padding-bottom: 10px;
                font-family: Roboto;
            }

            .tab-pd .content-tab .tab p span {
                font-size: 14px !important;
                font-family: 'Roboto' !important;
            }
        </style>
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
    <section class="section-gift bg-default section-wrapper">
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
                        <div class="row">
                            <div class="col-md-2" style="padding-right: 0px;"><h4>Người nhận</h4></div>
                            <div class="col-md-10" style="padding-left: 0px;">
                                <select class="selectpicker show-tick" data-live-search="true" data-style="btn-danger" data-width="100%">
                                    <option value="0"><spring:message code="select-a-rec"/></option>
                                    <c:forEach items="${RECIPIENTS}" var="rec">
                                        <option data-icon="glyphicon-user" value="${rec.id}">${rec.fullName}&nbsp;-&nbsp;${rec.phone}&nbsp;-&nbsp;${rec.email} </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2" style="padding-right: 0px;"></div>
                            <div class="col-md-5" style="padding-left: 0px;">
                                <button class="btn btn-danger">Edit Receiver Info</button>
                            </div>
                            <div class="col-md-5" style="text-align: right;">
                                <button class="btn btn-success">Create New Receiver</button>
                            </div>
                        </div>
                        <p>&nbsp;</p><p>&nbsp;</p>
                        <div class="row">
                            <div class="col-md-8">
                                <button onclick="checkExceed(30, ${p.id}, 1)" class="btn btn-primary" style="line-height: 60px;width: 280px;font-size: 24px;border-radius: 10px;">Buy</button>
                            </div>
                            <div class="col-md-4" style="text-align: center;margin-top: 15px;color: #0090d0;font-weight: 400;">

                                Your order total<br/>
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
                <div class="row">
                    <div class="col-md-12">
                        <div class="tab-pd">
                            <ul class="list-tab" style="margin-bottom: 0px;padding-left: 0px;">
                                <li data-tab="tab-1" class="active">Thông Tin Sản Phẩm</li>
                            </ul>
                            <div class="content-tab">
                                <div class="tab tab-1">
                                    <p>${p.description}</p>
                                </div>
                            </div>
                        </div>                                                
                    </div>
                </div>
            </div>
    </section>
</jsp:body>
</template:Client>