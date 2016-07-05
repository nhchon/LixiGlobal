<h2 class="title">${SELECTED_LIXI_CATEGORY_NAME}</h2>
<c:if test="${empty PRODUCTS}">
    <spring:message code="no-product-at-that-price" text="Sorry, we don’t have product at that price. Please try another category."/>
</c:if>
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
                    <%--<h3>Baskin Robbins</h3>--%>
                    <p class="product_name">${p.name}</p>
                    <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
                    <h4 class="title price" style="font-size: 0.8em;">USD <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${p.price}" pattern="###,###.##"/></h4>
                    <%--<p class="prize"><span>290.000<sup>đ</sup> - 330.000<sup>đ</sup></span></p>--%>
                </div>
                <input type="hidden" value="2" id="product_stt">
                <a href="<c:url value="/gifts/detail/${p.id}"/>"><span></span></a>
            </li>
        </c:forEach>
    </ul>
</div>
<div class="break-line-default"></div>
<div class="pagination-wrapper">
    <%@include file="/WEB-INF/jsp/view/giftprocess2/paging-gift.jsp" %>
</div>
</c:if>