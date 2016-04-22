<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Lixi Global - Blank Sample Page">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <%-- <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-categories.jsp" %> --%>
        <section class="section-gift bg-default section-wrapper">
            <div class="container">
                <c:set var="localStep" value="1"/>
                <%@include file="/WEB-INF/jsp/view/giftprocess2/inc-steps.jsp" %>
                <div class="gift-category">
                    <h2 class="title text-center"><span><spring:message code="mess.select-category"/></span></h2>
                    <div class="gift-category-content">
                        <div class="row">
                            <div class="col-md-3 col-sm-3">
                                <div class="gift-item">
                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.perfume.id}"/>"><div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-01.png"/>) no-repeat scroll 0% 0%"></div></a>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.perfume.id}"/>">${LIXI_CATEGORIES.perfume.english}</a></h2>
                                            <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.perfume.id}"/>">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="gift-item">
                                    <a href="<c:url value="/topUp"/>"><div class="gift-item-col-thumb" style="background: transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-03.png"/>) no-repeat scroll 0% 0%; min-height: 182px;"></div></a>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="<c:url value="/topUp"/>">MOBILE CARDS</a></h2>
                                            <div class="gift-item-col-content-link"><a href="<c:url value="/topUp"/>">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9 col-sm-9">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6">
                                        <div class="gift-item">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.cosmetics.id}"/>"><div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-04.png"/>) no-repeat scroll 0% 0%; min-height: 287px;"></div></a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.cosmetics.id}"/>">${LIXI_CATEGORIES.cosmetics.english}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.cosmetics.id}"/>">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="gift-item gift-item-text-on-left">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.candies.id}"/>"><div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-05.png"/>) no-repeat scroll 0% 0%"></div></a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.candies.id}"/>">${LIXI_CATEGORIES.candies.english}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.candies.id}"/>">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="gift-item gift-item-text-on-left">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.flowers.id}"/>"><div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-06.png"/>) no-repeat scroll 0% 0%"></div></a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.flowers.id}"/>">${LIXI_CATEGORIES.flowers.english}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.flowers.id}"/>">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="gift-item gift-item-text-on-right">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.jewelries.id}"/>"><div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-02.png"/>) no-repeat scroll 0% 0%"></div></a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.jewelries.id}"/>">${LIXI_CATEGORIES.jewelries.english}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.jewelries.id}"/>">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="gift-item gift-item-text-on-right gift-item-text-full">
                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.childrentoy.id}"/>"><div class="gift-item-col-thumb" style="background: url(<c:url value="/resource/theme/assets/lixi-global/images/img-07.png"/>)"></div></a>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.childrentoy.id}"/>">${LIXI_CATEGORIES.childrentoy.english}</a></h2>
                                            <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.childrentoy.id}"/>">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>