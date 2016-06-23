<template:Client htmlTitle="Home - Lixi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
        </script>
    </jsp:attribute>

    <jsp:body>
        <c:set var="currentDate" value="<%=new java.util.Date()%>"/>
        <fmt:parseDate parseLocale="en_US" var="beginTetDateMilestone" value="Feb 1 00:00:00 GMT 2016" pattern="MMM dd HH:mm:ss z yyyy" />
        <fmt:parseDate parseLocale="en_US" var="endTetDateMilestone" value="Feb 12 00:00:00 GMT 2016" pattern="MMM dd HH:mm:ss z yyyy" />
        <fmt:parseDate parseLocale="en_US" var="beginValentinceDateMilestone" value="Feb 13 00:00:00 GMT 2016" pattern="MMM dd HH:mm:ss z yyyy" />
        <fmt:parseDate parseLocale="en_US" var="endValentinceDateMilestone" value="Feb 20 00:00:00 GMT 2016" pattern="MMM dd HH:mm:ss z yyyy" />
        <section class="section-slider section-slider-thumb text-right">
            <c:choose>
                <c:when test="${(currentDate ge beginTetDateMilestone) && (currentDate le endTetDateMilestone)}">
                    <img src="<c:url value="/resource/theme/assets/lixi-global/images/slider-tet.jpg"/>"/>
                </c:when>
                <c:when test="${(currentDate ge beginValentinceDateMilestone) && (currentDate le endValentinceDateMilestone)}">
                    <img src="<c:url value="/resource/theme/assets/lixi-global/images/slider-valentine.jpg"/>"/>
                </c:when>
                <c:otherwise>
                    <img src="<c:url value="/resource/theme/assets/lixi-global/images/slider.jpg"/>"/>
                </c:otherwise>
            </c:choose>
        </section>
        <section class="section-gift bg-default">
            <div class="container">
                <div class="section-gift-top">
                    <h2 class="text-center "><spring:message code="index-1"/><br/>
                        <strong><spring:message code="index-2"/></strong><br/> 
                        <spring:message code="index-3"/>&nbsp;<strong>USD 0.99<sup>*</sup></strong></h2>
                    <div class="change-curency-box">
                        <div class="btn-group">
                            <button class="btn change-curency-box-des" type="button">
                                <span class="des-box"><spring:message code="locked-exchange-rate"/></span>
                                <span class="amount-box">USD 1 = <strong><fmt:formatNumber value="${lastXr.buy}" pattern="###,###.##"/></strong> VND</span>
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
                <div class="section-gift-bottom text-center">
                    <div class="row">
                        <div class="col-md-3 col-sm-3">
                            <div class="gif-by-step">
                                <span class="fa-stack fa-6x fa-stack-gift">
                                    <i class="fa fa-circle fa-stack-2x text-primary"></i>
                                    <i class="fa fa-newspaper-o fa-stack-1x fa-stack-custom fa-inverse"></i>
                                </span>
                                <div class="clearfix"></div>
                                <h3><spring:message code="choose-the-gift-you-want"/></h3>
                                <small><sup>*</sup><spring:message code="index-4"/></small>
                                <small><sup>*</sup><spring:message code="index-4-1" text=""/></small>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1 col-xs-1 col-has-gift-arrow">
                            <div class="arrow-right">
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="gif-by-step">
                                <span class="fa-stack fa-6x fa-stack-gift">
                                    <i class="fa fa-circle fa-stack-2x text-primary"></i>
                                    <i class="fa fa-credit-card fa-stack-1x fa-stack-custom  fa-inverse"></i>
                                </span>
                                <div class="clearfix"></div>
                                <h3><spring:message code="index-5"/>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1 col-xs-1  col-has-gift-arrow">
                            <div class="arrow-right">
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="gif-by-step">
                                <span class="fa-stack fa-6x fa-stack-gift">
                                    <i class="fa fa-circle fa-stack-2x text-primary"></i>
                                    <i class="fa fa-send fa-stack-1x fa-stack-custom  fa-inverse"></i>
                                </span>
                                <div class="clearfix"></div>
                                <h3><spring:message code="index-6"/></h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="gift-category">
                    <h2 class="title text-center"><span><spring:message code="select-your-gift-category"/></span></h2>
                    <div class="gift-category-content">
                        <div class="row">
                            <div class="col-md-3 col-sm-3">
                                <div class="gift-item">
                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.perfume.id}"/>">
                                        <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-01.png"/>) no-repeat scroll 0% 0%"></div>
                                    </a>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.perfume.id}"/>">${LIXI_CATEGORIES.perfume.getName(pageContext.response.locale)}</a></h2>
                                            <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.perfume.id}"/>"><spring:message code="shop-now"/> <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="gift-item">
                                    <a href="<c:url value="/topUp"/>">
                                        <div class="gift-item-col-thumb" style="background: transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-03.png"/>) no-repeat scroll 0% 0%; min-height: 182px;"></div>
                                    </a>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="<c:url value="/topUp"/>">MOBILE CARDS</a></h2>
                                            <div class="gift-item-col-content-link"><a href="<c:url value="/topUp"/>"><spring:message code="shop-now"/> <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9 col-sm-9">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6">
                                        <div class="gift-item">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.cosmetics.id}"/>">
                                                <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-04.png"/>) no-repeat scroll 0% 0%; min-height: 287px;"></div>
                                            </a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.cosmetics.id}"/>">${LIXI_CATEGORIES.cosmetics.getName(pageContext.response.locale)}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.cosmetics.id}"/>"><spring:message code="shop-now"/> <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="gift-item gift-item-text-on-left">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.candies.id}"/>">
                                                <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-05.png"/>) no-repeat scroll 0% 0%"></div>
                                            </a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.candies.id}"/>">${LIXI_CATEGORIES.candies.getName(pageContext.response.locale)}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.candies.id}"/>"><spring:message code="shop-now"/> <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="gift-item gift-item-text-on-left">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.flowers.id}"/>">
                                                <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-06.png"/>) no-repeat scroll 0% 0%"></div>
                                            </a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.flowers.id}"/>">${LIXI_CATEGORIES.flowers.getName(pageContext.response.locale)}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.flowers.id}"/>"><spring:message code="shop-now"/> <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="gift-item gift-item-text-on-right">
                                            <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.jewelries.id}"/>">
                                                <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-02.png"/>) no-repeat scroll 0% 0%"></div>
                                            </a>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.jewelries.id}"/>">${LIXI_CATEGORIES.jewelries.getName(pageContext.response.locale)}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.jewelries.id}"/>"><spring:message code="shop-now"/> <i class="fa fa-chevron-right"></i></a></div>
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
                                    <a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.childrentoy.id}"/>">
                                        <div class="gift-item-col-thumb" style="background: url(<c:url value="/resource/theme/assets/lixi-global/images/img-07.png"/>)"></div>
                                    </a>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.childrentoy.id}"/>">${LIXI_CATEGORIES.childrentoy.getName(pageContext.response.locale)}</a></h2>
                                            <div class="gift-item-col-content-link"><a href="<c:url value="/gifts/choose/${LIXI_CATEGORIES.childrentoy.id}"/>"><spring:message code="shop-now"/> <i class="fa fa-chevron-right"></i></a></div>
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