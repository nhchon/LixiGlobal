<c:forEach items="${PRODUCTS}" var="p" varStatus="theCount">
    <div class="col-md-3 col-sm-4 col-xs-6 col-for-five gift-product-item-col" id="product${p.id}" style="opacity:.99">
        <div class="gift-product-item text-center" id="gift-product-item-${p.id}">
            <c:set var="zoomPosition" value="1"/>
            <c:choose>
                <c:when test="${theCount.count eq 4}">
                   <c:set var="zoomPosition" value="11"/>
                </c:when>
                <c:when test="${theCount.count eq 5}">
                    <c:set var="zoomPosition" value="11"/>
                </c:when>
                <c:when test="${theCount.count eq 9}">
                    <c:set var="zoomPosition" value="11"/>
                </c:when>
                <c:when test="${theCount.count eq 10}">
                    <c:set var="zoomPosition" value="11"/>
                </c:when>
            </c:choose>
            <c:set var="imageFullSize" value="${p.imageUrl}"/>
            <c:if test="${not empty p.imageFullSize}"><c:set var="imageFullSize" value="${p.imageFullSize}"/></c:if>
            <div title="${p.name}"  class="gift-product-thumb" zoomWindowPosition="${zoomPosition}" src="${p.imageUrl}" data-zoom-image="${imageFullSize}" style="background: url(${p.imageUrl}) no-repeat scroll center center transparent;"> </div>
            <h4 class="title" title="${p.name}" style="font-size: 0.8em;">${p.name}</h4>
            <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
            <h4 class="title price" style="font-size: 0.8em;">USD <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${p.price}" pattern="###,###.##"/></h4>
            <div class="gift-number-box">
                <div class="input-group text-center">
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
            <div class="button-control">
                <button class="btn btn-default title buy btn-buy-item-event"><spring:message code="message.buy"/></button>
            </div>
            <span class="gift-item-checkbox" style="z-index: 1001;">
                <input type="checkbox" class="custom-checkbox-input" onclick="LixiGlobal.Gift.chooseGiftItem(this);" name="item" id="item${p.id}" value="${p.id}" <c:if test="${p.selected eq true}">checked</c:if>/>
            </span>
        </div>
    </div>
</c:forEach>
<input type="hidden" id="newTotalPages" value="${PAGES.totalPages}"/>
