<c:forEach items="${PRODUCTS}" var="p" varStatus="theCount">
    <div class="col-md-3 col-sm-4 col-xs-6 col-for-five gift-product-item-col">
        <div class="gift-product-item text-center">
            <div title="${p.name}" class="gift-product-thumb" style="background: url(${p.imageUrl}) no-repeat scroll center center transparent;"> </div>
            <h4 class="title" title="${p.name}">${p.name}</h4>
            <c:set var="priceInUSD" value="${p.getPriceInUSD(LIXI_EXCHANGE_RATE.buy)}"/>
            <h4 class="title price">USD $ <fmt:formatNumber value="${priceInUSD}" pattern="###,###.##"/> ~ VND <fmt:formatNumber value="${p.price}" pattern="###,###.##"/></h4>
            <div class="gift-number-box">
                <div class="input-group text-center">
                    <span class="input-group-btn">
                        <button onclick="LixiGlobal.Gift.initSubBtn(this);" class="btn btn-default gift-sub-event" type="button"><i class="fa fa-chevron-down"></i></button>
                    </span>
                    <input readonly="" min="1" name="quantity" value="1" class="form-control gift-number" placeholder="Number">
                    <span class="input-group-btn">
                        <button onclick="LixiGlobal.Gift.initAddBtn(this);"  class="btn btn-default gift-add-event" type="button"><i class="fa fa-chevron-up"></i></button>
                    </span>
                </div><!-- /input-group -->
            </div>
            <div class="button-control">
                <button class="btn btn-default title buy btn-buy-item-event">Buy</button>
            </div>
            <span class="gift-item-checkbox">
                <input type="checkbox" class="custom-checkbox-input" onclick="LixiGlobal.Gift.chooseGiftItem(this);" name="item" value="${p.id}" <c:if test="${p.selected eq true}">checked</c:if>/>
                </span>
            </div>
        </div>
</c:forEach>
