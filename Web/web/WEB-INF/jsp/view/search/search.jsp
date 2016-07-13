<template:Client htmlTitle="Lixi Global - Search Result">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            jQuery(document).ready(function () {
                loadTotalCurrentOrder();
            });
            function jump(page) {
                $('#sPage').val(page);
                $('#searchForm').submit();
            }
        </script>
    </jsp:attribute>

    <jsp:body>
        <!-- Page Content -->
        <c:import url="/categories"/>
        <section class="section-gift bg-default main-section">
            <div class="container">
                <div class="section-gift-top">
                    <h2 class="title"><spring:message code="search-result-title"/></h2>
                    <div class="row">
                        <div class="col-md-12">
                            <c:if test="${not empty PRODUCTS}">
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
                                    <nav>
                                        <ul class="pagination pull-right">
                                            <%--
                                            <c:set var="numPage" value="${PAGES.totalPages}"/>
                                            <c:if test="${PAGES.totalPages < 5}">
                                                <c:set var="numPage" value="${PAGES.totalPages}"/>
                                            </c:if>
                                            --%>
                                            <c:set value="" var="previousCss"/>
                                            <c:set value="" var="previousFunc"/>
                                            <c:if test="${PAGES.number eq 0}">
                                                <c:set value="disabled" var="previousCss"/>
                                                <c:set value="void(0)" var="previousFunc"/>
                                            </c:if>
                                            <c:if test="${PAGES.number > 0}">
                                                <c:set value="jump(${PAGES.number})" var="previousFunc"/>
                                            </c:if>
                                            
                                            <li class="${previousCss}">
                                                <a href="javascript:${previousFunc};" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="1" end="${PAGES.totalPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${(i - 1) == PAGES.number}">
                                                        <li class="active">
                                                            <a href="javascript:void(0)">${i}</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li>
                                                            <a href="javascript:jump(${i})">${i}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:set value="" var="nextCss"/>
                                            <c:set value="" var="nextFunc"/>
                                            <c:if test="${(PAGES.number+1) eq PAGES.totalPages}">
                                                <c:set value="disabled" var="nextCss"/>
                                                <c:set value="void(0)" var="nextFunc"/>
                                            </c:if>
                                            <c:if test="${(PAGES.number+1) < PAGES.totalPages}">
                                                <c:set value="jump(${PAGES.number + 2})" var="nextFunc"/>
                                            </c:if>
                                            <li class="${nextCss}">
                                                <a href="javascript:${nextFunc};" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>

                            </c:if>
                            <c:if test="${empty PRODUCTS}">
                                <p>&nbsp;</p>
                                <h4><spring:message code="curr-no-result"/></h4>
                                <p>&nbsp;</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <form role="form" id="searchForm" action="<c:url value="/Search/search"/>" method="get">
                <input type="hidden" name="search" value="true" />
                <input type="hidden" name="keyword" value="${KEYWORD}" />
                <input type="hidden" name="paging.page" id="sPage" value="1"/>
                <input type="hidden" name="paging.size" id="sSize" value="10"/>
            </form>
        </section>

    </jsp:body>
</template:Client>